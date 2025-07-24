import 'package:flutter/material.dart';

class Task {
  final String title;
  final String category;
  final String time;
  final String status;
  final Color statusColor;

  Task({
    required this.title,
    required this.category,
    required this.time,
    required this.status,
    required this.statusColor,
  });
}

class AllTasksPage extends StatefulWidget {
  const AllTasksPage({super.key});

  @override
  State<AllTasksPage> createState() => _AllTasksPageState();
}

class _AllTasksPageState extends State<AllTasksPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Task> _allTasks = [];
  List<Task> _filteredTasks = [];

  @override
  void initState() {
    super.initState();
    _allTasks = [
      Task(
        title: 'Wab Perusahaan Minyak Bumi',
        category: 'Web Design',
        time: '10:00 - 11:30 am',
        status: 'On Progress',
        statusColor: Colors.blue[800]!,
      ),
      Task(
        title: 'React JS for E-Commerce Web',
        category: 'Web Design',
        time: '08:00 - 10:00 am',
        status: 'Completed',
        statusColor: Colors.green,
      ),
      Task(
        title: 'Mobile App Development',
        category: 'App Development',
        time: '09:00 - 11:00 am',
        status: 'On Progress',
        statusColor: Colors.blue[800]!,
      ),
      Task(
        title: 'Test 3 Website',
        category: 'Bug Bounty',
        time: '08:00 - 10:00 am',
        status: 'On Progress',
        statusColor: Colors.blue[800]!,
      ),
      Task(
        title: 'UI/UX Research',
        category: 'UI/UX Designer',
        time: '03:00 - 06:00 pm',
        status: 'Completed',
        statusColor: Colors.green,
      ),
    ];
    _filteredTasks = _allTasks;
    _searchController.addListener(_filterTasks);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterTasks);
    _searchController.dispose();
    super.dispose();
  }

  void _filterTasks() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTasks = _allTasks.where((task) {
        return task.title.toLowerCase().contains(query) ||
            task.category.toLowerCase().contains(query) ||
            task.status.toLowerCase().contains(query);
      }).toList();
    });
  }

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
              controller: _searchController,
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
            Text(
              'My Task  ${_filteredTasks.length}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            _filteredTasks.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment,
                              size: 80, color: Colors.grey[300]),
                          const SizedBox(height: 16),
                          Text(
                            _searchController.text.isEmpty
                                ? 'Belum ada tugas di sini!'
                                : 'Tidak ada tugas yang cocok dengan pencarian Anda.',
                            style: const TextStyle(
                                fontSize: 18, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _searchController.text.isEmpty
                                ? 'Coba kata kunci lain atau tambahkan tugas baru.'
                                : 'Coba kata kunci lain atau tambahkan tugas baru.',
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _filteredTasks.length,
                    itemBuilder: (context, index) {
                      final task = _filteredTasks[index];
                      return _buildTaskCard(
                        task.title,
                        task.category,
                        task.time,
                        task.status,
                        task.statusColor,
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
