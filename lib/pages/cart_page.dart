// ignore_for_file: prefer_const_constructors

import 'package:bidobid/auth/navigation.dart';
import 'package:bidobid/blocs/cart/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/widget.dart';

class UserCart extends StatefulWidget {
  const UserCart({super.key});

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'CART',
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
            ),
          ),
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              if (state is CartLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is CartLoaded) {
                return SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(state.cart.freeDeliveryString,
                                    style:
                                        Theme.of(context).textTheme.bodyLarge),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return Navbar();
                                        },
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.deepPurple,
                                  ),
                                  child: Text('Add More Items'),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 450,
                              child: ListView.builder(
                                itemCount: state.cart
                                    .productQuantity(state.cart.products)
                                    .keys
                                    .length,
                                itemBuilder: (context, index) {
                                  return CartProductCard(
                                    product: state.cart
                                        .productQuantity(state.cart.products)
                                        .keys
                                        .elementAt(index),
                                    quantity: state.cart
                                        .productQuantity(state.cart.products)
                                        .values
                                        .elementAt(index),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Divider(
                              thickness: 2,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 11),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'SUBTOTAL',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Text(
                                        '\$ ${state.cart.subTotalString}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'DELIVERY FEE',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Text(
                                        '\$ ${state.cart.deliveryFeeString}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  alignment: Alignment.bottomCenter,
                                  color: Colors.black.withAlpha(50),
                                ),
                                Container(
                                  margin: const EdgeInsets.all(5),
                                  width: MediaQuery.of(context).size.width - 10,
                                  height: 40,
                                  color: Colors.deepPurple.withAlpha(200),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'TOTAL',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '\$ ${state.cart.totalString}',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Text('Something went wrong!');
              }
            },
          ),
        ),
      ),
    );
  }
}
