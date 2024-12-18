// ignore_for_file: prefer_collection_literals

import 'package:equatable/equatable.dart';

import 'product_model.dart';

class Cart extends Equatable {
  final List<Product> products;
  const Cart({this.products = const <Product>[]});

  Map productQuantity(products) {
    var quantity = Map();

    products.forEach((product) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    });

    return quantity;
  }

  double get subTotal => products.fold(
      0, (previousValue, element) => previousValue + element.price.toDouble());

  double deliveryFee(subTotal) {
    if (subTotal >= 30) {
      return 0.0;
    } else {
      return 10.0;
    }
  }

  String freeDelivery(subTotal) {
    if (subTotal >= 30) {
      return 'You have Free Delivery';
    } else {
      double missing = 30.00 - subTotal;
      return 'Add \$ ${missing.toStringAsFixed(2)} for FREE Delivery';
    }
  }

  String get subTotalString => subTotal.toStringAsFixed(2);

  String get deliveryFeeString => deliveryFee(subTotal).toStringAsFixed(2);

  String get totalString =>
      (subTotal + deliveryFee(subTotal)).toStringAsFixed(2);

  String get freeDeliveryString => freeDelivery(subTotal);

  @override
  List<Object> get props => [products];
}
