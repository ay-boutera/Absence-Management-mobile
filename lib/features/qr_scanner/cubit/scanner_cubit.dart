import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abs/features/qr_scanner/cubit/scanner_state.dart';

class ScannerCubit extends Cubit<ScannerState> {
  ScannerCubit() : super(const ScannerIdle());

  Future<void> onCodeDetected(String rawValue) async {
    if (state is! ScannerIdle) return;

    emit(const ScannerLoading());

    try {
      await Future.delayed(const Duration(seconds: 2));

      emit(ScannerSuccess());
    } on Exception catch (e) {
      emit(ScannerError(e.toString()));
    }
  }

  /// Resets back to idle so the next scan can be processed.
  void goBackToScanner() => emit(const ScannerIdle());
}
