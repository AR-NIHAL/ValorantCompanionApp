import 'package:flutter/material.dart';
import 'package:valorant_companion_app/core/widgets/banner_slider.dart';
import 'package:valorant_companion_app/core/widgets/custom_appbar.dart';
import 'package:valorant_companion_app/core/widgets/explore_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F1923),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              CustomAppBar(),
              SizedBox(height: 10),
              BannerSlider(),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: ExploreSection(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}