import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart'; // Pastikan Anda sudah menambahkan google_nav_bar di pubspec.yaml

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: GNav(
            rippleColor: Colors.grey[300]!,
            hoverColor: Colors.grey[100]!,
            gap: 8,
            activeColor: Colors.blue[800], // Warna ikon aktif
            iconSize: 24,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: const Duration(milliseconds: 400),
            tabBackgroundColor: Colors.blue[100]!,
            color: Colors.grey[600], // Warna ikon tidak aktif
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              // Ini adalah tombol 'Add' yang Anda definisikan.
              // Jika ada tanda '+' hitam lain, itu kemungkinan dari FloatingActionButton di Scaffold induk.
              GButton(
                icon: Icons.add_circle, // Gunakan ikon ini untuk tombol tengah
                text: 'Add',
              ),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
            selectedIndex: selectedIndex,
            onTabChange: onTabChange,
          ),
        ),
      ),
    );
  }
}
