import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reelsdownloader/Controller/DownloadController.dart';
import 'package:reelsdownloader/DownloadedList.dart';
import 'package:reelsdownloader/GenrateVideoFromPath.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DownloadController downloadController = Get.put(DownloadController());
  TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Reels Downloader",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: InkWell(
                onTap: () {
                  Get.to(DownloadedList());
                },
                child: Icon(
                  Icons.download,
                  color: Colors.black,
                )),
          )
        ],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: GetBuilder(
                  init: downloadController,
                  builder: (_) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200,
                          width: 150,
                          child: downloadController.path != null
                              ? Container(
                                  child: GenrateVideoFrompath(
                                      downloadController.path ?? ""))
                              : Center(child: Text("No recent download")),
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: TextField(
                  controller: urlController,
                  autocorrect: true,
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(25),
                        ),
                      ),
                      filled: true,
                      hintStyle: new TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                      hintText: "Paste instagram reel link here",
                      fillColor: Colors.white70),
                ),
              ),
              Obx(
                () => Container(
                  height: 100,
                  child: downloadController.processing.value
                      ? Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Center(
                          child: InkWell(
                            onTap: () {
                              downloadController.downloadReal(
                                  urlController.text, context);
                            },
                            child: Container(
                              height: 40,
                              width: 150,
                              child: Center(
                                  child: Text(
                                "Download",
                                style: TextStyle(color: Colors.white),
                              )),
                              decoration: BoxDecoration(
                                color: Colors.deepPurple,
                                borderRadius: const BorderRadius.all(
                                  const Radius.circular(25),
                                ),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
              Container(
                height: 200,
                child: Center(child: Text("Made in ❤️ with Flutter")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
