// ignore_for_file: unnecessary_import, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:tech_shop_app2/JsonModels/product_model.dart';
import 'package:tech_shop_app2/screens/banking_details_screen.dart';
import 'package:tech_shop_app2/screens/productdetails_screen_test.dart';

class ShoppingCartScreen extends StatelessWidget {
  const ShoppingCartScreen(
      {super.key,
      required List<ProductModel> cart,
      required Null Function(dynamic product) onRemoveFromCart});

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0;
    cartItems.forEach((item) {
      totalPrice += item.product.price * item.quantity;
    });

    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Shopping Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: cartItems.isEmpty
          ? const Center(
              child: Text('Your cart is empty'),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = cartItems[index];
                      return ListTile(
                        leading: Image.network(cartItem.product.thumbnail),
                        title: Text(cartItem.product.title),
                        subtitle: Text(
                          'N\$ ${cartItem.product.price.toStringAsFixed(3)} x ${cartItem.quantity} = N\$ ${(cartItem.product.price * cartItem.quantity).toStringAsFixed(3)}',
                        ),
                      );
                    },
                  ),
                ),
                // Display total price at the bottom of the screen
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total: N\$ ${totalPrice.toStringAsFixed(3)}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                                  builder: (context) =>
                                      const BankingDetailsScreen())
                              as Route<Object?>);
                    },
                    child: const Text('Checkout',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
    );
  }
}
