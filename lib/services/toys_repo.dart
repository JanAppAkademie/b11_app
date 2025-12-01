import 'package:b11_app/services/i_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToysRepo extends GenericRepository<Toy> {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<void> add(Toy toy) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<List<Toy>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> update(Toy item) {
    // TODO: implement update
    throw UnimplementedError();
  }

  void someFunction(Toy item) {}
}

class Toy {
  String name;
  double price;

  Toy(this.name, this.price);
}

class GamingDevice extends Toy {
  String supplier;
  String platform;

  GamingDevice(this.supplier, this.platform, super.name, super.price);
}

class Bike {
  int wheels;

  Bike(this.wheels);
}
