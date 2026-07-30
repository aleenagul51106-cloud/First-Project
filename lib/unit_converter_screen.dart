import 'package:flutter/material.dart';

void main() {
  runApp(const UnitConverterApp());
}

class UnitConverterApp extends StatelessWidget {
  const UnitConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFF4F6F8),
        useMaterial3: true,
      ),
      home: const UnitConverterScreen(),
    );
  }
}

class UnitConverterScreen extends StatefulWidget {
  const UnitConverterScreen({super.key});

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  final TextEditingController _inputController =
  TextEditingController(text: '1');

  // Categories and their units
  final Map<String, List<String>> _categories = {
    'Temperature': ['Celsius', 'Fahrenheit', 'Kelvin'],
    'Length': ['Meters', 'Kilometers', 'Miles', 'Feet', 'Inches'],
    'Weight': ['Kilograms', 'Grams', 'Pounds', 'Ounces'],
  };

  String _selectedCategory = 'Temperature';
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';

  double? _result;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convert);
    _convert();
  }

  @override
  void dispose() {
    _inputController.removeListener(_convert);
    _inputController.dispose();
    super.dispose();
  }

  void _convert() {
    final text = _inputController.text.trim();
    if (text.isEmpty) {
      setState(() {
        _result = null;
        _errorMessage = null;
      });
      return;
    }

    final value = double.tryParse(text);
    if (value == null) {
      setState(() {
        _result = null;
        _errorMessage = 'Enter a valid number';
      });
      return;
    }

    double? converted;
    if (_selectedCategory == 'Temperature') {
      converted = _convertTemperature(value, _fromUnit, _toUnit);
    } else if (_selectedCategory == 'Length') {
      converted = _convertViaBase(value, _fromUnit, _toUnit, _lengthToMeters);
    } else if (_selectedCategory == 'Weight') {
      converted = _convertViaBase(value, _fromUnit, _toUnit, _weightToGrams);
    }

    setState(() {
      _result = converted;
      _errorMessage = null;
    });
  }

  // --- Temperature conversion (special case: not a simple multiplier) ---
  double _convertTemperature(double value, String from, String to) {
    if (from == to) return value;

    // Step 1: convert input to Celsius
    double celsius;
    switch (from) {
      case 'Celsius':
        celsius = value;
        break;
      case 'Fahrenheit':
        celsius = (value - 32) * 5 / 9;
        break;
      case 'Kelvin':
        celsius = value - 273.15;
        break;
      default:
        celsius = value;
    }

    // Step 2: convert Celsius to target unit
    switch (to) {
      case 'Celsius':
        return celsius;
      case 'Fahrenheit':
        return (celsius * 9 / 5) + 32;
      case 'Kelvin':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }

  // --- Length: base unit = meters ---
  final Map<String, double> _lengthToMeters = {
    'Meters': 1.0,
    'Kilometers': 1000.0,
    'Miles': 1609.34,
    'Feet': 0.3048,
    'Inches': 0.0254,
  };

  // --- Weight: base unit = grams ---
  final Map<String, double> _weightToGrams = {
    'Kilograms': 1000.0,
    'Grams': 1.0,
    'Pounds': 453.592,
    'Ounces': 28.3495,
  };

  // Generic converter: value -> base unit -> target unit
  double _convertViaBase(
      double value,
      String from,
      String to,
      Map<String, double> unitToBase,
      ) {
    final baseValue = value * unitToBase[from]!;
    return baseValue / unitToBase[to]!;
  }

  void _onCategoryChanged(String? category) {
    if (category == null) return;
    setState(() {
      _selectedCategory = category;
      final units = _categories[category]!;
      _fromUnit = units[0];
      _toUnit = units.length > 1 ? units[1] : units[0];
    });
    _convert();
  }

  void _swapUnits() {
    setState(() {
      final temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
    });
    _convert();
  }

  String _unitAbbreviation(String unit) {
    const abbreviations = {
      'Celsius': '°C',
      'Fahrenheit': '°F',
      'Kelvin': 'K',
      'Meters': 'm',
      'Kilometers': 'km',
      'Miles': 'mi',
      'Feet': 'ft',
      'Inches': 'in',
      'Kilograms': 'kg',
      'Grams': 'g',
      'Pounds': 'lb',
      'Ounces': 'oz',
    };
    return abbreviations[unit] ?? unit;
  }

  @override
  Widget build(BuildContext context) {
    final units = _categories[_selectedCategory]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),

              // Category selector
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedCategory,
                    isExpanded: true,
                    items: _categories.keys
                        .map((cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(cat),
                    ))
                        .toList(),
                    onChanged: _onCategoryChanged,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Amount input
              TextField(
                controller: _inputController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: true,
                ),
                decoration: InputDecoration(
                  labelText: 'Value',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),

              // From / To unit selectors
              Row(
                children: [
                  Expanded(
                    child: _buildUnitDropdown(
                      label: 'From',
                      value: _fromUnit,
                      units: units,
                      onChanged: (value) {
                        setState(() => _fromUnit = value!);
                        _convert();
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.swap_horiz, size: 28),
                    onPressed: _swapUnits,
                    tooltip: 'Swap units',
                  ),
                  Expanded(
                    child: _buildUnitDropdown(
                      label: 'To',
                      value: _toUnit,
                      units: units,
                      onChanged: (value) {
                        setState(() => _toUnit = value!);
                        _convert();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),

              // Error message
              if (_errorMessage != null)
                Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),

              // Result card
              if (_result != null && _errorMessage == null)
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
                          '${_inputController.text} ${_unitAbbreviation(_fromUnit)} =',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${_result!.toStringAsFixed(2)} ${_unitAbbreviation(_toUnit)}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange,
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

  Widget _buildUnitDropdown({
    required String label,
    required String value,
    required List<String> units,
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
              items: units
                  .map((unit) => DropdownMenuItem(
                value: unit,
                child: Text(unit, overflow: TextOverflow.ellipsis),
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