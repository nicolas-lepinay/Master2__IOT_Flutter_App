import 'package:flutter/material.dart';
import 'package:arduino_iot_app/widgets/tabs/calendar_tab.dart';
import 'package:arduino_iot_app/widgets/tabs/login_tab.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int _selectedIndex = 0;

  final List<Widget> _tabs = [
    const CalendarTab(),
    const LoginTab(),
  ];

  final List<BottomNavigationBarItem> _items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month),
      label: 'CALENDAR',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'LOGIN',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes onglets"),
        leading: const BackButton(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.black45,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _tabs.elementAt(_selectedIndex),
    );
  }
}
