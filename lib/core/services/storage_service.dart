import 'package:hive/hive.dart';

class StorageService {
  final _box = Hive.box('todoBox');

  void deleteBox(String key) {
    _box.delete(key);
  }

  void deleteFromBox(String key, int index) {
    final list = getFromBox(key);
    list.removeAt(index);
    _box.put(key, list);
  }

  List<dynamic> getFromBox(String key) {
    return _box.get(key)?.cast<dynamic>() ?? [].cast<dynamic>();
  }

  void putInBox(String key, List<dynamic> list) {
    _box.put(key, list);
  }

  void addToBox(String key, var item) {
    final list = getFromBox(key);
    list.add(item);
    _box.put(key, list);
  }

  void updateInBox(String key, int index, var item) {
    final list = getFromBox(key);
    list[index] = item;
    _box.put(key, list);
  }
}
