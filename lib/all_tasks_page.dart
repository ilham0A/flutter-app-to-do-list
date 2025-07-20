import 'package:flutter/material.dart';

class AllTasksPage extends StatelessWidget {
  const AllTasksPage({super.key});

  Widget _buildTaskCard(
    String title,
    String category,
    String time,
    String status,
    Color statusColor,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          'All task',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Find your task',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[100],
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 16.0,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'My Task  4',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _buildTaskCard(
              'Wab Perusahaan Minyak Bumi',
              'Web Design',
              '10:00 - 12:30 am',
              'On Progress',
              Colors.blue[800]!,
            ),
            _buildTaskCard(
              'Perawatan Server Singapura',
              'Web Maintenance',
              '09:00 - 13:00 am',
              'On Progress',
              Colors.blue[800]!,
            ),
            _buildTaskCard(
              'React JS for E-Commerce Web',
              'Web Design',
              '08:00 - 10:00 am',
              'On Progress',
              Colors.blue[800]!,
            ),
            _buildTaskCard(
              'Mobile App Development',
              'App Development',
              '14:00 - 17:00 am',
              'On Progress',
              Colors.blue[800]!,
            ),
            _buildTaskCard(
              'UI/UX Research',
              'UI/UX Designer',
              '15:00 - 18:00 am',
              'Completed',
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }
}
