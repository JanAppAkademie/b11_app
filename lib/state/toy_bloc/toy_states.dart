import 'package:b11_app/services/toys_repo.dart';
import 'package:equatable/equatable.dart';

abstract class ToyState<T extends Toy> extends Equatable {
  const ToyState();

  @override
  List<Object?> get props => [];
}

class ToyInitial<T extends Toy> extends ToyState<T> {}

class ToyLoading<T extends Toy> extends ToyState<T> {}

class ToyLoaded<T extends Toy> extends ToyState<T> {
  final List<T> toys;

  const ToyLoaded(this.toys);

  @override
  List<Object?> get props => [toys];
}

class ToyError<T extends Toy> extends ToyState<T> {
  final String message;

  const ToyError(this.message);

  @override
  List<Object?> get props => [message];
}
