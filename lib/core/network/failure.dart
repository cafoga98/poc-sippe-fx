sealed class Failure {
  const Failure();

  const factory Failure.network() = NetworkFailure;
  const factory Failure.server(int statusCode) = ServerFailure;
  const factory Failure.parsing() = ParsingFailure;
  const factory Failure.noData() = NoDataFailure;

  /// Human-readable, Spanish, ready to show directly in an error state (FR-010).
  String get message;
}

class NetworkFailure extends Failure {
  const NetworkFailure();

  @override
  String get message =>
      'Sin conexión a internet. Verifica tu red e inténtalo de nuevo.';

  @override
  bool operator ==(Object other) => other is NetworkFailure;

  @override
  int get hashCode => runtimeType.hashCode;
}

class ServerFailure extends Failure {
  const ServerFailure(this.statusCode);

  final int statusCode;

  @override
  String get message =>
      'El servidor no pudo procesar la solicitud (código $statusCode).';

  @override
  bool operator ==(Object other) =>
      other is ServerFailure && other.statusCode == statusCode;

  @override
  int get hashCode => Object.hash(runtimeType, statusCode);
}

class ParsingFailure extends Failure {
  const ParsingFailure();

  @override
  String get message => 'No se pudo interpretar la respuesta del servidor.';

  @override
  bool operator ==(Object other) => other is ParsingFailure;

  @override
  int get hashCode => runtimeType.hashCode;
}

class NoDataFailure extends Failure {
  const NoDataFailure();

  @override
  String get message => 'No hay datos disponibles para mostrar.';

  @override
  bool operator ==(Object other) => other is NoDataFailure;

  @override
  int get hashCode => runtimeType.hashCode;
}
