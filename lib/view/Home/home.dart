import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_player/res/color/colors.dart';
import 'package:music_player/res/textStyle/textStyle.dart';
import 'package:music_player/view/Favourite/favourite.dart';
import 'package:music_player/view/Home/home_tabs/list_of_songs.dart';
import 'package:music_player/view/Home/home_tabs/music_folder.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2, child: Scaffold(
      drawer: buildDrawer(),
      appBar: AppBar(
        title: const Text("Music Player"),
        bottom:  TabBar(
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.white,
          isScrollable: true,
          tabs: [
            SizedBox(
              height: Get.height*0.06,
              width: Get.width/3,
              child: const Center(child: Text("Songs",style: TextStyle(
                fontSize: 20
              ))),
            ),
            //Tab(text: "Songs",),
            SizedBox(
              height: Get.height*0.06,
              width: Get.width/3,
              child: const Center(child:  Text("Albums",style:  TextStyle(
                  fontSize: 20
              ))),
            ),
           // Tab(text: "Albums",),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          ListOfSongs(),
          MusicFolder(),
        ],
      ),
    ));
  }
}

Drawer buildDrawer() {
  return Drawer(
    backgroundColor: AppColor.bgDarkColor,
    child: Column(
      children: [
        DrawerHeader(
          child: Row(
            children: [
              const Icon(Icons.music_note,color: AppColor.whiteColor,size: 28,),
              const SizedBox(
                width: 10,
              ),
              Text("Music Player",style: ourStyle.copyWith(
                fontSize: 28,
              ),),
            ],
          ),),
        ListTile(
          leading: const Icon(Icons.favorite,color: AppColor.whiteColor,),
          title: Text("Favorite",style: ourStyle.copyWith(
            fontSize: 24,
          ),),
          onTap: (){
            Get.back();
            Get.to(()=>const Favorite(),
                transition: Transition.leftToRight
            );
          },
        )
      ],
    ),
  );
}