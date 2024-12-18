// ignore_for_file: prefer_const_constructors

import 'package:bidobid/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/product_card.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'WISHLIST',
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
          child: BlocBuilder<WishlistBloc, WishlistState>(
            builder: (context, state) {
              if (state is WishlistLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is WishlistLoaded) {
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    childAspectRatio: 2.4,
                  ),
                  itemCount: state.wishlist.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: ProductCard(
                        product: state.wishlist.products[index],
                        widthFactor: 1.1,
                        leftPosition: 100,
                        isWishlist: true,
                        isAdminProduct: false,
                      ),
                    );
                  },
                );
              } else {
                return Text('Something went Wrong');
              }
            },
          ),
        ),
      ),
    );
  }
}
