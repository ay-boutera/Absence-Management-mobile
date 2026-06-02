/// All possible states the QR scanner flow can be in.
sealed class ScannerState {
  const ScannerState();
}

/// Camera is ready and waiting for a scan.
final class ScannerIdle extends ScannerState {
  const ScannerIdle();
}

/// A code was detected and we are waiting for the API response.
final class ScannerLoading extends ScannerState {
  const ScannerLoading();
}

/// API responded — holds the structured result.
final class ScannerSuccess extends ScannerState {
  const ScannerSuccess();
}

/// A network or unexpected error occurred.
final class ScannerError extends ScannerState {
  const ScannerError(this.message);
  final String message;
}
