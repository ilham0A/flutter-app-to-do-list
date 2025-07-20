import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool _generalNotification = true;
  bool _sound = true;
  bool _vibrate = true;
  bool _appUpdates = true;
  bool _billReminder = true;
  bool _promotion = false;
  bool _discountAvailable = true;
  bool _paymentRequest = false;
  bool _newServiceAvailable = true;
  bool _newTipsAvailable = false;

  Widget _buildNotificationToggle(
    String title,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, color: Colors.black),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.blue[800],
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
          'Notification',
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
              'Common',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            _buildNotificationToggle(
              'General Notification',
              _generalNotification,
              (value) {
                setState(() {
                  _generalNotification = value;
                });
              },
            ),
            _buildNotificationToggle('Sound', _sound, (value) {
              setState(() {
                _sound = value;
              });
            }),
            _buildNotificationToggle('Vibrate', _vibrate, (value) {
              setState(() {
                _vibrate = value;
              });
            }),
            const SizedBox(height: 30),
            const Text(
              'System & services update',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            _buildNotificationToggle('App updates', _appUpdates, (value) {
              setState(() {
                _appUpdates = value;
              });
            }),
            _buildNotificationToggle('Bill Reminder', _billReminder, (value) {
              setState(() {
                _billReminder = value;
              });
            }),
            _buildNotificationToggle('Promotion', _promotion, (value) {
              setState(() {
                _promotion = value;
              });
            }),
            _buildNotificationToggle('Discount Available', _discountAvailable, (
              value,
            ) {
              setState(() {
                _discountAvailable = value;
              });
            }),
            _buildNotificationToggle('Payment Request', _paymentRequest, (
              value,
            ) {
              setState(() {
                _paymentRequest = value;
              });
            }),
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
            _buildNotificationToggle(
              'New Service Available',
              _newServiceAvailable,
              (value) {
                setState(() {
                  _newServiceAvailable = value;
                });
              },
            ),
            _buildNotificationToggle('New Tips Available', _newTipsAvailable, (
              value,
            ) {
              setState(() {
                _newTipsAvailable = value;
              });
            }),
          ],
        ),
      ),
    );
  }
}
