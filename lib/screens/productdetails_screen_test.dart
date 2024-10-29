import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_shop_app2/JsonModels/product_model.dart';
import 'package:tech_shop_app2/screens/product_screen.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}

// Global cart items list (each entry is a CartItem)
List<CartItem> cartItems = [];

class ProductDetailScreenTest extends StatefulWidget {
  final ProductModel product;
  const ProductDetailScreenTest({super.key, required this.product});

  @override
  State<ProductDetailScreenTest> createState() =>
      _ProductDetailScreenTestState();
}

class _ProductDetailScreenTestState extends State<ProductDetailScreenTest> {
  int _quantity = 1; // Initial quantity

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Product Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              children: [
                // Product Image and Carousel
                Center(
                  child: Image.network(
                    widget.product.thumbnail,
                    height: 200,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: index == 0 ? Colors.black : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Container(
            color: const Color(0xFFCBD7D1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.product.title,
                  style: GoogleFonts.robotoCondensed(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'N\$ ${widget.product.price.toStringAsFixed(3)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Row(
                      children: [
                        _buildQuantityButton(Icons.remove, () {
                          setState(() {
                            if (_quantity > 1) {
                              _quantity--; // Decrease quantity if greater than 1
                            }
                          });
                        }),
                        const SizedBox(width: 8),
                        Text(
                          _quantity.toString(),
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(width: 8),
                        _buildQuantityButton(Icons.add, () {
                          setState(() {
                            _quantity++; // Increase quantity
                          });
                        }),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        // Add to Cart Button
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              // Check if the product is already in the cart
                              final existingItem = cartItems.firstWhere(
                                (item) =>
                                    item.product.title == widget.product.title,
                                orElse: () => CartItem(
                                    product: widget.product, quantity: 0),
                              );

                              if (existingItem.quantity > 0) {
                                // Product already in cart, update the quantity
                                existingItem.quantity += _quantity;
                              } else {
                                // Product not in cart, add it with the selected quantity
                                cartItems.add(CartItem(
                                    product: widget.product,
                                    quantity: _quantity));
                              }
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Added $_quantity ${widget.product.title} to cart'),
                              ),
                            );
                          },
                          child: const Text(
                            'Add to Cart',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),

                        const SizedBox(width: 8),

                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF606868),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProductScreen()));
                          },
                          child: const Text(
                            'Continue Shopping',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for quantity buttons
  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(4),
      ),
      child: IconButton(
        icon: Icon(icon, size: 18),
        onPressed: onPressed,
      ),
    );
  }
}
