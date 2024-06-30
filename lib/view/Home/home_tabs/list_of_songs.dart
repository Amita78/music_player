import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/controller/player_controller.dart';
import 'package:music_player/res/textStyle/textStyle.dart';
import 'package:music_player/services/provider.dart';
import 'package:music_player/services/repository.dart';
import 'package:music_player/view/player/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../res/color/colors.dart';

final playerCtrl = Get.put(PlayerController(favouriteProvider: FavouriteProvider()));
class ListOfSongs extends StatefulWidget {
  const ListOfSongs({super.key});

  @override
  State<ListOfSongs> createState() => _ListOfSongsState();
}

class _ListOfSongsState extends State<ListOfSongs> {

  @override
  void initState() {
    playerCtrl.checkPermission();
    super.initState();
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(),
    );
  }
}

FutureBuilder<List<SongModel>> buildBody() {
  return FutureBuilder<List<SongModel>>(
    future: playerCtrl.audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    ),
    builder: (context, snapshot) {
      if(snapshot.data == null){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      else if(snapshot.data!.isEmpty){
        return Text("No Song /found",style: ourStyle,);
      }
      else{
          playerCtrl.song.addAll(snapshot.data!);
        return buildListView(snapshot);
      }
    },
  );
}

Padding buildListView(AsyncSnapshot<List<SongModel>> snapshot) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Obx(
                ()=> Container(
              margin: const EdgeInsets.only(bottom: 4,),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                tileColor: AppColor.bgColor,
                title: Text(
                  snapshot.data![index].displayNameWOExt,
                  style: ourStyle.copyWith(
                    fontSize: 15,
                  ),
                ),
                subtitle: Text(
                  snapshot.data![index].artist!,
                  style: ourStyle.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                ),
                leading: QueryArtworkWidget(
                  id: snapshot.data![index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note,color: AppColor.whiteColor,size: 32,),
                ),
                trailing:(playerCtrl.playerIndex.value == index && playerCtrl.isPlaying.value == true) ? const Icon(
                  Icons.play_arrow,
                  color: AppColor.whiteColor,
                  size: 26,
                ) : null,
                onTap: (){
                  playerCtrl.playAudio(snapshot.data![index].uri,index);
                  Get.to(()=>PlayerScreen(data: snapshot.data!,),
                    transition: Transition.downToUp,
                  );
                },
              ),
            ),
          );
        }),
  );
}

