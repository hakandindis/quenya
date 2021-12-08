import 'package:quenya/core/database/hivebox_manager.dart';
import 'package:quenya/source/database/todo/todo_model.dart';

class TodoModelManager extends IHiveBoxManager<TodoModel> {
  TodoModelManager(String key) : super(key);

  @override
  void addItem(TodoModel model) {
    box!.add(model);
  }

  @override
  void deleteItem(int index) {
    box!.deleteAt(index);
  }

  @override
  TodoModel? readItem(int index) {
    var result = box!.getAt(index);

    return result;
  }

  @override
  void updateItem(TodoModel model, int index) {
    box!.putAt(index, model);
  }
}
