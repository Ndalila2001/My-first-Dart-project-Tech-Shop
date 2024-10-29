import 'package:flutter/material.dart';
import 'package:tech_shop_app2/JsonModels/product_model.dart';

class FavoritesScreen extends StatelessWidget {
  final List<ProductModel> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favorite Products"),
      ),
      body: favorites.isEmpty
          ? const Center(child: Text("No favorites added yet."))
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                var product = favorites[index];
                return ListTile(
                  leading: Image.network(product.thumbnail),
                  title: Text(product.title),
                  subtitle: Text('N\$ ${product.price.toString()}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      // Optional: Handle removal of product from favorites
                    },
                  ),
                );
              },
            ),
    );
  }
}
