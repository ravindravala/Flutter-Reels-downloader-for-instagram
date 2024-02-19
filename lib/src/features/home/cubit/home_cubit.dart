import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reelsdownloader/src/database/reel_data.dart';
import 'package:reelsdownloader/src/features/downloaded_reels/cubit/download_cubit.dart';
import 'package:reelsdownloader/src/features/insta_login/instagram_login.dart';
import 'package:reelsdownloader/src/model/insta_post_with_login.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart' as wb;

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  bool isLogin = false;
  String? path;
  Box<ReelData> storageBox = Hive.box<ReelData>('reel');

  Dio dio = Dio();

  Future<ReelData?> _downloadReel(
    String link,
    BuildContext context,
  ) async {
    // Asking for video storage permission
    await Permission.storage.request();
    isLogin = false;
    // Checking for Cookies
    final cookieManager = wb.WebviewCookieManager();
    final gotCookies =
        await cookieManager.getCookies('https://www.instagram.com/');
    // is Cookie found then set isLogin to true
    if (gotCookies.length > 0) isLogin = true;

    if (!isLogin)
      await Navigator.push(
          context, MaterialPageRoute(builder: (_) => InstaLogin()));

    // Build the url
    var linkParts = link.replaceAll(" ", "").split("/");
    var url =
        '${linkParts[0]}//${linkParts[2]}/${linkParts[3]}/${linkParts[4]}' +
            "?__a=1&__d=dis";

    // Make Http requiest to get the download link of video
    var httpClient = new HttpClient();
    String? videoUrl;
    String? imageUrl;

    try {
      var request = await httpClient.getUrl(Uri.parse(url));
      gotCookies.forEach((element) {
        request.cookies.add(Cookie(element.name, element.value));
      });
      var response = await request.close();

      if (response.statusCode == HttpStatus.OK) {
        var json = await response.transform(utf8.decoder).join();
        var data = jsonDecode(json);
        debugPrint(data.toString());
        InstaPostWithLogin postWithLogin = InstaPostWithLogin.fromJson(data);
        videoUrl = postWithLogin.items?.first.videoVersions?.first.url;
        imageUrl =
            postWithLogin.items!.first.imageVersions2!.candidates?.first.url;
      } else {
        throw Exception();
      }
    } catch (exception) {
      // Login to instagram in case of Cookie expire or download any private account's video
      await Navigator.push(
          context, MaterialPageRoute(builder: (_) => InstaLogin()));
    }

    // Download video & save
    if (videoUrl == null) {
      return null;
    } else {
      var appDocDir = await getTemporaryDirectory();
      String savePath = appDocDir.path + "/temp.mp4";
      await dio.download(videoUrl, savePath);
      final result =
          await ImageGallerySaver.saveFile(savePath, isReturnPathOfIOS: true);
      print(result);

      var data = ReelData();
      data.downloadLink = videoUrl;
      data.imageLink = imageUrl;
      data.storagePath = result["filePath"];

      return data;
    }
  }

  void downloadReal(String link, BuildContext context) async {
    emit(ReelsDownloading());

    try {
      path = null;
      await _downloadReel(link, context).then((value) {
        if (value == null) throw Exception();
        path = value.storagePath;

        ReelData reelData = ReelData();

        reelData.downloadLink = value.downloadLink;
        reelData.storagePath = value.storagePath;
        reelData.imageLink = value.imageLink;

        storageBox.add(reelData);
        emit(ReelDownloaded(reelData: reelData));
        BlocProvider.of<DownloadCubit>(context).loadDownloads();
      });
    } catch (e) {
      emit(HomeInitial());
    }
  }

  void downloadNewReel() {
    emit(HomeInitial());
  }
}
