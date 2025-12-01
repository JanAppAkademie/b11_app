import 'package:b11_app/services/i_repository.dart';
import 'package:b11_app/services/toys_repo.dart';
import 'package:b11_app/state/toy_bloc/toy_events.dart';
import 'package:b11_app/state/toy_bloc/toy_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ToyBloc<T extends Toy> extends Bloc<ToyEvents<T>, ToyState<T>> {
  final GenericRepository<T> repository;

  ToyBloc(this.repository) : super(ToyInitial<T>()) {
    on<LoadToys<T>>(_onLoadToys);
    on<AddToy<T>>(_onAddToy);
  }

  Future<void> _onLoadToys(LoadToys<T> event, Emitter<ToyState<T>> emit) async {
    try {
      final toys = await repository.getAll();
      emit(ToyLoaded<T>(toys));
    } catch (e) {
      emit(ToyError<T>(e.toString()));
    }
  }

  Future<void> _onAddToy(AddToy<T> event, Emitter<ToyState<T>> emit) async {
    try {
      await repository.add(event.toy);
      final updatedList = await repository.getAll();
      emit(ToyLoaded<T>(updatedList));
    } catch (e) {
      emit(ToyError<T>(e.toString()));
    }
  }
}
