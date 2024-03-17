import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/data/model/todo_collection_model.dart';
import 'package:todo/data/model/todo_entry_model.dart';
import '../interface/todo_remote_data_source_interface.dart';

class FirestoreRemoteDataSource implements ToDoRemoteDataSourceInterface {
  @override
  Future<bool> createToDoCollection({required ToDoCollectionModel collection}) {
    // TODO: implement createToDoCollection
    throw UnimplementedError();
  }

  @override
  Future<bool> createToDoEntry({required String userID, required String collectionId, required ToDoEntryModel entry}) {
    // TODO: implement createToDoEntry
    throw UnimplementedError();
  }

  @override
  Future<ToDoCollectionModel> getToDoCollection({required String userID, required String collectionId}) async {
    final docSnapShot = await FirebaseFirestore.instance.collection(userID).doc(collectionId).get();
    if(docSnapShot.exists || docSnapShot.data() != null){
      return ToDoCollectionModel.fromJson(docSnapShot.data()!);
    }else{
      throw Exception("doc $collectionId不存在");
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
  Future<List<String>> getToDoEntryIds({required String userID, required String collectionId}) {
    // TODO: implement getToDoEntryIds
    throw UnimplementedError();
  }

  @override
  Future<ToDoEntryModel> updateToDoEntry({required String userID, required String collectionId, required ToDoEntryModel entry}) {
    // TODO: implement updateToDoEntry
    throw UnimplementedError();
  }

}