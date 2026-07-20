import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int counter = 0;

  void increment() {
    setState(() {
      counter++;
    });
  }

  void decrement() {
    setState(() {
      if (counter > 0) counter--;
    });
  }

  void reset() {
    setState(() {
      counter = 0;
    });
  }

  Widget buildButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.4),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 32,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff6A11CB),
              Color(0xff2575FC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.menu,
                    color: Colors.white,
                    size: 70,
                  ),

                  const SizedBox(height: 20),

                  const Text(
                    "Counter App",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "Tap the buttons below",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),

                  const SizedBox(height: 50),

                  Container(
                    width: 260,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: Colors.white30,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 25,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Current Count",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          "$counter",
                          style: const TextStyle(
                            fontSize: 80,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 60),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton(
                        icon: Icons.remove,
                        color: Colors.redAccent,
                        onTap: decrement,
                      ),
                      buildButton(
                        icon: Icons.refresh,
                        color: Colors.orange,
                        onTap: reset,
                      ),
                      buildButton(
                        icon: Icons.add,
                        color: Colors.green,
                        onTap: increment,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}