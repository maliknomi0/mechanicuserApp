class AppException implements Exception {
  final String message;
  final String? details;

  AppException(this.message, [this.details]);

  @override
  String toString() {
    return "$message${details != null ? ': $details' : ''}";
  }
}

class BadRequestException extends AppException {
  BadRequestException(String message, [String? details]) : super(message, details);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(String message, [String? details]) : super(message, details);
}

class NotFoundException extends AppException {
  NotFoundException(String message, [String? details]) : super(message, details);
}

class InternalServerError extends AppException {
  InternalServerError(String message, [String? details]) : super(message, details);
}
