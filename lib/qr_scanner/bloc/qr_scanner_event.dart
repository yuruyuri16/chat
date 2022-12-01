part of 'qr_scanner_bloc.dart';

abstract class QrScannerEvent extends Equatable {
  const QrScannerEvent();

  @override
  List<Object> get props => [];
}

class QrScannerTorchToggled extends QrScannerEvent {}

class QrScannerCameraFacingToggled extends QrScannerEvent {}
