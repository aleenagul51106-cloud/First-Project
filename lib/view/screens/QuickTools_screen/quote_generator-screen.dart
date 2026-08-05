import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;


class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen>
    with SingleTickerProviderStateMixin {
  // A set of soft, Pinterest-style gradient palettes
  final List<List<Color>> _gradients = [
    [const Color(0xFFFFDEE9), const Color(0xFFB5FFFC)],
    [const Color(0xFFFDCBF1), const Color(0xFFE6DEE9)],
    [const Color(0xFFA1C4FD), const Color(0xFFC2E9FB)],
    [const Color(0xFFFFF1EB), const Color(0xFFACE0F9)],
    [const Color(0xFFD4FC79), const Color(0xFF96E6A1)],
    [const Color(0xFFE0C3FC), const Color(0xFF8EC5FC)],
    [const Color(0xFFFBC2EB), const Color(0xFFA6C1EE)],
    [const Color(0xFFFDFBFB), const Color(0xFFEBEDEE)],
    [const Color(0xFFFFECD2), const Color(0xFFFCB69F)],
    [const Color(0xFF89F7FE), const Color(0xFF66A6FF)],
  ];

  late List<Color> _currentGradient;

  bool _isLoading = false;
  String? _errorMessage;
  String _quote = '';
  String _author = '';

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;


  @override
  void initState() {
    super.initState();
    _currentGradient = _gradients[Random().nextInt(_gradients.length)];

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fetchQuote();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _fetchQuote() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    _fadeController.reset();

    try {
      // Free, no-key-required random quote API
      final url = Uri.parse('https://zenquotes.io/api/random');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final entry = data.first;

        setState(() {
          _quote = (entry['q'] as String).trim();
          _author = (entry['a'] as String).trim();
          _currentGradient = _gradients[Random().nextInt(_gradients.length)];
          _isLoading = false;
        });
        _fadeController.forward();
      } else {
        setState(() {
          _errorMessage = 'Could not fetch a quote. Try again.';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error. Check your connection.';
        _isLoading = false;
      });
    }
  }

  void _copyQuote() {
    if (_quote.isEmpty) return;
    Clipboard.setData(ClipboardData(text: '"$_quote" — $_author'));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Quote copied to clipboard'),
        duration: Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: _currentGradient,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Decorative quotation mark
                Text(
                  '"',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 90,
                    height: 0.4,
                    fontWeight: FontWeight.w700,
                    color: Colors.black.withOpacity(0.25),
                  ),
                ),
                const SizedBox(height: 10),

                // Quote card content
                Expanded(
                  flex: 6,
                  child: Center(
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.black54)
                        : _errorMessage != null
                        ? Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    )
                        : FadeTransition(
                      opacity: _fadeAnimation,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _quote,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 26,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                                height: 1.4,
                                color: const Color(0xFF2B2B2B),
                              ),
                            ),
                            const SizedBox(height: 22),
                            Container(
                              width: 40,
                              height: 2,
                              color: Colors.black.withOpacity(0.4),
                            ),
                            const SizedBox(height: 14),
                            Text(
                              _author.isEmpty
                                  ? 'Unknown'
                                  : _author.toUpperCase(),
                              textAlign: TextAlign.center,
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),

                // Action buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _CircleActionButton(
                      icon: Icons.copy_rounded,
                      onTap: _copyQuote,
                    ),
                    const SizedBox(width: 20),
                    _PrimaryActionButton(
                      isLoading: _isLoading,
                      onTap: _fetchQuote,
                    ),
                    const SizedBox(width: 20),
                    _CircleActionButton(
                      icon: Icons.favorite_border_rounded,
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Saved to favorites'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Small circular icon button (copy, favorite, etc.)
class _CircleActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withOpacity(0.5),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Icon(icon, color: Colors.black87, size: 22),
        ),
      ),
    );
  }
}

/// Main "New Quote" button
class _PrimaryActionButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _PrimaryActionButton({
    required this.isLoading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black87,
      shape: const CircleBorder(),
      elevation: 4,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: isLoading ? null : onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: isLoading
              ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : const Icon(Icons.refresh_rounded, color: Colors.white, size: 26),
        ),
      ),
    );
  }
}