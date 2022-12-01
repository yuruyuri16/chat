import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:chat/qr_scanner/qr_scanner.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => QrScannerBloc(),
      child: const QrScannerView(),
    );
  }
}

class QrScannerView extends StatelessWidget {
  const QrScannerView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Place the QR code inside the area'),
            Text('Scanning will start automatically', style: textTheme.caption),
            const SizedBox(height: 16),
            const _QrScanner(),
            const _Options(),
          ],
        ),
      ),
    );
  }
}

class _QrScanner extends StatefulWidget {
  const _QrScanner();

  @override
  State<_QrScanner> createState() => _QrScannerState();
}

class _QrScannerState extends State<_QrScanner> {
  late final MobileScannerController controller;

  @override
  void initState() {
    super.initState();
    controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return MultiBlocListener(
      listeners: [
        BlocListener<QrScannerBloc, QrScannerState>(
          listenWhen: (previous, current) =>
              previous.torchState != current.torchState,
          listener: (_, __) => controller.toggleTorch(),
        ),
        BlocListener<QrScannerBloc, QrScannerState>(
          listenWhen: (previous, current) =>
              previous.cameraFacing != current.cameraFacing,
          listener: (_, __) => controller.switchCamera(),
        ),
      ],
      child: Align(
        child: SizedBox(
          width: size.width * 0.8,
          height: size.width * 0.8,
          child: MobileScanner(
            controller: controller,
            onDetect: (barcode, args) {
              final data = jsonDecode(
                barcode.rawValue!,
              ) as Map<String, dynamic>;
              context.popRoute<Map<String, dynamic>>(data);
            },
          ),
        ),
      ),
    );
  }
}

class _Options extends StatelessWidget {
  const _Options();

  @override
  Widget build(BuildContext context) {
    final torchState =
        context.select((QrScannerBloc bloc) => bloc.state.torchState);
    final cameraFacing =
        context.select((QrScannerBloc bloc) => bloc.state.cameraFacing);
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () =>
              context.read<QrScannerBloc>().add(QrScannerCameraFacingToggled()),
          icon: cameraFacing == CameraFacing.back
              ? const Icon(Icons.camera_rear)
              : const Icon(Icons.camera_front),
        ),
        IconButton(
          onPressed: () =>
              context.read<QrScannerBloc>().add(QrScannerTorchToggled()),
          icon: torchState == TorchState.off
              ? const Icon(Icons.flash_off)
              : const Icon(Icons.flash_on),
        ),
      ],
    );
  }
}
