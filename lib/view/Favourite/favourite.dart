import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/view/player/favorite_player.dart';
import 'package:music_player/view/player/player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../controller/player_controller.dart';
import '../../res/color/colors.dart';
import '../../res/textStyle/textStyle.dart';

final playerCtrl = Get.find<PlayerController>();
class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Favourite',),
      ),
      body:  Padding(
        padding: const EdgeInsets.all(8.0),
        child: (playerCtrl.favourite.isEmpty) ? Center(
          child: Text("No Favourite Songs" , style: ourStyle.copyWith(
            fontSize: 30
          ),),
        ) : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: playerCtrl.favourite.length,
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
                      playerCtrl.favourite[index].displayNameWOExt,
                      style: ourStyle.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Text(
                      playerCtrl.favourite[index].artist!,
                      style: ourStyle.copyWith(fontSize: 12, fontWeight: FontWeight.normal),
                    ),
                    leading: QueryArtworkWidget(
                      id:  playerCtrl.favourite[index].id,
                      type: ArtworkType.AUDIO,
                      nullArtworkWidget: const Icon(Icons.music_note,color: AppColor.whiteColor,size: 32,),
                    ),
                    trailing:(playerCtrl.playerIndex.value == index && playerCtrl.isPlaying.value == true) ? const Icon(
                      Icons.play_arrow,
                      color: AppColor.whiteColor,
                      size: 26,
                    ) : null,
                    onTap: (){
                      playerCtrl.playAudio( playerCtrl.favourite[index].uri,index);
                      Get.to(()=>FavouritePlayerScreen(data: playerCtrl.favourite,),
                        transition: Transition.downToUp,
                      );
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }
}
