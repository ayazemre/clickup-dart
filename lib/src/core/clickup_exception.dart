enum ClickUpExceptionType { invalidModel, requestError, unauthorized }

class ClickUpException implements Exception {
  ClickUpException(
      {required this.exceptionType, required this.exceptionMessage});

  final ClickUpExceptionType exceptionType;
  final String exceptionMessage;
}
