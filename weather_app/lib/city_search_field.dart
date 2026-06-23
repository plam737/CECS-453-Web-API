import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'note_provider.dart';

class CitySearchField extends StatefulWidget {
  const CitySearchField({super.key});

  @override
  State<CitySearchField> createState() => _CitySearchFieldState();
}

class _CitySearchFieldState extends State<CitySearchField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<WeatherProvider>();

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            style: const TextStyle(color: Colors.white),
            textInputAction: TextInputAction.search,
            onSubmitted: (value) => provider.loadWeather(value.trim()),
            decoration: InputDecoration(
              hintText: 'Enter city name…',
              hintStyle: const TextStyle(color: Colors.white70),
              prefixIcon:
                  const Icon(Icons.location_city, color: Colors.white70),
              filled: true,
              fillColor: Colors.white24,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        ElevatedButton(
          onPressed: () => provider.loadWeather(_controller.text.trim()),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text('Search',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}