part of 'home_cubit.dart';

enum LoadingStatus { loading, failure, success }

class HomeState extends Equatable {
  final LoadingStatus apiStatus;
  final String searchType;
  final List<BeTalentWorkerModel> workersList;
  final List<BeTalentWorkerModel> originalWorkersList;

  const HomeState._({
    this.apiStatus = LoadingStatus.loading,
    this.searchType = 'name',
    this.workersList = const <BeTalentWorkerModel>[],
    this.originalWorkersList = const <BeTalentWorkerModel>[],
  });

  const HomeState.loading() : this._();

  const HomeState.failure() : this._(apiStatus: LoadingStatus.failure);

  const HomeState.success({
    required List<BeTalentWorkerModel> list,
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
    List<BeTalentWorkerModel>? workersList,
    List<BeTalentWorkerModel>? originalWorkersList,
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