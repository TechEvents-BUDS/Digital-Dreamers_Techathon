// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, non_constant_identifier_names, unused_field

import 'dart:async';

import 'package:bidobid/blocs/cart/cart_bloc.dart';
import 'package:bidobid/blocs/wishlist/wishlist_bloc.dart';
import 'package:bidobid/widget/widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/product_model.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  const ProductPage({super.key, required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int _seconds = 0;
  int _minutes = 0;
  int _hours = 0;
  int _days = 0;
  Timer? _timer;
  bool showHighestBidder = false;
  bool showHighestBidderAsOfNow = true;
  timeLeft(DateTime endDate) {
    DateTime dt1 = endDate;
    DateTime dt2 = DateTime.now();
    Duration diff = dt1.difference(dt2);
    _days = diff.inDays;
    _hours = diff.inHours.remainder(24);
    _minutes = diff.inMinutes.remainder(60);
    _seconds = diff.inSeconds.remainder(60);
    if (diff.isNegative) {
      showHighestBidder = true;
      showHighestBidderAsOfNow = false;
      return 'Time is Up!';
    } else {
      _timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (mounted) {
            setState(
              () {
                if (_seconds > 0) {
                  _seconds--;
                } else {
                  if (_minutes > 0) {
                    _minutes--;
                    _seconds = 59;
                  } else {
                    if (_hours > 0) {
                      _hours--;
                      _minutes = 59;
                      _seconds = 59;
                    } else {
                      if (_days > 0) {
                        _days--;
                        _hours = 23;
                        _minutes = 59;
                        _seconds = 59;
                      } else {
                        _timer?.cancel();
                      }
                    }
                  }
                }
              },
            );
          }
        },
      );
      return '${_days.toString().padLeft(2, '0')}:${_hours.toString().padLeft(2, '0')}:${_minutes.toString().padLeft(2, '0')}:${_seconds.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.product.name.toString(),
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
          ),
        ),
        elevation: 0,
        centerTitle: false,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[200],
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.message_outlined),
              ),
              BlocBuilder<WishlistBloc, WishlistState>(
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context
                          .read<WishlistBloc>()
                          .add(AddWishlistProduct(widget.product));
                      final snackBar =
                          SnackBar(content: Text('Added to your Wishlist'));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    icon: Icon(Icons.favorite_outline_rounded),
                  );
                },
              ),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is CartLoaded) {
                    return ElevatedButton(
                      onPressed: () {
                        context
                            .read<CartBloc>()
                            .add(CartProductAdded(product: widget.product));
                        final snackBar =
                            SnackBar(content: Text('Added to your Carts'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      child: Text('Add to Cart'),
                    );
                  } else {
                    return Text('Something went wrong!');
                  }
                },
              ),
            ],
          ),
        ),
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
          child: ListView(
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  aspectRatio: 1.5,
                  viewportFraction: 0.9,
                  enlargeStrategy: CenterPageEnlargeStrategy.height,
                  enlargeCenterPage: true,
                ),
                items: [HeroCarouselCard(product: widget.product)],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 60,
                      alignment: Alignment.bottomCenter,
                      color: Colors.black.withAlpha(50),
                    ),
                    Container(
                      margin: const EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width - 10,
                      height: 50,
                      color: Colors.deepPurple.withAlpha(150),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, top: 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.product.name.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.white),
                            ),
                            Text('Starting Bid: \$ ${widget.product.price}',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  textColor: Colors.deepPurple,
                  iconColor: Colors.deepPurple,
                  title: Text('Product Infomation',
                      style: TextStyle(fontSize: 18)),
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    ListTile(
                      title: Text(
                        widget.product.productInformation.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: ExpansionTile(
                  initiallyExpanded: true,
                  textColor: Colors.deepPurple,
                  iconColor: Colors.deepPurple,
                  title: Text('Delivery Infomation',
                      style: TextStyle(fontSize: 18)),
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    ListTile(
                      title: Text(
                        widget.product.deliveryInformation.toString(),
                        style: TextStyle(fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      timeLeft(widget.product.endDate.toDate()),
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Visibility(
                        visible: showHighestBidderAsOfNow,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('products')
                              .doc(widget.product.id)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return Text('Loading...');
                            } else {
                              var productDoc = snapshot.data;
                              var bidder = productDoc!['bidder'];
                              if (bidder == '') {
                                return Text(
                                  'Be The First One To Bid',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.deepPurple),
                                );
                              }
                              return Text(
                                '$bidder is the highest Bidder',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.deepPurple),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Visibility(
                      visible: showHighestBidder,
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('products')
                            .doc(widget.product.id)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Text('Loading...');
                          } else {
                            var productDoc = snapshot.data;
                            return Text(
                              '${productDoc!['bidder']} is the WINNER!',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.deepPurple),
                            );
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel(); //cancel the periodic task
    }
    super.dispose();
  }
}
