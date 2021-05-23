import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadController extends GetxController {
  var processing = false.obs;
  String? path;
  var box = GetStorage();
  Future<String> _startDownload(String link) async {
    // Getting Permission
    await Permission.storage.request();

    // geting Video Link
    var linkEdit = link.replaceAll(" ", "").split("/");
    var downloadURL = await Dio().get(
        '${linkEdit[0]}//${linkEdit[2]}/${linkEdit[3]}/${linkEdit[4]}' +
            "/?__a=1");
    var data = downloadURL.data;
    var graphql = data['graphql'];
    var shortcodeMedia = graphql['shortcode_media'];
    var videoUrl = shortcodeMedia['video_url'];
    print(videoUrl);

    // Downloading Video

    var appDocDir = await getTemporaryDirectory();
    String savePath = appDocDir.path + "/temp.mp4";
    await Dio().download(videoUrl, savePath);
    final result = await ImageGallerySaver.saveFile(savePath);
    print(result);
    return result["filePath"];
  }

  downloadReal(String link) async {
    processing.value = true;

    try {
      path = null;
      update();
      await _startDownload(link).then((value) {
        path = value;
        update();

        List allVideosPath = box.read("allVideo") ?? [];
        allVideosPath.add(path);
        box.write("allVideo", allVideosPath);
      });
    } catch (e) {}

    processing.value = false;
  }
}
