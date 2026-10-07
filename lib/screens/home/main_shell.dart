import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../settings/settings_screen.dart';
import '../../features/calendar/screens/calendar_screen.dart';
import '../../features/tasks/screens/tasks_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const TasksScreen(),
    const CalendarScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.check_circle_rounded), label: 'Tasks'),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_month_rounded), label: 'Calendar'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
      ),
    );
  }
}
