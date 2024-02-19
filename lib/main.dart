import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reelsdownloader/src/database/reel_data.dart';
import 'src/features/downloaded_reels/cubit/download_cubit.dart';
import 'src/features/home/cubit/home_cubit.dart';
import 'src/features/home/view/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ReelDataAdapter());
  await Hive.openBox<ReelData>('reel');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => DownloadCubit())
      ],
      child: MaterialApp(
        title: 'Flutter Reels Downloader',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: NewHome(),
      ),
    );
  }
}
