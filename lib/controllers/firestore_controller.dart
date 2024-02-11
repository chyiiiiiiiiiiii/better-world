import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firestore_controller.g.dart';

@riverpod
FirebaseFirestore fireStore(FireStoreRef ref) {
  return FirebaseFirestore.instance;
}
