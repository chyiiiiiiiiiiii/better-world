import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_provider.g.dart';

@riverpod
FirebaseFirestore fireStore(FireStoreRef ref) {
  return FirebaseFirestore.instance;
}
