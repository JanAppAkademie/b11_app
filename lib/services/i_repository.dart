import 'package:b11_app/services/toys_repo.dart';

abstract class GenericRepository<T extends Toy> {
  // T darf nur von Toy erben
  Future<void> add(T item);
  Future<List<T>> getAll();
  Future<void> update(T item);
}
