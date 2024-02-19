part of 'download_cubit.dart';

@immutable
class DownloadState {}

class DownloadLoading extends DownloadState {}

class DownloadLoaded extends DownloadState {
  final List<ReelData> reelsData;

  DownloadLoaded({required this.reelsData});

}
