import 'package:music_player/services/provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteRespository{
  FavouriteProvider favouriteProvider;
  FavouriteRespository({required this.favouriteProvider});

  List<SongModel> readTasks() => favouriteProvider.readTask();
  void writeTasks(List<SongModel> tasks) => favouriteProvider.writeTask(tasks);
}