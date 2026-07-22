import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // TODO: Move this to a secure place (e.g. --dart-define or a config file
  // that isn't committed) before shipping. Hardcoded keys in source are
  // easy to leak if this repo is ever made public.
  final String apiKey = "3fba4ee7737536949582325bad057f57";

  final TextEditingController cityController =
  TextEditingController(text: "Lahore");

  Map<String, dynamic>? weatherData;
  bool isLoading = false;
  String? errorMessage;

  Future<void> getWeather(String cityName) async {
    if (cityName.trim().isEmpty) return;

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    final url = Uri.parse(
      "https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey&units=metric",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        setState(() {
          weatherData = jsonDecode(response.body);
        });
      } else {
        setState(() {
          errorMessage = "City not found";
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "Something went wrong. Check your connection.";
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  String formatTime(int timestamp) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final hour = time.hour == 0
        ? 12
        : (time.hour > 12 ? time.hour - 12 : time.hour);
    final period = time.hour >= 12 ? "PM" : "AM";
    return "$hour:${time.minute.toString().padLeft(2, '0')} $period";
  }

  // Maps OpenWeather condition codes to a fitting Material icon.
  IconData weatherIcon(String main, {bool isNight = false}) {
    switch (main.toLowerCase()) {
      case "clear":
        return isNight ? Icons.nights_stay_rounded : Icons.wb_sunny_rounded;
      case "clouds":
        return Icons.cloud_rounded;
      case "rain":
      case "drizzle":
        return Icons.grain_rounded;
      case "thunderstorm":
        return Icons.thunderstorm_rounded;
      case "snow":
        return Icons.ac_unit_rounded;
      case "mist":
      case "fog":
      case "haze":
        return Icons.foggy;
      default:
        return Icons.wb_cloudy_rounded;
    }
  }

  // Picks a gradient that matches the current weather + time of day.
  List<Color> backgroundGradient() {
    if (weatherData == null) {
      return [const Color(0xff2c3e50), const Color(0xff4ca1af)];
    }

    final main = weatherData!["weather"][0]["main"].toString().toLowerCase();
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final sunrise = weatherData!["sys"]["sunrise"] as int;
    final sunset = weatherData!["sys"]["sunset"] as int;
    final isNight = now < sunrise || now > sunset;

    if (isNight) {
      return [const Color(0xff0f2027), const Color(0xff203a43), const Color(0xff2c5364)];
    }

    switch (main) {
      case "clear":
        return [const Color(0xff56ccf2), const Color(0xff2f80ed)];
      case "clouds":
        return [const Color(0xff757f9a), const Color(0xffd7dde8)];
      case "rain":
      case "drizzle":
        return [const Color(0xff3a6073), const Color(0xff16222a)];
      case "thunderstorm":
        return [const Color(0xff232526), const Color(0xff414345)];
      case "snow":
        return [const Color(0xffe6dada), const Color(0xff274046)];
      default:
        return [const Color(0xff4facfe), const Color(0xff00f2fe)];
    }
  }

  bool get isNight {
    if (weatherData == null) return false;
    final now = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    final sunrise = weatherData!["sys"]["sunrise"] as int;
    final sunset = weatherData!["sys"]["sunset"] as int;
    return now < sunrise || now > sunset;
  }

  Widget glassCard({required Widget child, EdgeInsets? padding}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.25)),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget infoCard(String title, String value, IconData icon) {
    return glassCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.white70,
              fontSize: 12,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getWeather("Lahore");
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = backgroundGradient();

    return Scaffold(
      body: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: RefreshIndicator(
            color: Colors.white,
            backgroundColor: Colors.black26,
            onRefresh: () => getWeather(cityController.text.trim()),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              child: Column(
                children: [
                  _searchField(),
                  const SizedBox(height: 24),
                  if (isLoading)
                    const Padding(
                      padding: EdgeInsets.only(top: 120),
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                  else if (errorMessage != null)
                    _errorState()
                  else if (weatherData == null)
                      const Padding(
                        padding: EdgeInsets.only(top: 120),
                        child: Text(
                          "Search for a city to see the weather",
                          style: TextStyle(color: Colors.white70, fontSize: 16),
                        ),
                      )
                    else
                      _weatherContent(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _searchField() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: TextField(
        controller: cityController,
        textInputAction: TextInputAction.search,
        onSubmitted: (value) => getWeather(value.trim()),
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          hintText: "Search city…",
          filled: true,
          fillColor: Colors.white,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          prefixIcon: const Icon(Icons.location_on_outlined),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => getWeather(cityController.text.trim()),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _errorState() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Column(
        children: [
          const Icon(Icons.error_outline_rounded,
              color: Colors.white, size: 48),
          const SizedBox(height: 12),
          Text(
            errorMessage!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _weatherContent() {
    final data = weatherData!;
    final now = DateTime.now();
    final dateStr =
        "${_weekday(now.weekday)}, ${_month(now.month)} ${now.day}";

    return Column(
      children: [
        Text(
          data["name"] + (data["sys"]?["country"] != null
              ? ", ${data["sys"]["country"]}"
              : ""),
          style: const TextStyle(
            fontSize: 28,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          dateStr,
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),
        const SizedBox(height: 20),

        Icon(
          weatherIcon(data["weather"][0]["main"], isNight: isNight),
          size: 110,
          color: Colors.white,
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
            ),
          ],
        ),

        const SizedBox(height: 8),

        Text(
          "${data["main"]["temp"].round()}°",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 72,
            fontWeight: FontWeight.w200,
            height: 1,
          ),
        ),

        Text(
          (data["weather"][0]["description"] as String)
              .split(' ')
              .map((w) => w[0].toUpperCase() + w.substring(1))
              .join(' '),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 4),

        Text(
          "H:${data["main"]["temp_max"].round()}°  L:${data["main"]["temp_min"].round()}°  Feels like ${data["main"]["feels_like"].round()}°",
          style: const TextStyle(color: Colors.white70, fontSize: 14),
        ),

        const SizedBox(height: 28),

        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
          children: [
            infoCard("Feels Like", "${data["main"]["feels_like"].round()}°C",
                Icons.thermostat_rounded),
            infoCard("Humidity", "${data["main"]["humidity"]}%",
                Icons.water_drop_rounded),
            infoCard("Pressure", "${data["main"]["pressure"]} hPa",
                Icons.speed_rounded),
            infoCard("Wind", "${data["wind"]["speed"]} m/s",
                Icons.air_rounded),
            infoCard("Wind Dir.", "${data["wind"]["deg"]}°",
                Icons.explore_rounded),
            infoCard(
                "Visibility",
                "${(data["visibility"] / 1000).toStringAsFixed(1)} km",
                Icons.visibility_rounded),
            infoCard("Cloudiness", "${data["clouds"]["all"]}%",
                Icons.cloud_rounded),
            infoCard("Sunrise", formatTime(data["sys"]["sunrise"]),
                Icons.wb_twilight_rounded),
            infoCard("Sunset", formatTime(data["sys"]["sunset"]),
                Icons.nights_stay_rounded),
          ],
        ),
      ],
    );
  }

  String _weekday(int d) => const [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ][d - 1];

  String _month(int m) => const [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ][m - 1];
}