import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  // Logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to logout?"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("NO"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text("YES"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,

        // Left Side Title
        title: const Text(
          "Foodie",
          style: TextStyle(
            color: Colors.orange,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Right Side Icons
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart, color: Colors.black),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),

      // ================= BODY =================

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Text
              const Text(
                "Welcome 👋",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "What would you like to eat today?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 20),

              // Search Box
              TextField(
                decoration: InputDecoration(
                  hintText: "Search food...",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Categories
              const Text(
                "Categories",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _categoryCard(Icons.fastfood, "Burger"),
                  _categoryCard(Icons.local_pizza, "Pizza"),
                  _categoryCard(Icons.icecream, "Dessert"),
                  _categoryCard(Icons.local_drink, "Drinks"),
                ],
              ),

              const SizedBox(height: 30),

              // Popular Foods
              const Text(
                "Popular Foods",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              _foodCard(
                "Cheese Burger",
                "\$8.99",
                Icons.lunch_dining,
              ),

              const SizedBox(height: 15),

              _foodCard(
                "Pepperoni Pizza",
                "\$12.99",
                Icons.local_pizza,
              ),

              const SizedBox(height: 15),

              _foodCard(
                "Cold Coffee",
                "\$4.99",
                Icons.local_cafe,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Category Widget
  Widget _categoryCard(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.orange.shade100,
          child: Icon(icon, color: Colors.orange, size: 30),
        ),
        const SizedBox(height: 8),
        Text(title),
      ],
    );
  }

  // Food Card Widget
  Widget _foodCard(String title, String price, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 28,
          backgroundColor: Colors.orange.shade100,
          child: Icon(icon, color: Colors.orange),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(price),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
          onPressed: () {},
          child: const Text("Add"),
        ),
      ),
    );
  }
}