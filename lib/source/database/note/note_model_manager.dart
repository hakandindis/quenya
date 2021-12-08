import 'package:quenya/core/database/hivebox_manager.dart';

import 'note_model.dart';

class NoteModelManager extends IHiveBoxManager<NoteModel> {
  NoteModelManager(String key) : super(key);

  @override
  void addItem(NoteModel model) {
    box!.add(model);
  }

  @override
  void deleteItem(int index) {
    box!.deleteAt(index);
  }

  @override
  NoteModel? readItem(int index) {
    var result = box!.getAt(index);

    return result;
  }

  @override
  void updateItem(NoteModel model, int index) {
    box!.putAt(index, model);
  }
}
