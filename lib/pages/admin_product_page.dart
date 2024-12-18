// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:bidobid/blocs/cart/cart_bloc.dart';
import 'package:bidobid/blocs/wishlist/wishlist_bloc.dart';
import 'package:bidobid/widget/widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/product_model.dart';

class AdminProductPage extends StatefulWidget {
  final Product product;

  const AdminProductPage({super.key, required this.product});

  @override
  State<AdminProductPage> createState() => _AdminProductPageState();
}

class _AdminProductPageState extends State<AdminProductPage> {
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
                        final snackBar = SnackBar(
                            content: Text('Saved changes Successfully!'));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                      child: Text('Save Changes'),
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
            ],
          ),
        ),
      ),
    );
  }
}
