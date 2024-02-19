import 'package:hive/hive.dart';

part 'reel_data.g.dart';

@HiveType(typeId: 1)
class ReelData {
  @HiveField(0)
  String? downloadLink;

  @HiveField(1)
  String? imageLink;

  @HiveField(2)
  String? storagePath;
}
