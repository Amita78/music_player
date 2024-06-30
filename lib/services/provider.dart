import 'dart:convert';
import 'package:get/get.dart';
import 'package:music_player/res/keys/keys.dart';
import 'package:music_player/services/services.dart';
import 'package:on_audio_query/on_audio_query.dart';


class FavouriteProvider{
  final _storage = Get.find<StorageServices>();

  List<SongModel> readTask(){
    var tasks = <SongModel>[];
    // jsonDecode(_storage.read(favouriteKey).toString())
    //     ?.forEach((e)=>tasks.add(SongModel.fromJson(e)));
    return tasks;
  }

  void writeTask (List<SongModel> tasks){
    _storage.write(favouriteKey, tasks);
  }

}