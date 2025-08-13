import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_cart_may/controller/product_details_controller.dart';
import 'package:shopping_cart_may/controller/search_screen_controller.dart';
import 'package:shopping_cart_may/view/product_details_screen/product_details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final searchProvider = context.watch<SearchScreenController>();
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Product Search"),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: "Search for a product...",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      if (_searchController.text.length.isEven) {
                        context
                            .read<SearchScreenController>()
                            .searchProducts(query: _searchController.text);
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_searchController.text.isNotEmpty) {
                      context
                          .read<SearchScreenController>()
                          .searchProducts(query: _searchController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Enter a valid product name")));
                    }
                  },
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
                child: searchProvider.isProductsLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Builder(
                        builder: (context) {
                          if (searchProvider.productsList.isEmpty) {
                            return Center(
                              child: Text("No matches found"),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: searchProvider.productsList.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    context
                                        .read<ProductDetailsController>()
                                        .getProductDetails(
                                            pdId: searchProvider
                                                .productsList[index].id
                                                .toString());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ProductDetailsScreen(),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    elevation: 4,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          searchProvider.productsList[index]
                                                  .thumbnail ??
                                              "",
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: Text(
                                        searchProvider
                                                .productsList[index].title ??
                                            "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        searchProvider.productsList[index].price
                                            .toString(),
                                      ),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios,
                                          size: 16),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        },
                      )),
          ],
        ),
      ),
    );
  }
}
