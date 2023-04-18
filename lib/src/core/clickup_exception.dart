enum ClickUpExceptionType {
  invalidModel,
  invalidRequest,
  unauthorized
}

class ClickUpException implements Exception {
  ClickUpException({required this.exceptionType, required this.exceptionMessage});

  final ClickUpExceptionType exceptionType;
  final String exceptionMessage;
}
