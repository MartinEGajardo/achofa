import 'package:achofa/api/api.dart';
import 'package:achofa/screens/maquinaria.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';


class MaquinariaCubit extends Cubit<MaquinariaState> {
  MaquinariaCubit() : super(MaquinariaInitial());

  void fetchMaquinarias(int page, int pageSize, String search) async {
    try {
      emit(MaquinariaLoading());
      // Aquí harías la llamada a la API
      final response = await fetchFromApi(page, pageSize, search);
      emit(MaquinariaLoaded(response));
    } catch (e) {
      emit(MaquinariaError("Error al cargar las maquinarias"));
    }
  }

  void deleteMaquinaria(int id) {
    if (state is MaquinariaLoaded) {
      final currentState = state as MaquinariaLoaded;
      final updatedList = currentState.maquinarias.where((m) => m.id != id).toList();
      emit(MaquinariaLoaded(updatedList));
    }
  }

  void updateMaquinaria(Maquinaria maquinaria) {
    if (state is MaquinariaLoaded) {
      final currentState = state as MaquinariaLoaded;
      final updatedList = currentState.maquinarias.map((m) => m.id == maquinaria.id ? maquinaria : m).toList();
      emit(MaquinariaLoaded(updatedList));
    }
  }
}

@immutable
abstract class MaquinariaState {}

class MaquinariaInitial extends MaquinariaState {}

class MaquinariaLoading extends MaquinariaState {}

class MaquinariaLoaded extends MaquinariaState {
  final List<Maquinaria> maquinarias;

  MaquinariaLoaded(this.maquinarias);
}

class MaquinariaError extends MaquinariaState {
  final String message;

  MaquinariaError(this.message);
}

