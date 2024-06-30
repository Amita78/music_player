import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:music_player/res/color/colors.dart';
import 'package:music_player/res/textStyle/textStyle.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../controller/player_controller.dart';

final playerCtrl = Get.find<PlayerController>();


class PlayerScreen extends StatelessWidget {
  final List<SongModel> data;
  const PlayerScreen({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        actions: [
          Obx(
          ()=> IconButton(onPressed: (){
              if(playerCtrl.favourite.contains(data[playerCtrl.playerIndex.value])){
                //playerCtrl.isFavorite.value = false;
                playerCtrl.removeFavorite(data[playerCtrl.playerIndex.value]);
              }
              else{
                //playerCtrl.isFavorite.value = true;
                playerCtrl.addFavourite(data[playerCtrl.playerIndex.value]);
              }
              // if (kDebugMode) {
              //   print(playerCtrl.favourite.length);
              // }
              },
              icon:(playerCtrl.favourite.contains(data[playerCtrl.playerIndex.value])) ? const Icon(Icons.favorite,color: Colors.red,) : const Icon(Icons.favorite_outline) ,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8,8,8,0),
        child: Column(
          children: [
            Obx(
              ()=> Expanded(
                flex: 6,
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 300,
                  width: 300,
                  decoration: const BoxDecoration(
                    color: AppColor.sliderColor,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: QueryArtworkWidget(
                    id: data[playerCtrl.playerIndex.value].id,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: const Icon(Icons.music_note,color: AppColor.whiteColor,size: 48,
                    ),
                    artworkQuality: FilterQuality.high,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              flex: 4,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                  color: AppColor.whiteColor,
                ),
                child: Obx(
                  ()=> Column(
                    children: [
                      Text(
                        data[playerCtrl.playerIndex.value].displayNameWOExt,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle.copyWith(
                          fontSize: 24,
                          color: AppColor.bgDarkColor,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        data[playerCtrl.playerIndex.value].artist!,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: ourStyle.copyWith(
                            fontSize: 20,
                            color: AppColor.bgDarkColor,
                            fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        ()=> Row(
                          children: [
                            Text(
                              playerCtrl.position.value,
                              style: ourStyle.copyWith(
                                color: AppColor.bgDarkColor,
                              ),
                            ),
                            Expanded(
                                child: Slider(
                              thumbColor: AppColor.sliderColor,
                              activeColor: AppColor.sliderColor,
                              inactiveColor: AppColor.bgColor,
                              min: const Duration(seconds: 0).inSeconds.toDouble(),
                              max: playerCtrl.max.value,
                              value: playerCtrl.value.value,
                              onChanged: (newValue) {
                                playerCtrl.changeSliderDuration(newValue.toInt());
                                newValue = newValue;
                              },
                            )),
                            Text(
                              playerCtrl.duration.value,
                              style: ourStyle.copyWith(
                                color: AppColor.bgDarkColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Obx(
                        ()=> Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              onPressed: () {
                                playerCtrl.playAudio(data[playerCtrl.playerIndex.value-1].uri, playerCtrl.playerIndex.value-1);
                              },
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                size: 40,
                                color: AppColor.bgDarkColor,
                              ),
                            ),
                          CircleAvatar(
                                radius: 35,
                                backgroundColor: AppColor.bgColor,
                                child: Transform.scale(
                                  scale: 2,
                                  child: IconButton(
                                    onPressed: () {
                                      if(playerCtrl.isPlaying.value){
                                        playerCtrl.audioPlayer.pause();
                                        playerCtrl.isPlaying(false);
                                      }
                                      else{
                                        playerCtrl.audioPlayer.play();
                                        playerCtrl.isPlaying(true);
                                      }
                                    },
                                    icon: playerCtrl.isPlaying.value ? const Icon(
                                      Icons.pause,
                                      color: AppColor.whiteColor,
                                    ) : const Icon(
                                      Icons.play_arrow_rounded,
                                      color: AppColor.whiteColor,
                                    ),
                                  ),
                                ),
                              ),
                            IconButton(
                              onPressed: () {
                                playerCtrl.playAudio(data[playerCtrl.playerIndex.value+1].uri, playerCtrl.playerIndex.value+1);
                              },
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                size: 40,
                                color: AppColor.bgDarkColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
