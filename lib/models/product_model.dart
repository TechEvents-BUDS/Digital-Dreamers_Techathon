// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String name;
  final String category;
  final String imageUrl;
  final double price;
  final bool isRecommended;
  final bool isPopular;
  final String ownerEmail;
  final Timestamp endDate;
  final String productInformation;
  final String deliveryInformation;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
    required this.price,
    required this.isRecommended,
    required this.isPopular,
    required this.ownerEmail,
    required this.endDate,
    required this.productInformation,
    required this.deliveryInformation,
  });

  static Product fromSnapshot(DocumentSnapshot snap) {
    Product product = Product(
      id: snap.id,
      name: snap['name'],
      category: snap['category'],
      imageUrl: snap['imageUrl'],
      price: snap['price'],
      isRecommended: snap['isRecommended'],
      isPopular: snap['isPopular'],
      deliveryInformation: snap['deliveryInformation'],
      productInformation: snap['productInformation'],
      ownerEmail: snap['ownerEmail'],
      endDate: snap['endDate'],
    );
    return product;
  }

  @override
  List<Object> get props =>
      [name, category, imageUrl, price, isPopular, isRecommended];

  // static List<Product> products = [
  //   Product(
  //     name: 'Chair',
  //     category: 'Furniture',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1581539250439-c96689b516dd?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2hhaXJ8ZW58MHx8MHx8&w=1000&q=80',
  //     price: 2.99,
  //     ownerEmail: 'usama@gmail.com',
  //     endDate: DateFormat('dd-MM-yyyy'),
  //     isPopular: true,
  //     isRecommended: false,
  //     deliveryInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //     productInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //   ),
  //   Product(
  //     name: 'Table',
  //     category: 'Furniture',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1581428982868-e410dd047a90?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
  //     price: 9.99,
  //     ownerEmail: 'usama@gmail.com',
  //     endDate: 25-06-2023,
  //     isRecommended: true,
  //     isPopular: false,
  //     deliveryInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //     productInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //   ),
  //   Product(
  //     name: 'Shirt',
  //     category: 'Clothing',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1596755094514-f87e34085b2c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8U2hpcnR8ZW58MHx8MHx8&w=1000&q=80',
  //     price: 2.99,
  //     ownerEmail: 'usama@gmail.com',
  //     endDate: '25-06-2023',
  //     isPopular: true,
  //     isRecommended: false,
  //     deliveryInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //     productInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //   ),
  //   Product(
  //     name: 'Pant',
  //     category: 'Clothing',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1602293589930-45aad59ba3ab?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
  //     price: 9.99,
  //     ownerEmail: 'usama@gmail.com',
  //     endDate: '25-06-2023',
  //     isRecommended: true,
  //     isPopular: false,
  //     deliveryInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //     productInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //   ),
  //   Product(
  //     name: 'iPhone',
  //     category: 'Smart Devices',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1537589376225-5405c60a5bd8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fElwaG9uZXxlbnwwfHwwfHw%3D&w=1000&q=80',
  //     price: 999.99,
  //     ownerEmail: 'usama@gmail.com',
  //     endDate: '25-06-2023',
  //     isPopular: true,
  //     isRecommended: false,
  //     deliveryInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //     productInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //   ),
  //   Product(
  //     name: 'iPad',
  //     category: 'Smart Devices',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1561154464-82e9adf32764?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
  //     price: 1129.99,
  //     ownerEmail: 'usama@gmail.com',
  //     endDate: '25-06-2023',
  //     isRecommended: true,
  //     isPopular: false,
  //     deliveryInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //     productInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //   ),
  //   Product(
  //     name: 'Sofa Set',
  //     category: 'Furniture',
  //     imageUrl:
  //         'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1000&q=80',
  //     price: 449.99,
  //     ownerEmail: 'usama@gmail.com',
  //     endDate: '25-06-2023',
  //     isRecommended: true,
  //     isPopular: false,
  //     deliveryInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //     productInformation:
  //         'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.',
  //   )
  // ];
}





// import 'dart:convert';

// import 'package:http/http.dart' as http;

// class Products {
//   String baseUrl = "http://10.0.2.2:8000/api/product/";
//   Future<List<Product>> getAllProduct() async {
//     try {
//       var response = await http.get(Uri.parse(baseUrl));
//       if (response.statusCode == 200) {
//         //print(response.body);
//         final List parsedList = json.decode(response.body);

//         List<Product> list =
//             parsedList.map((val) => Product.fromJson(val)).toList();

//         return list;
//       } else {
//         return Future.error("Server Error");
//       }
//     } catch (e) {
//       return Future.error(e);
//     }
//   }
// }

// class Product {
//   // String? id;
//   String? name;
//   String? category;
//   String? imageUrl;
//   double? price;
//   String? ownerEmail;
//   String? endDate;
//   late bool isRecommended;
//   late bool isPopular;
//   String? productInformation;
//   String? deliveryInformation;

//   Product({
//     // required this.id,
//     required this.name,
//     required this.category,
//     required this.imageUrl,
//     required this.price,
//     required this.ownerEmail,
//     required this.endDate,
//     required this.isRecommended,
//     required this.isPopular,
//     required this.deliveryInformation,
//     required this.productInformation,
//   });

//   Product.fromJson(Map<String, dynamic> json) {
//     // id = json['id'];
//     ownerEmail = json['ownerEmail'];
//     name = json['name'];
//     category = json['category'];
//     imageUrl = json['imageUrl'];
//     price = json['price'];
//     endDate = json['endDate'];
//     isRecommended = json['isRecommended'] == 1;
//     isPopular = json['isPopular'] == 1;
//     productInformation = json['productInformation'];
//     deliveryInformation = json['deliveryInformation'];
//   }
// }
