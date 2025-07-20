import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTimeFrom = TimeOfDay.now();
  TimeOfDay _selectedTimeTo = TimeOfDay.now();

  final List<String> _categories = [
    'Design Logo',
    'Web Design',
    'Designer',
    'Web Maintenance',
    'UI/UX Designer',
    'Website',
    'Bug Bounty',
    'App Development',
  ];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    if (_categories.isNotEmpty) {
      _selectedCategory = _categories[0];
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[800]!,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blue[800]),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && !_isSameDate(picked, _selectedDate)) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isFromTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isFromTime ? _selectedTimeFrom : _selectedTimeTo,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue[800]!,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: Colors.blue[800]),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        if (isFromTime) {
          _selectedTimeFrom = picked;
        } else {
          _selectedTimeTo = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final DateTime yesterday = DateTime.now().subtract(const Duration(days: 1));
    final DateTime today = DateTime.now();
    final DateTime tomorrow = DateTime.now().add(const Duration(days: 1));

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
          'Add',
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
              'Select the date',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateOption(
                  DateFormat('dd').format(yesterday),
                  DateFormat('EE').format(yesterday),
                  _isSameDate(_selectedDate, yesterday),
                  () {
                    setState(() {
                      _selectedDate = yesterday;
                    });
                  },
                ),
                _buildDateOption(
                  DateFormat('dd').format(today),
                  DateFormat('EE').format(today),
                  _isSameDate(_selectedDate, today),
                  () {
                    setState(() {
                      _selectedDate = today;
                    });
                  },
                ),
                _buildDateOption(
                  DateFormat('dd').format(tomorrow),
                  DateFormat('EE').format(tomorrow),
                  _isSameDate(_selectedDate, tomorrow),
                  () {
                    setState(() {
                      _selectedDate = tomorrow;
                    });
                  },
                ),
                _buildDateOption(
                  'Other',
                  'Date',
                  !_isSameDate(_selectedDate, yesterday) &&
                      !_isSameDate(_selectedDate, today) &&
                      !_isSameDate(_selectedDate, tomorrow),
                  () => _selectDate(context),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              'Select time',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context, true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _selectedTimeFrom.format(context),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_forward_ios),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _selectTime(context, false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _selectedTimeTo.format(context),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add category',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    print('Add new category');
                  },
                  child: Icon(Icons.add, color: Colors.blue[800]),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children:
                  _categories.map((category) {
                    bool isSelected = _selectedCategory == category;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedCategory = category;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.blue[800] : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  print('Save button pressed');
                  print('Selected Date: ${_selectedDate.toIso8601String()}');
                  print(
                    'Selected Time From: ${_selectedTimeFrom.format(context)}',
                  );
                  print('Selected Time To: ${_selectedTimeTo.format(context)}');
                  print('Selected Category: $_selectedCategory');
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink[600],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  Widget _buildDateOption(
    String dayNum,
    String dayName,
    bool isSelected,
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue[800] : Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              dayNum,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            Text(
              dayName,
              style: TextStyle(
                fontSize: 14,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
