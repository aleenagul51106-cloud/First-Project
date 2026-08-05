import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class CurrencyConverterScreen extends StatefulWidget {
  const CurrencyConverterScreen({super.key});

  @override
  State<CurrencyConverterScreen> createState() =>
      _CurrencyConverterScreenState();
}

class _CurrencyConverterScreenState extends State<CurrencyConverterScreen> {
  final TextEditingController _amountController =
  TextEditingController(text: '1');

  // List of currencies including PKR (Pakistani Rupee)
  final List<String> _currencies = [
    'USD', // US Dollar
    'PKR', // Pakistani Rupee
    'EUR', // Euro
    'GBP', // British Pound
    'INR', // Indian Rupee
    'AED', // UAE Dirham
    'SAR', // Saudi Riyal
    'JPY', // Japanese Yen
    'AUD', // Australian Dollar
    'CAD', // Canadian Dollar
    'CNY', // Chinese Yuan
  ];

  String _fromCurrency = 'USD';
  String _toCurrency = 'PKR';

  bool _isLoading = false;
  String? _errorMessage;
  double? _convertedAmount;
  double? _exchangeRate;

  Future<void> _convertCurrency() async {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter an amount';
        _convertedAmount = null;
      });
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount < 0) {
      setState(() {
        _errorMessage = 'Please enter a valid number';
        _convertedAmount = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Free, no-key-required exchange rate API
      final url = Uri.parse(
          'https://api.exchangerate-api.com/v4/latest/$_fromCurrency');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final rates = data['rates'] as Map<String, dynamic>;
        final rate = (rates[_toCurrency] as num).toDouble();

        setState(() {
          _exchangeRate = rate;
          _convertedAmount = amount * rate;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Failed to fetch exchange rates. Try again.';
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

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      _convertedAmount = null;
      _exchangeRate = null;
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Currency Converter'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              // Amount input
              TextField(
                controller: _amountController,
                keyboardType:
                const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixIcon: const Icon(Icons.attach_money),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // From / To currency selectors
              Row(
                children: [
                  Expanded(
                    child: _buildCurrencyDropdown(
                      label: 'From',
                      value: _fromCurrency,
                      onChanged: (value) {
                        setState(() {
                          _fromCurrency = value!;
                          _convertedAmount = null;
                        });
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz, size: 28),
                    onPressed: _swapCurrencies,
                    tooltip: 'Swap currencies',
                  ),
                  Expanded(
                    child: _buildCurrencyDropdown(
                      label: 'To',
                      value: _toCurrency,
                      onChanged: (value) {
                        setState(() {
                          _toCurrency = value!;
                          _convertedAmount = null;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Convert button
              ElevatedButton(
                onPressed: _isLoading ? null : _convertCurrency,
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
                    : const Text('Convert', style: TextStyle(fontSize: 16)),
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
              if (_convertedAmount != null && _errorMessage == null)
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          '${_amountController.text} $_fromCurrency =',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_convertedAmount!.toStringAsFixed(2)} $_toCurrency',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '1 $_fromCurrency = ${_exchangeRate!.toStringAsFixed(4)} $_toCurrency',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
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

  Widget _buildCurrencyDropdown({
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
              items: _currencies
                  .map((currency) => DropdownMenuItem(
                value: currency,
                child: Text(currency),
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