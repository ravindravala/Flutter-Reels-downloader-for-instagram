import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelsdownloader/src/features/downloaded_reels/view/downloads.dart';
import 'package:reelsdownloader/src/features/home/cubit/home_cubit.dart';
import 'package:reelsdownloader/src/widgets/video_card.dart';

class NewHome extends StatelessWidget {
  final TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final homeCubit = BlocProvider.of<HomeCubit>(context);

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
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Downloads()));
              },
              child: Icon(
                Icons.download,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25).copyWith(top: 25),
        child: BlocBuilder<HomeCubit, HomeState>(
          bloc: homeCubit,
          builder: (context, state) {
            if (state is HomeInitial) {
              return ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 200,
                            width: 150,
                            child: Center(
                              child: Text("No recent download"),
                            ),
                          ),
                        ]),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: TextField(
                      controller: urlController,
                      autocorrect: true,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: IconButton(
                            
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(45)
                              )
                            ),
                              
                              onPressed: () async {
                                final clipboardData =
                                    await Clipboard.getData(Clipboard.kTextPlain);
                                urlController.text = clipboardData?.text ?? "";
                              },
                              
                              icon: Icon(Icons.paste,color: Colors.white,),
                            ),
                          ),
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
                  Container(
                    height: 100,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          homeCubit.downloadReal(
                            urlController.text,
                            context,
                          );
                          urlController.clear();
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
                            color: Colors.blueGrey,
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(25),
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
              );
            }

            if (state is ReelsDownloading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ReelDownloaded) {
              return ListView(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      height: 200,
                      width: 150,
                      child: VideoCard(reelData: state.reelData),
                    ),
                  ]),
                  Container(
                    height: 100,
                    child: Center(
                      child: InkWell(
                        onTap: () {
                          homeCubit.downloadNewReel();
                        },
                        child: Container(
                          height: 40,
                          width: 200,
                          child: Center(
                              child: Text(
                            "Download New Reel",
                            style: TextStyle(color: Colors.white),
                          )),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: const BorderRadius.all(
                              const Radius.circular(25),
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
              );
            }

            return SizedBox();
          },
        ),
      ),
    );
  }
}
