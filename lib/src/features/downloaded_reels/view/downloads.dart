import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reelsdownloader/src/features/downloaded_reels/cubit/download_cubit.dart';
import 'package:reelsdownloader/src/widgets/video_card.dart';

class Downloads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Downloaded Reels",
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: BlocBuilder<DownloadCubit, DownloadState>(
        builder: (context, state) {
          if (state is DownloadLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DownloadLoaded) {
            return GridView.count(
              padding: EdgeInsets.all(10),
              crossAxisCount: 2,
              childAspectRatio: 1 / 1.3,
              children: List<Widget>.generate(
                state.reelsData.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: VideoCard(reelData: state.reelsData[index]),
                ),
              ),
            );
          }

          return SizedBox();
        },
      ),
    );
  }
}
