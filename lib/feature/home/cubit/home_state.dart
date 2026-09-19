
import 'package:nutrimind/feature/model/change_target.dart';
import 'package:nutrimind/feature/model/home_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<HomeModel> history;

  HomeLoaded(this.history);
}

class HomeFailure extends HomeState {
  final String error;

  HomeFailure(this.error);
}

class Changetarge extends HomeState {
  final ChangeTarget changetarget;

  Changetarge({required this.changetarget});
}
