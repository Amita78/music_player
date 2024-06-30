import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_player/res/color/colors.dart';
import 'package:music_player/res/textStyle/textStyle.dart';
import 'package:music_player/services/services.dart';
import 'package:music_player/view/Home/home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init;
  await Get.putAsync(() => StorageServices().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Music Player',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColor.bgDarkColor,
        fontFamily: GoogleFonts.lato().fontFamily,
        appBarTheme:  AppBarTheme(
          titleTextStyle: ourStyle.copyWith(
            color: AppColor.whiteColor,
            fontSize: 24
          ),
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(
            color: AppColor.whiteColor,
          ),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

