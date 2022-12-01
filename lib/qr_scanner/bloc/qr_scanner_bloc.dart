import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'qr_scanner_event.dart';
part 'qr_scanner_state.dart';

class QrScannerBloc extends Bloc<QrScannerEvent, QrScannerState> {
  QrScannerBloc() : super(const QrScannerState()) {
    on<QrScannerTorchToggled>(_onTorchToggled);
    on<QrScannerCameraFacingToggled>(_onCameraFacingToggled);
  }

  void _onTorchToggled(
    QrScannerTorchToggled event,
    Emitter<QrScannerState> emit,
  ) {
    emit(
      state.copyWith(
        torchState:
            state.torchState == TorchState.off ? TorchState.on : TorchState.off,
      ),
    );
  }

  void _onCameraFacingToggled(
    QrScannerCameraFacingToggled event,
    Emitter<QrScannerState> emit,
  ) {
    emit(
      state.copyWith(
        cameraFacing: state.cameraFacing == CameraFacing.back
            ? CameraFacing.front
            : CameraFacing.back,
      ),
    );
  }
}
