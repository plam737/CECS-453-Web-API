import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';
import 'weather_model.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final TextEditingController _cityController = TextEditingController();

  @override
  void dispose() {
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WeatherProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFE8F4FD),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            width: 320,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Top cloud icon
                const Icon(
                  Icons.cloud,
                  size: 64,
                  color: Color(0xFF4FA3E0),
                ),
                const SizedBox(height: 24),

                // City input field
                TextField(
                  controller: _cityController,
                  decoration: InputDecoration(
                    labelText: 'Enter City',
                    labelStyle: const TextStyle(fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(6),
                      borderSide: const BorderSide(color: Colors.black26),
                    ),
                  ),
                  onSubmitted: (_) =>
                      provider.loadWeather(_cityController.text.trim()),
                ),
                const SizedBox(height: 12),

                // Get Weather button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: provider.isLoading
                        ? null
                        : () =>
                            provider.loadWeather(_cityController.text.trim()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF9B8EC4),
                      side: const BorderSide(color: Color(0xFFD4C9ED)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                    ),
                    child: provider.isLoading
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Get Weather',
                            style: TextStyle(fontSize: 13)),
                  ),
                ),
                const SizedBox(height: 24),

                // Error message
                if (provider.errorMessage != null)
                  Text(
                    provider.errorMessage!,
                    style: const TextStyle(color: Colors.red, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),

                // Weather result
                if (provider.weather != null)
                  _buildWeatherResult(provider.weather!),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherResult(WeatherModel weather) {
    return Column(
      children: [
        // Weather icon from OpenWeatherMap
        Image.network(
          weather.iconUrl,
          width: 60,
          height: 60,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.wb_cloudy,
            size: 60,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),

        // Temperature
        Text(
          '${weather.temperature.toStringAsFixed(1)} °C',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),

        // Condition description
        Text(
          weather.description[0].toUpperCase() +
              weather.description.substring(1),
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}