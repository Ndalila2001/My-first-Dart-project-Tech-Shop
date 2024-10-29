import 'package:flutter/material.dart';
import 'package:tech_shop_app2/JsonModels/product_model.dart';
import 'package:tech_shop_app2/screens/favorites_screen.dart';
//import 'package:tech_shop_app2/screens/productdetails_screen.dart';
import 'package:tech_shop_app2/screens/productdetails_screen_test.dart';
import 'package:tech_shop_app2/screens/shopping_cart_screen.dart';

// ignore: must_be_immutable
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  TextEditingController controller = TextEditingController();
  bool searchBar = false;
  String searchQuery = "";
  Color iconColor = Colors.black;

  List<ProductModel> cart = [];
  List<ProductModel> favorites = [];

  @override
  void initState() {
    controller.addListener(update);
    super.initState();
  }

  update() {
    if (controller.text.isEmpty || controller.text.length > 1) {
      setState(() {});
    }
  }

  void addToCart(ProductModel product) {
    setState(() {
      if (!cart.contains(product)) {
        cart.add(product);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${product.title} added to cart')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${product.title} is already in cart')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    searchButton() {
      setState(() {});
    }

    List<ProductModel> filteredProducts = productList
        .where(
          (product) =>
              product.title.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              color: Colors.white,
              icon: Icon(searchBar ? Icons.close : Icons.search),
              onPressed: () {
                setState(() {
                  if (searchBar) {
                    searchBar = false;
                  } else {
                    searchBar = true;
                  }
                });
              },
            )
          ],
          leading: PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'Shopping Cart') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ShoppingCartScreen(
                      cart: cart,
                      onRemoveFromCart: (product) {
                        setState(() {
                          cart.remove(product);
                        });
                      },
                    ),
                  ),
                );
              } else if (value == 'Favorites') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            FavoritesScreen(favorites: favorites)));
              } else if (value == 'Profile') {
                //navigate
              } else if (value == 'Log Out') {
                //handle log out logic
              }
            },
            icon: const Icon(Icons.menu_outlined, color: Colors.white),
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                  value: 'Shopping Cart', child: Text('Shopping Cart')),
              const PopupMenuItem(value: 'Favorites', child: Text('Favorites')),
              const PopupMenuItem(value: 'Profile', child: Text('Profile')),
              const PopupMenuItem(value: 'Log Out', child: Text('Log Out'))
            ],
          ),
          centerTitle: true,
          title: const Text(
            'iTech Online Shop',
            style: TextStyle(
                color: Colors.white,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w700),
          ),
          backgroundColor: const Color(0xFF1D1E1E),
          bottom: searchBar
              ? PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    color: const Color(0xFFCBD7D1),
                    height: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: Center(
                        child: TextField(
                          onChanged: (search) {
                            searchQuery = search;
                          },
                          controller: controller,
                          mouseCursor: MouseCursor.uncontrolled,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () {
                                searchButton();
                              },
                              icon: const Icon(Icons.search),
                            ),
                            hintText: "Search...",
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              : null,
        ),
        backgroundColor: const Color(0xFFCBD7D1),
        body: Center(
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 25),
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: filteredProducts.length,
                itemBuilder: (context, index) {
                  var product = filteredProducts[index];

                  return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              spreadRadius: 1,
                              blurRadius: 6,
                            ),
                          ]),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(
                                    product.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_outline,
                                    color: product.isFavorite
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      product.isFavorite = !product.isFavorite;
                                      if (product.isFavorite) {
                                        if (!favorites.contains(product)) {
                                          favorites.add(product);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      '${product.title} added to favourites')));
                                        }
                                      } else {
                                        favorites.remove(product);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    '${product.title} removed from favorites')));
                                      }
                                    });
                                  },
                                ),
                                IconButton(
                                    icon: const Icon(Icons.shopping_cart,
                                        color: Colors.black),
                                    onPressed: () {
                                      addToCart(product);
                                    })
                              ],
                            ),
                          ),
                          ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetailScreenTest(
                                            product: product,
                                          )));
                            },
                            leading: Image.network(
                              product.thumbnail,
                              height: 80,
                              width: 80,
                            ),
                            title: Text(
                              product.title,
                              style: const TextStyle(
                                  color: Color(0xFF95A1A1),
                                  fontWeight: FontWeight.bold),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(
                                //maxLines: 2,
                                style: const TextStyle(color: Colors.black),
                                'N\$  ${product.price.toString()}'),
                          ),
                        ],
                      ));
                })));
  }
}
