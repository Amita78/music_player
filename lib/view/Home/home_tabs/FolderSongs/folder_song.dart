import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:music_player/res/color/colors.dart';
import 'package:music_player/res/textStyle/textStyle.dart';
import 'package:music_player/view/player/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

final playerCtrl = Get.find<PlayerController>();

class FolderSong extends StatelessWidget {
  final List<SongModel> songs;

  const FolderSong({super.key, required this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music Player"),
      ),
      body: buildListView(songs),
    );
  }
}

Padding buildListView(List<SongModel> snapshot) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.length,
        itemBuilder: (context, index) {
          return Obx(
            () => (snapshot.isEmpty) ? Text("No Song found",style: ourStyle,) : Container(
              margin: const EdgeInsets.only(
                bottom: 4,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: AppColor.bgColor,
                title: Text(
                  snapshot[index].displayNameWOExt,
                  style: ourStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  snapshot[index].artist!,
                  style: ourStyle.copyWith(
                      fontSize: 12, fontWeight: FontWeight.normal),
                ),
                leading: QueryArtworkWidget(
                  id: snapshot[index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(
                    Icons.music_note,
                    color: AppColor.whiteColor,
                    size: 32,
                  ),
                ),
                trailing: (playerCtrl.playerIndex.value == index &&
                        playerCtrl.isPlaying.value == true)
                    ? const Icon(
                        Icons.play_arrow,
                        color: AppColor.whiteColor,
                        size: 26,
                      )
                    : null,
                onTap: () {
                  playerCtrl.playAudio(snapshot[index].uri, index);
                  Get.to(
                    () => PlayerScreen(
                      data: snapshot,
                    ),
                    transition: Transition.downToUp,
                  );
                },
              ),
            ),
          );
        }),
  );
}
