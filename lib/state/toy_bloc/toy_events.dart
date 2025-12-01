import 'package:b11_app/services/toys_repo.dart';

abstract class ToyEvents<T extends Toy> {}

class LoadToys<T extends Toy> extends ToyEvents<T> {}

class AddToy<T extends Toy> extends ToyEvents<T> {
  final T toy;
  AddToy(this.toy);
}
