import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:music_player/res/keys/keys.dart';

class StorageServices extends GetxService{
  late GetStorage _box ;
  Future<StorageServices> init() async{
    _box = GetStorage();
    await _box.write(favouriteKey, []);
    return this;
  }

  T read<T>(String key) {
    return _box.read(key);
  }

  void write (String key, dynamic value) async{
    return  await _box.write(key, value);
  }

}