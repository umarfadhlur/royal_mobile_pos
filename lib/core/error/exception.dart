class BadRequestException implements Exception{
    final String message;

  BadRequestException([this.message]);
}

class UnauthorizedException implements Exception{
  final String message;

  UnauthorizedException([this.message = 'User is unauthorized']);
}