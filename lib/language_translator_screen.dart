import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const TranslatorApp());
}

class TranslatorApp extends StatelessWidget {
  const TranslatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Translator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        useMaterial3: true,
      ),
      home: const TranslatorScreen(),
    );
  }
}

class TranslatorScreen extends StatefulWidget {
  const TranslatorScreen({super.key});

  @override
  State<TranslatorScreen> createState() => _TranslatorScreenState();
}

class _TranslatorScreenState extends State<TranslatorScreen> {
  final TextEditingController _inputController = TextEditingController();

  // Language name -> language code map (used by the translation API)
  final Map<String, String> _languages = {
    'English': 'en',
    'Urdu': 'ur',
    'Arabic': 'ar',
    'Hindi': 'hi',
    'Persian (Farsi)': 'fa',
    'Pashto': 'ps',
    'Punjabi': 'pa',
    'Bengali': 'bn',
    'French': 'fr',
    'Spanish': 'es',
    'German': 'de',
    'Turkish': 'tr',
    'Chinese': 'zh',
    'Russian': 'ru',
  };

  String _fromLanguage = 'English';
  String _toLanguage = 'Urdu';

  bool _isLoading = false;
  String? _errorMessage;
  String? _translatedText;

  Future<void> _translateText() async {
    final text = _inputController.text.trim();
    if (text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter some text to translate';
        _translatedText = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final fromCode = _languages[_fromLanguage];
      final toCode = _languages[_toLanguage];

      // Free, no-key-required translation API (MyMemory)
      final url = Uri.parse(
        'https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(text)}&langpair=$fromCode|$toCode',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translated =
        data['responseData']?['translatedText'] as String?;

        if (translated == null || translated.isEmpty) {
          setState(() {
            _errorMessage = 'Translation not available. Try again.';
            _isLoading = false;
          });
          return;
        }

        setState(() {
          _translatedText = translated;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to translate. Try again.';
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

  void _swapLanguages() {
    setState(() {
      final temp = _fromLanguage;
      _fromLanguage = _toLanguage;
      _toLanguage = temp;
      _translatedText = null;

      // Also swap the text so users can quickly translate back
      if (_translatedText != null) {
        _inputController.text = _translatedText!;
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Translator'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              // From / To language selectors
              Row(
                children: [
                  Expanded(
                    child: _buildLanguageDropdown(
                      label: 'From',
                      value: _fromLanguage,
                      onChanged: (value) {
                        setState(() {
                          _fromLanguage = value!;
                          _translatedText = null;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz, size: 28),
                    onPressed: _swapLanguages,
                    tooltip: 'Swap languages',
                  ),
                  Expanded(
                    child: _buildLanguageDropdown(
                      label: 'To',
                      value: _toLanguage,
                      onChanged: (value) {
                        setState(() {
                          _toLanguage = value!;
                          _translatedText = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Text input
              TextField(
                controller: _inputController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                  hintText: 'Type something to translate...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // Translate button
              ElevatedButton(
                onPressed: _isLoading ? null : _translateText,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text('Translate', style: TextStyle(fontSize: 16)),
              ),

              const SizedBox(height: 24),

              // Error message
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),

              // Result card
              if (_translatedText != null && _errorMessage == null)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$_toLanguage translation:',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                _translatedText!,
                                textDirection: (_toLanguage == 'Urdu' ||
                                    _toLanguage == 'Arabic' ||
                                    _toLanguage == 'Persian (Farsi)' ||
                                    _toLanguage == 'Pashto')
                                    ? TextDirection.rtl
                                    : TextDirection.ltr,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.copy, size: 20),
                              tooltip: 'Copy translation',
                              onPressed: () {
                                Clipboard.setData(
                                  ClipboardData(text: _translatedText!),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Copied to clipboard'),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageDropdown({
    required String label,
    required String value,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              items: _languages.keys
                  .map((lang) => DropdownMenuItem(
                value: lang,
                child: Text(lang, overflow: TextOverflow.ellipsis),
              ))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}