// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String name;
  final String imageUrl;

  const Category({
    required this.name,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [name, imageUrl];

  static Category fromSnapshot(DocumentSnapshot snap) {
    Category category =
        Category(name: snap['name'], imageUrl: snap['imageUrl']);
    return category;
  }

  static List<Category> categories = [
    Category(
        name: 'Furniture',
        imageUrl:
            'https://images.unsplash.com/photo-1524758631624-e2822e304c36?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8ZnVybml0dXJlfGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
    Category(
        name: 'Smart Devices',
        imageUrl:
            'https://images.unsplash.com/photo-1524289286702-f07229da36f5?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8c21hcnQlMjBkZXZpY2VzfGVufDB8fDB8fA%3D%3D&w=1000&q=80'),
    Category(
      name: 'Clothing',
      imageUrl:
          'https://images.unsplash.com/photo-1523381210434-271e8be1f52b?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
    ),
  ];
}
