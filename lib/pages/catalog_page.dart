// ignore_for_file: prefer_const_constructors

import 'package:bidobid/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/product/product_bloc.dart';
import '../models/product_model.dart';
import '../widget/product_card.dart';

class CatalogPage extends StatelessWidget {
  final Category category;
  const CatalogPage({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Products productService = Products();
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          category.name,
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
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurple,
                  ),
                );
              }
              if (state is ProductLoaded) {
                List<Product> categoryProducts = state.products
                    .where((product) => product.category == category.name)
                    .toList();
                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 16,
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.15,
                  ),
                  itemCount: categoryProducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Center(
                      child: ProductCard(
                        product: categoryProducts[index],
                        widthFactor: 2.2,
                        isAdminProduct: false,
                      ),
                    );
                  },
                );
              } else {
                return Text('Something went wrong!');
              }
            },
            // child: FutureBuilder(
            //   future: productService.getAllProduct(),
            //   builder: (context, snapshot) {
            //     if (snapshot.hasData) {
            //       List<Product> categoryProducts = snapshot.data!
            //           .where((product) => product.category == category.name)
            //           .toList();
            //       return GridView.builder(
            //         padding: const EdgeInsets.symmetric(
            //           horizontal: 8.0,
            //           vertical: 16,
            //         ),
            //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //           crossAxisCount: 2,
            //           childAspectRatio: 1.15,
            //         ),
            //         itemCount: categoryProducts.length,
            //         itemBuilder: (BuildContext context, int index) {
            //           return Center(
            //             child: ProductCard(
            //               product: categoryProducts[index],
            //               widthFactor: 2.2,
            //               isAdminProduct: false,
            //             ),
            //           );
            //         },
            //       );
            //     } else {
            //       return Center(
            //         child: CircularProgressIndicator(
            //           color: Colors.deepPurple,
            //         ),
            //       );
            //     }
            //   },
            // ),
          ),
        ),
      ),
    );
  }
}
