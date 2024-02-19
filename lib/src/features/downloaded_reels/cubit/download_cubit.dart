import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:reelsdownloader/src/database/reel_data.dart';

part 'download_state.dart';

class DownloadCubit extends Cubit<DownloadState> {
  DownloadCubit() : super(DownloadLoading()) {
    loadDownloads();
  }

  Box<ReelData> storageBox = Hive.box<ReelData>('reel');

  void loadDownloads() {
    var data = storageBox.values.toList();
    emit(DownloadLoaded(reelsData: data));
  }
}
