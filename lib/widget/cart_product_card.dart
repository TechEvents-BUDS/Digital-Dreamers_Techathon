// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

// import 'dart:convert';

import 'package:bidobid/blocs/cart/cart_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/product/product_bloc.dart';
import '../models/models.dart';
// import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// class CallApi {
//   String baseUrl = "http://10.0.2.2:8000/api/update-product";
//   Future<String> postData(Map<String, dynamic> data) async {
//     try {
//       var response = await http.post(
//         Uri.parse(baseUrl),
//         body: jsonEncode(data),
//         headers: {"Content-Type": "application/json; charset=UTF-8"},
//       );
//       if (response.statusCode == 200) {
//         return "success";
//       } else {
//         return "err";
//       }
//     } catch (SocketException) {
//       return "err";
//     }
//   }
// }

class CartProductCard extends StatefulWidget {
  final Product product;
  final int quantity;

  const CartProductCard({
    super.key,
    required this.product,
    required this.quantity,
  });

  @override
  State<CartProductCard> createState() => _CartProductCardState();
}

class _CartProductCardState extends State<CartProductCard> {
  final _emailController = FirebaseAuth.instance.currentUser!.email;
  final _bidController = TextEditingController();
  Future priceUpdate(String id) async {
    if (double.parse(_bidController.text.trim()) <= widget.product.price + 5) {
      const snackBar =
          SnackBar(content: Text('Bid Higher than 5 dollar from Current Bid'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      await FirebaseFirestore.instance.collection('products').doc(id).update({
        'price': double.parse(_bidController.text.trim()),
        'bidder': _emailController,
      });
      const snackBar = SnackBar(content: Text('Bid Updated Successfully!'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
  // Future update() async {
  //   Map<String, dynamic> data = {
  //     'price': _bidController.text.trim(),
  //     'name': widget.product.name.toString(),
  //   };

  //   String res = await CallApi().postData(data);
  //   if (res == "success") {
  //     const snackBar = SnackBar(content: Text('Bid Launched Successfully!'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   } else {
  //     const snackBar = SnackBar(content: Text('404 | Error'));
  //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Image.network(
            widget.product.imageUrl.toString(),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.name.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.black),
                ),
                const SizedBox(height: 4),
                BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    if (state is ProductLoaded) {
                      List<Product> product = state.products
                          .where((product) => product.id == widget.product.id)
                          .toList();
                      return Text('Current Bid: \$${product[0].price}',
                          style: const TextStyle(
                              fontSize: 15, color: Colors.black));
                    } else {
                      return const Text('Something went wrong!');
                    }
                  },
                ),
              ],
            ),
          ),
          Column(
            children: [
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          context
                              .read<CartBloc>()
                              .add(CartProductRemoved(product: widget.product));
                        },
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(widget.quantity.toString()),
                      IconButton(
                        onPressed: () {
                          context
                              .read<CartBloc>()
                              .add(CartProductAdded(product: widget.product));
                        },
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  );
                },
              ),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(
                        "Enter Your Bid Here",
                      ),
                      content: TextField(
                        controller: _bidController,
                        enableSuggestions: true,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.deepPurple),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: 'Bid',
                          fillColor: Colors.grey[200],
                          filled: true,
                        ),
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              priceUpdate(widget.product.id);
                              Navigator.pop(context);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: Colors.deepPurple,
                          ),
                          child: const Text('Proceed'),
                        ),
                      ],
                    );
                  },
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: Colors.deepPurple,
                ),
                child: const Text('Set Your Bid'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
