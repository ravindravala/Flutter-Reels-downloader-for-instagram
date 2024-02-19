part of 'home_cubit.dart';

@immutable
class HomeState {}

class HomeInitial extends HomeState {}

class ReelsDownloading extends HomeState {}

class ReelDownloaded extends HomeState {
  final ReelData reelData;

  ReelDownloaded({required this.reelData});
}
