import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/services/provider.dart';
import 'package:music_player/services/repository.dart';
import 'package:music_player/view/Home/home_tabs/FolderSongs/folder_song.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../controller/player_controller.dart';
import '../../../res/textStyle/textStyle.dart';

final playerCtrl = Get.put(PlayerController(favouriteProvider: FavouriteProvider()));

class MusicFolder extends StatefulWidget {
  const MusicFolder({super.key});

  @override
  State<MusicFolder> createState() => _MusicFolderState();
}

class _MusicFolderState extends State<MusicFolder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }
}

FutureBuilder<List<AlbumModel>> buildBody() {
  return FutureBuilder<List<AlbumModel>>(
    future: playerCtrl.audioQuery.queryAlbums(
      sortType: null,
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
    ),
    builder: (context, snapshot) {
      if (snapshot.data == null) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (snapshot.data!.isEmpty) {
        return Text(
          "No Song found",
          style: ourStyle,
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 5,
                crossAxisSpacing: 5,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    playerCtrl.folderSong.value = [];
                    for (int i = 0; i < playerCtrl.song.length; i++) {
                      if (snapshot.data![index].id ==
                          playerCtrl.song[i].albumId) {
                        playerCtrl.folderSong.add(playerCtrl.song[i]);
                      }
                    }
                    //print(playerCtrl.folderSong);
                    Get.to(() => FolderSong(songs: playerCtrl.folderSong));
                  },
                  child: Center(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.folder,
                          color: Colors.yellow,
                          size: 40,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          snapshot.data![index].album,
                          style: ourStyle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      }
    },
  );
}
