// ignore_for_file: prefer_const_constructors, unnecessary_this

import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../models/product_model.dart';
import '../pages/catalog_page.dart';

class HeroCarouselCard extends StatelessWidget {
  const HeroCarouselCard({super.key, this.category, this.product});

  final Category? category;
  final Product? product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (product == null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CatalogPage(category: category!);
              },
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 5.0,
          vertical: 20,
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                Image.network(
                    product == null
                        ? category!.imageUrl.toString()
                        : product!.imageUrl.toString(),
                    fit: BoxFit.cover,
                    width: 1000.0),
                Positioned(
                  bottom: 0.0,
                  left: 0.0,
                  right: 0.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        // ignore: prefer_const_literals_to_create_immutables
                        colors: [
                          Color.fromARGB(200, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    child: Text(
                      product == null ? category!.name : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
