// ignore_for_file: override_on_non_overriding_member

import 'package:bidobid/repositories/category/base_category_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/models.dart';

class CategoryRepository extends BaseCategoryRepository {
  final FirebaseFirestore _firebaseFirestore;

  CategoryRepository({FirebaseFirestore? firebaseFirestore})
      : _firebaseFirestore = firebaseFirestore ?? FirebaseFirestore.instance;

  @override
  Stream<List<Category>> getAllCategories() {
    return _firebaseFirestore
        .collection('categories')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromSnapshot(doc)).toList();
    });
  }
}
