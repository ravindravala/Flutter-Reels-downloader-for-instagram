import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:reelsdownloader/GenrateVideoFromPath.dart';

class DownloadedList extends StatefulWidget {
  _DownloadedListState createState() => _DownloadedListState();
}

class _DownloadedListState extends State<DownloadedList> {
  var box = GetStorage();
  bool loadingVideos = true;
  List allVideos = [];

  @override
  void initState() {
    allVideos = box.read("allVideo") ?? [];
    loadingVideos = false;

    setState(() {
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("Downloaded Reels",style: TextStyle(color: Colors.black),),
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: loadingVideos?Center(child: CupertinoActivityIndicator(),):
       GridView.count(crossAxisCount: 2,
       childAspectRatio: 1/1.3,
       children:List<Widget>.generate(allVideos.length, (index) => Padding(
         padding: const EdgeInsets.all(8.0),
         child: GenrateVideoFrompath(allVideos[index]),
       )),),
    );
  }
}
