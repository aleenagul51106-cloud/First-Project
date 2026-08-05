import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const DictionaryApp());
}

class DictionaryApp extends StatelessWidget {
  const DictionaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dictionary',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        useMaterial3: true,
      ),
      home: const DictionaryScreen(),
    );
  }
}

/// A single meaning/definition entry
class DefinitionEntry {
  final String partOfSpeech;
  final String definition;
  final String? example;

  DefinitionEntry({
    required this.partOfSpeech,
    required this.definition,
    this.example,
  });
}

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({super.key});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _wordController = TextEditingController();

  // Languages that the free Dictionary API (dictionaryapi.dev) supports
  // with full definitions, part of speech, and examples.
  final Map<String, String> _fullDictionaryLanguages = {
    'English': 'en',
    'Hindi': 'hi',
    'Spanish': 'es',
    'French': 'fr',
    'Japanese': 'ja',
    'Russian': 'ru',
    'German': 'de',
    'Italian': 'it',
    'Korean': 'ko',
    'Arabic': 'ar',
    'Turkish': 'tr',
  };

  // Languages without full-dictionary support here; we fall back to
  // showing an English translation/meaning via a translation service.
  final Map<String, String> _translationOnlyLanguages = {
    'Urdu': 'ur',
    'Persian (Farsi)': 'fa',
    'Pashto': 'ps',
    'Punjabi': 'pa',
    'Bengali': 'bn',
  };

  late Map<String, String> _allLanguages;
  String _selectedLanguage = 'English';

  bool _isLoading = false;
  String? _errorMessage;
  String? _phonetic;
  List<DefinitionEntry> _definitions = [];
  String? _translationFallback;

  @override
  void initState() {
    super.initState();
    _allLanguages = {
      ..._fullDictionaryLanguages,
      ..._translationOnlyLanguages,
    };
  }

  @override
  void dispose() {
    _wordController.dispose();
    super.dispose();
  }

  bool get _isFullDictionarySupported =>
      _fullDictionaryLanguages.containsKey(_selectedLanguage);

  Future<void> _lookupWord() async {
    final word = _wordController.text.trim();
    if (word.isEmpty) {
      setState(() => _errorMessage = 'Please enter a word');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _definitions = [];
      _phonetic = null;
      _translationFallback = null;
    });

    if (_isFullDictionarySupported) {
      await _fetchFullDefinition(word);
    } else {
      await _fetchTranslationFallback(word);
    }
  }

  Future<void> _fetchFullDefinition(String word) async {
    final langCode = _allLanguages[_selectedLanguage];
    try {
      final url = Uri.parse(
        'https://api.dictionaryapi.dev/api/v2/entries/$langCode/${Uri.encodeComponent(word)}',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final entry = data.first;

        final phonetic = entry['phonetic'] as String?;
        final meanings = entry['meanings'] as List;

        final List<DefinitionEntry> parsed = [];
        for (final meaning in meanings) {
          final partOfSpeech = meaning['partOfSpeech'] as String? ?? '';
          final defs = meaning['definitions'] as List;
          for (final d in defs) {
            parsed.add(DefinitionEntry(
              partOfSpeech: partOfSpeech,
              definition: d['definition'] as String? ?? '',
              example: d['example'] as String?,
            ));
          }
        }

        setState(() {
          _phonetic = phonetic;
          _definitions = parsed;
          _isLoading = false;
        });
      } else {
        // Word not found in full dictionary — fall back to translation
        await _fetchTranslationFallback(word, notFoundFirst: true);
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Network error. Check your connection.';
        _isLoading = false;
      });
    }
  }

  Future<void> _fetchTranslationFallback(
      String word, {
        bool notFoundFirst = false,
      }) async {
    final langCode = _allLanguages[_selectedLanguage];
    try {
      // Translate the word to/from English as a simple meaning reference
      final url = Uri.parse(
        'https://api.mymemory.translated.net/get?q=${Uri.encodeComponent(word)}&langpair=$langCode|en',
      );
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final translated =
        data['responseData']?['translatedText'] as String?;

        setState(() {
          _translationFallback = translated;
          _errorMessage = (notFoundFirst && translated == null)
              ? 'Word not found'
              : null;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Word not found';
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

  @override
  Widget build(BuildContext context) {
    final isRtlLanguage = _selectedLanguage == 'Urdu' ||
        _selectedLanguage == 'Arabic' ||
        _selectedLanguage == 'Persian (Farsi)' ||
        _selectedLanguage == 'Pashto';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              // Language selector
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Language',
                      style: TextStyle(fontSize: 13, color: Colors.grey)),
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
                        value: _selectedLanguage,
                        isExpanded: true,
                        items: _allLanguages.keys
                            .map((lang) => DropdownMenuItem(
                          value: lang,
                          child: Text(lang),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedLanguage = value!;
                            _definitions = [];
                            _translationFallback = null;
                            _errorMessage = null;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Note for translation-only languages
              if (!_isFullDictionarySupported)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Full definitions aren\'t available for $_selectedLanguage yet — '
                        'showing an English meaning via translation instead.',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.orange,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),

              // Word input
              TextField(
                controller: _wordController,
                textDirection:
                isRtlLanguage ? TextDirection.rtl : TextDirection.ltr,
                decoration: InputDecoration(
                  labelText: 'Enter a word',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onSubmitted: (_) => _lookupWord(),
              ),
              const SizedBox(height: 16),

              // Search button
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _lookupWord,
                icon: _isLoading
                    ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Icon(Icons.search),
                label: Text(_isLoading ? 'Searching...' : 'Search'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Error message
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),

              // Full dictionary result
              if (_definitions.isNotEmpty) ...[
                Text(
                  _wordController.text.trim(),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (_phonetic != null && _phonetic!.isNotEmpty)
                  Text(
                    _phonetic!,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                const SizedBox(height: 12),
                ..._definitions.take(6).map((entry) => Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (entry.partOfSpeech.isNotEmpty)
                          Text(
                            entry.partOfSpeech,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          entry.definition,
                          style: const TextStyle(fontSize: 15),
                        ),
                        if (entry.example != null) ...[
                          const SizedBox(height: 6),
                          Text(
                            '"${entry.example}"',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Colors.grey,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                )),
              ],

              // Translation-fallback result
              if (_translationFallback != null)
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
                          _wordController.text.trim(),
                          textDirection: isRtlLanguage
                              ? TextDirection.rtl
                              : TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'English meaning:',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _translationFallback!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
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
}