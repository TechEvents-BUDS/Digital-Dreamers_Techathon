// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../blocs/category/category_bloc.dart';
import '../blocs/product/product_bloc.dart';
import '../widget/hero_carousel_card.dart';
import '../widget/product_carousel.dart';
import '../widget/section_title.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  // Products productService = Products();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'HOME PAGE',
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
          child: Column(
            children: [
              BlocBuilder<CategoryBloc, CategoryState>(
                builder: (context, state) {
                  if (state is CategoryLoading) {
                    return Center(
                      child:
                          CircularProgressIndicator(color: Colors.deepPurple),
                    );
                  }
                  if (state is CategoryLoaded) {
                    return CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1.5,
                        viewportFraction: 0.9,
                        enlargeStrategy: CenterPageEnlargeStrategy.height,
                        enlargeCenterPage: true,
                      ),
                      items: state.categories
                          .map((category) =>
                              HeroCarouselCard(category: category))
                          .toList(),
                    );
                  } else {
                    return Text('Something Went Wrong!');
                  }
                },
              ),
              SectionTitle(title: 'RECOMMENDATION'),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 40),
                          CircularProgressIndicator(
                            color: Colors.deepPurple,
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    );
                  }
                  if (state is ProductLoaded) {
                    return ProductCarousel(
                        products: state.products
                            .where((product) => product.isRecommended)
                            .toList());
                  } else {
                    return Text('Something went wrong!');
                  }
                },
              ),
              // FutureBuilder<List<Product>>(
              //   future: productService.getAllProduct(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return ProductCarousel(
              //           products: snapshot.data!
              //               .where((product) => product.isRecommended)
              //               .toList());
              //     } else {
              //       return Center(
              //         child: Column(
              //           children: const [
              //             SizedBox(height: 40),
              //             CircularProgressIndicator(
              //               color: Colors.deepPurple,
              //             ),
              //             SizedBox(height: 40),
              //           ],
              //         ),
              //       );
              //     }
              //   },
              // ),
              SectionTitle(title: 'POPULAR'),
              BlocBuilder<ProductBloc, ProductState>(
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return Center(
                      child: Column(
                        children: const [
                          SizedBox(height: 40),
                          CircularProgressIndicator(
                            color: Colors.deepPurple,
                          ),
                          SizedBox(height: 40),
                        ],
                      ),
                    );
                  }
                  if (state is ProductLoaded) {
                    return ProductCarousel(
                        products: state.products
                            .where((product) => product.isPopular)
                            .toList());
                  } else {
                    return Text('Something went wrong!');
                  }
                },
              ),
              // FutureBuilder<List<Product>>(
              //   future: productService.getAllProduct(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return ProductCarousel(
              //           products: snapshot.data!
              //               .where((product) => product.isPopular)
              //               .toList());
              //     } else {
              //       return Center(
              //         child: Column(
              //           children: const [
              //             SizedBox(height: 40),
              //             CircularProgressIndicator(
              //               color: Colors.deepPurple,
              //             ),
              //             SizedBox(height: 40),
              //           ],
              //         ),
              //       );
              //     }
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
