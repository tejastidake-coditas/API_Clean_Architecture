abstract class Failure {
  final String message;
  Failure(this.message);
}

class RedirectionalError extends Failure {
  RedirectionalError() : super('Redirectional Error');
}

class ClientError extends Failure {
  ClientError() : super('Client Error');
}

class ServerError extends Failure {
  ServerError() : super('Server Error');
}

class CustomError extends Failure {
  CustomError(super.message);
}
