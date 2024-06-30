import 'package:device_info/device_info.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_player/services/provider.dart';
import 'package:music_player/services/repository.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {

  FavouriteProvider favouriteProvider;

  PlayerController({required this.favouriteProvider});

  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();
  final playerIndex = 0.obs;
  final isPlaying = false.obs;
  final isFavorite = false.obs;
  final duration = "".obs;
  final position = "".obs;
  final max = 0.0.obs;
  final value = 0.0.obs;
  final favourite = <SongModel>[].obs;
  final RxList<SongModel> song = <SongModel>[].obs;
  final RxList<SongModel> folderSong = <SongModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    favourite.assignAll(favouriteProvider.readTask());
    ever(favourite, (_) => favouriteProvider.writeTask(favourite));
  }

  changeSliderDuration(seconds){
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  addFavourite(SongModel item){
    favourite.add(item);
  }

  removeFavorite(SongModel item){
    favourite.remove(item);
  }

  updatePosition(){
    audioPlayer.durationStream.listen((d) {
      duration.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  playAudio(String? uri,index){
    playerIndex.value = index;
    try{
      audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(uri!))
      );
      audioPlayer.play();
      isPlaying.value = true;
      updatePosition();
    }
    on Exception catch(e){
    }

  }

  checkPermission() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo android = await deviceInfo.androidInfo;
    final status = await Permission.storage.request();
    if (android.version.sdkInt <= 32) {
      if (status.isGranted) {
      } else {
        checkPermission();
      }
    } else {
      final per = await Permission.audio.request();
      if (per.isGranted) {
      } else {
        checkPermission();
      }
    }
  }
}
