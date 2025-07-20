import 'package:flutter/material.dart';

class LanguagePage extends StatefulWidget {
  const LanguagePage({super.key});

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
  String _selectedLanguage = 'English (UK)'; // Default selected language

  Widget _buildLanguageOption(String language, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedLanguage = language;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: TextStyle(
                fontSize: 16,
                color: isSelected ? Colors.blue[800] : Colors.black,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            if (isSelected)
              Icon(Icons.check_circle, color: Colors.blue[800], size: 24),
            if (!isSelected)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.grey, width: 2),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Language',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Suggested',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            _buildLanguageOption(
              'English (US)',
              _selectedLanguage == 'English (US)',
            ),
            _buildLanguageOption(
              'English (UK)',
              _selectedLanguage == 'English (UK)',
            ),
            const SizedBox(height: 30),
            const Text(
              'Others',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            _buildLanguageOption('Mandarin', _selectedLanguage == 'Mandarin'),
            _buildLanguageOption('Hindi', _selectedLanguage == 'Hindi'),
            _buildLanguageOption('Spanish', _selectedLanguage == 'Spanish'),
            _buildLanguageOption('French', _selectedLanguage == 'French'),
            _buildLanguageOption('Arabic', _selectedLanguage == 'Arabic'),
            _buildLanguageOption('Russian', _selectedLanguage == 'Russian'),
            _buildLanguageOption('Indonesia', _selectedLanguage == 'Indonesia'),
            _buildLanguageOption(
              'Vietnamese',
              _selectedLanguage == 'Vietnamese',
            ),
          ],
        ),
      ),
    );
  }
}
