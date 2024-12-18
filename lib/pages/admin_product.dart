// ignore_for_file: camel_case_types

import 'package:bidobid/blocs/product/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/models.dart';
import '../widget/widget.dart';

class AdminProduct extends StatefulWidget {
  const AdminProduct({super.key});

  @override
  State<AdminProduct> createState() => _AdminProductState();
}

class _AdminProductState extends State<AdminProduct> {
  // Products productService = Products();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'PRODUCTS',
          style: GoogleFonts.bebasNeue(
            fontSize: 30,
          ),
        ),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: false,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.deepPurple,
                ),
              );
            }
            if (state is ProductLoaded) {
              final List<Product> products = state.products.toList();
              return GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 16,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.15,
                ),
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: ProductCard(
                      product: products[index],
                      widthFactor: 2.2,
                      isAdminProduct: true,
                    ),
                  );
                },
              );
            } else {
              return const Text('Something went wrong!');
            }
          },
        ),
        // child: FutureBuilder(
        //   future: productService.getAllProduct(),
        //   builder: (context, snapshot) {
        //     if (snapshot.hasData) {
        //       List<Product> products = snapshot.data!.toList();
        //       return GridView.builder(
        //         padding: const EdgeInsets.symmetric(
        //           horizontal: 8.0,
        //           vertical: 16,
        //         ),
        //         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //           crossAxisCount: 2,
        //           childAspectRatio: 1.15,
        //         ),
        //         itemCount: products.length,
        //         itemBuilder: (BuildContext context, int index) {
        //           return Center(
        //             child: ProductCard(
        //               product: products[index],
        //               widthFactor: 2.2,
        //               isAdminProduct: true,
        //             ),
        //           );
        //         },
        //       );
        //     } else {
        //       return const Center(
        //         child: CircularProgressIndicator(
        //           color: Colors.deepPurple,
        //         ),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
