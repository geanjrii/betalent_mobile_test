import 'package:betalent_mobile_test/data_layer/data_layer.dart';
import 'package:betalent_mobile_test/domain_layer/domain_layer.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required BetalentRepository repository})
      : _repository = repository,
        super(const HomeState.loading());

  final BetalentRepository _repository;

  void onDataLoaded() async {
    try {
      emit(state.copyWith(apiStatus: LoadingStatus.loading));
      final workersList = await _repository.getWorkers()..sort((a, b) => a.name.compareTo(b.name));
      emit(state.copyWith(
        apiStatus: LoadingStatus.success,
        workersList: workersList,
        originalWorkersList: workersList,
      ));
    } catch (e) {
      emit(state.copyWith(apiStatus: LoadingStatus.failure));
    }
  }

  void filterWorkers(String query, String searchType) async {
    try {
      emit(state.copyWith(apiStatus: LoadingStatus.loading));
      if (query.isEmpty) {
        emit(state.copyWith(
          apiStatus: LoadingStatus.success,
          workersList: state.originalWorkersList,
          searchType: state.searchType,
        ));
        return;
      }
      final filteredList = state.originalWorkersList.where((worker) {
        switch (searchType) {
          case 'name':
            return worker.name.toLowerCase().contains(query.toLowerCase());
          case 'position':
            return worker.job.toLowerCase().contains(query.toLowerCase());
          case 'phone':
            return worker.phone.contains(query);
          default:
            return false;
        }
      }).toList();
      emit(state.copyWith(
        apiStatus: LoadingStatus.success,
        workersList: filteredList,
        searchType: searchType,
      ));
    } catch (e) {
      emit(state.copyWith(apiStatus: LoadingStatus.failure));
    }
  }

  void updateSearchType(String searchType) {
    emit(state.copyWith(apiStatus: LoadingStatus.loading));
    emit(state.copyWith(
      apiStatus: LoadingStatus.success,
      searchType: searchType,
    ));
  }
}
