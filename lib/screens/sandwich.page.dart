import 'package:e_kantin/screens/sandwich_detail.page.dart';
import 'package:flutter/material.dart';
import '../models/sandwich.dart';
import '../services/sandwich_service.dart';
import '../components/ek_bottom_nav_bar.dart';
import 'favorilerim.dart';

class SandwichPage extends StatelessWidget {
  const SandwichPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> bottomIcons = [
      'home.png',
      'wishlist.png',
      'categories.png',
      'cart.png',
      'person.png',
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Sandviçler',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
      ),
      body: FutureBuilder<List<Sandwich>>(
        future: SandwichService().fetchSandwiches(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final sandwiches = snapshot.data!;
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            itemCount: sandwiches.length,
            separatorBuilder: (context, index) =>
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
            itemBuilder: (context, index) {
              final item = sandwiches[index];
              return GestureDetector(
                onTap: () {
                  if (!item.stock) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Ürün tükendi'),
                        duration: Duration(milliseconds: 900),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SandwichDetailPage(
                          imagePath: 'assets/images/sandwichMenu.png',
                          title: item.title,
                          desc: item.desc,
                          price: item.price,
                        ),
                      ),
                    );
                  }
                },
                child: Opacity(
                  opacity: item.stock ? 1.0 : 0.4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(
                            item.image,
                            width: 56,
                            height: 56,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                item.desc,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black54,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Text(
                                    item.price,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.black,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  if (!item.stock)
                                    const Text(
                                      'Tükendi',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: EKBottomNavBar(
        currentIndex: 0,
        parentContext: context,
      ),
    );
  }
}
