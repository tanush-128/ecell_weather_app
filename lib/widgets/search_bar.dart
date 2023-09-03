import 'package:ecell_weather_app/main.dart';
import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360,
      child: TextField(
        cursorColor: Colors.white,
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.search,
            size: 32,
          ),
          suffixIconColor: Colors.white,
          hintText: "Search",
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(32),
          ),
          filled: true,
          fillColor: cardColor,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}
