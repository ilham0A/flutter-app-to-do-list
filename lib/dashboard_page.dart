import 'package:flutter/material.dart';
import 'package:uas_last/all_tasks_page.dart';

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

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
        time: '10:00 - 12:30 Am',
        status: 'On Progress',
        statusColor: Colors.blue,
      ),
      Task(
        title: 'Mobile App Development',
        category: 'App Development',
        time: '09:00 - 13:00 Am',
        status: 'On Progress',
        statusColor: Colors.blue,
      ),
      Task(
        title: 'Test 3 Website',
        category: 'Bug Bounty',
        time: '08:00 - 10:00 Am',
        status: 'On Progress',
        statusColor: Colors.blue,
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
      _filteredTasks =
          _allTasks.where((task) {
            return task.title.toLowerCase().contains(query) ||
                task.category.toLowerCase().contains(query) ||
                task.status.toLowerCase().contains(query);
          }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Good Morning, Udin',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey[200],
              child: ClipOval(
                child: Image.asset(
                  'assets/images/hacker.jpg',
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                  errorBuilder: (context, error, stackTrace) {
                    print('Error loading profile image (dashboard): $error');
                    return const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blueGrey,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextFormField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Find your task',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
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
              'Categories',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryCard(
                    'Web Design',
                    '12 Projects',
                    '60%',
                    Colors.blue[700]!,
                    Colors.blue[200]!,
                  ),
                  const SizedBox(width: 15),
                  _buildCategoryCard(
                    'Web sekolah',
                    '24 Projects',
                    '45%',
                    Colors.purple[700]!,
                    Colors.purple[200]!,
                  ),
                  const SizedBox(width: 15),
                  _buildCategoryCard(
                    'Mobile App',
                    '8 Projects',
                    '75%',
                    Colors.green[700]!,
                    Colors.green[200]!,
                  ),
                  const SizedBox(width: 15),
                  _buildCategoryCard(
                    'bug bounty',
                    '3 Projects',
                    '10%',
                    const Color.fromARGB(255, 138, 56, 142),
                    const Color.fromARGB(255, 220, 155, 219),
                  ),
                  const SizedBox(width: 15),
                  _buildCategoryCard(
                    'desain logo',
                    '15 Projects',
                    '90%',
                    const Color.fromARGB(255, 7, 73, 188),
                    const Color.fromARGB(255, 104, 118, 138),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'My Task',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AllTasksPage(),
                      ),
                    );
                  },
                  child: Text(
                    'View All',
                    style: TextStyle(color: Colors.blue[800], fontSize: 14),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _filteredTasks.length,
              itemBuilder: (context, index) {
                final task = _filteredTasks[index];
                return _buildTaskItem(
                  title: task.title,
                  category: task.category,
                  time: task.time,
                  status: task.status,
                  statusColor: task.statusColor,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(
    String title,
    String projects,
    String progress,
    Color primaryColor,
    Color secondaryColor,
  ) {
    return Container(
      width: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            projects,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 10),
          LinearProgressIndicator(
            value: double.parse(progress.replaceAll('%', '')) / 100,
            backgroundColor: secondaryColor,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            progress,
            style: TextStyle(
              color: Colors.white.withOpacity(0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem({
    required String title,
    required String category,
    required String time,
    required String status,
    required Color statusColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      time,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
