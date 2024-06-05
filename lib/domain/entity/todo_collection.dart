import 'unique_id.dart';

class ToDoCollection {
  final CollectionId id;
  final String title;
  final int itemIndex;

  ToDoCollection({
    required this.id,
    required this.title,
    required this.itemIndex,
  });

  ToDoCollection copyWith({
    String? title,
    int itemIndex = 0,
  }) {
    return ToDoCollection(
        id: id, title: title ?? this.title, itemIndex: itemIndex);
  }

  factory ToDoCollection.empty() {
    return ToDoCollection(
      id: CollectionId(),
      title: '',
      itemIndex: 0,
    );
  }
}
