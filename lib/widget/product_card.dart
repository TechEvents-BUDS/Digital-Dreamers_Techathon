// ignore_for_file: prefer_const_constructors

import 'package:bidobid/blocs/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product_model.dart';
import '../pages/admin_product_page.dart';
import '../pages/product_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final double widthFactor;
  final double leftPosition;
  final bool isWishlist;
  final bool isAdminProduct;

  const ProductCard(
      {Key? key,
      required this.product,
      this.widthFactor = 2.5,
      this.leftPosition = 0,
      this.isWishlist = false,
      required this.isAdminProduct})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              if (isAdminProduct) {
                return AdminProductPage(product: product);
              } else {
                return ProductPage(product: product);
              }
            },
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            width: MediaQuery.of(context).size.width / widthFactor,
            height: 150,
            child: Image.network(
              product.imageUrl.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: leftPosition,
            child: Container(
                width: MediaQuery.of(context).size.width / widthFactor -
                    leftPosition,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.black.withAlpha(50),
                )),
          ),
          Positioned(
            bottom: 5,
            left: leftPosition + 5,
            child: Container(
              width: MediaQuery.of(context).size.width / widthFactor -
                  10 -
                  leftPosition,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.deepPurple.withAlpha(150),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name.toString(),
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                          Text('\$${product.price}',
                              style:
                                  TextStyle(fontSize: 13, color: Colors.white)),
                        ],
                      ),
                    ),
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                            ),
                          );
                        }
                        if (state is CartLoaded) {
                          return Expanded(
                            child: Visibility(
                              visible: !isAdminProduct,
                              child: IconButton(
                                icon: Icon(
                                  Icons.add_circle_outline,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  context
                                      .read<CartBloc>()
                                      .add(CartProductAdded(product: product));
                                  final snackBar = SnackBar(
                                      content: Text('Added to your Carts'));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                              ),
                            ),
                          );
                        } else {
                          return Text('Something went wrong!');
                        }
                      },
                    ),
                    isWishlist
                        ? Expanded(
                            child: IconButton(
                              icon: Icon(
                                Icons.delete_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
