part of 'home_cubit.dart';

enum LoadingStatus { loading, failure, success }

class HomeState extends Equatable {
  final LoadingStatus apiStatus;
  final String searchType;
  final List<BetalentWorkerModel> workersList;
  final List<BetalentWorkerModel> originalWorkersList;

  const HomeState._({
    this.apiStatus = LoadingStatus.loading,
    this.searchType = 'name',
    this.workersList = const <BetalentWorkerModel>[],
    this.originalWorkersList = const <BetalentWorkerModel>[],
  });

  const HomeState.loading() : this._();

  const HomeState.failure() : this._(apiStatus: LoadingStatus.failure);

  const HomeState.success({
    required List<BetalentWorkerModel> list,
    String searchType = 'name',
  }) : this._(
          apiStatus: LoadingStatus.success,
          workersList: list,
          originalWorkersList: list,
          searchType: searchType,
        );

  HomeState copyWith({
    String? searchType,
    LoadingStatus? apiStatus,
    List<BetalentWorkerModel>? workersList,
    List<BetalentWorkerModel>? originalWorkersList,
  }) {
    return HomeState._(
      searchType: searchType ?? this.searchType,
      apiStatus: apiStatus ?? this.apiStatus,
      workersList: workersList ?? this.workersList,
      originalWorkersList: originalWorkersList ?? this.originalWorkersList,
    );
  }

  @override
  List<Object> get props => [apiStatus, workersList, searchType, originalWorkersList];
}