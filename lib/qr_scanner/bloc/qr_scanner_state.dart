part of 'qr_scanner_bloc.dart';

class QrScannerState extends Equatable {
  const QrScannerState({
    this.torchState = TorchState.off,
    this.cameraFacing = CameraFacing.back,
  });

  final TorchState torchState;
  final CameraFacing cameraFacing;

  @override
  List<Object> get props => [torchState, cameraFacing];

  QrScannerState copyWith({
    TorchState? torchState,
    CameraFacing? cameraFacing,
  }) {
    return QrScannerState(
      torchState: torchState ?? this.torchState,
      cameraFacing: cameraFacing ?? this.cameraFacing,
    );
  }
}
