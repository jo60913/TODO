import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/data/model/todo_collection_model.dart';
import 'package:todo/data/model/todo_entry_model.dart';
import '../../exception/exception.dart';
import '../interface/todo_remote_data_source_interface.dart';

class FirestoreRemoteDataSource implements ToDoRemoteDataSourceInterface {
  @override
  Future<bool> createToDoCollection(
      {required String userID, required ToDoCollectionModel collection}) async {
    return await FirebaseFirestore.instance
        .collection(userID)
        .doc(collection.id)
        .set(collection.toJson())
        .then((value) => true)
        .catchError((error) => false);
  }

  @override
  Future<bool> createToDoEntry({required String userID, required String collectionId, required ToDoEntryModel entry}) async {
    return await FirebaseFirestore.instance.collection(userID).doc(collectionId).collection('todo-entries').doc(entry.id).set(entry.toJson()).then((value) => true).catchError((error)=>false);
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection({required String userID, required String collectionId}) async {
    final docSnapShot = await FirebaseFirestore.instance.collection(userID).doc(collectionId).get();
    if(docSnapShot.exists || docSnapShot.data() != null){
      return ToDoCollectionModel.fromJson(docSnapShot.data()!);
    }else{
      throw FirestoreCollectionNotFoundException(id:collectionId);
    }
  }

  @override
  Future<List<String>> getToDoCollectionIds({required String userID}) async {
    final querySnapShot = await FirebaseFirestore.instance.collection(userID).get();
    return querySnapShot.docs.map((doc) => doc.id).toList();
  }

  @override
  Future<ToDoEntryModel> getToDoEntry({required String userID, required String collectionId, required String entryId}) {
    // TODO: implement getToDoEntry
    throw UnimplementedError();
  }

  @override
  Future<List<String>> getToDoEntryIds({required String userID, required String collectionId})async {
    final querySnapShot = await FirebaseFirestore.instance.collection(userID).doc(collectionId).collection('todo-entries').get();
    return querySnapShot.docs.map((doc) => doc.id ).toList();
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry({required String userID, required String collectionId, required ToDoEntryModel entry}) {
    // TODO: implement updateToDoEntry
    throw UnimplementedError();
  }
}
