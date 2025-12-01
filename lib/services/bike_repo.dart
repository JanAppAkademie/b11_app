import 'package:b11_app/services/i_repository.dart';

class BikeRepo extends GenericRepository<Bike> {
  // GEHT NICHT, weil Bike nicht von Toy erbt
  @override
  Future<void> add(item) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<void> update(item) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
