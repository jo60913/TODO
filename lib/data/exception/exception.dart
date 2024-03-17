class ServerException implements Exception{}

class FirestoreCollectionNotFoundException implements ServerException{
  final String id;
  FirestoreCollectionNotFoundException({required this.id});
}

class FirestoreEntryNotFoundException implements ServerException{
  final String id;
  final String collectionID;
  FirestoreEntryNotFoundException({required this.id,required this.collectionID});
}

class CacheException implements Exception {}

class CollectionNotFoundException implements Exception{}

class EntryNotFoundException implements Exception{}