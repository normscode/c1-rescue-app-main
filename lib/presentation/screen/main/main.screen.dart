import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:ralert/presentation/screen/main/profile/profile.screen.dart';
import 'package:ralert/presentation/screen/main/rescuer/emergency.list.screen.dart';
import 'package:ralert/presentation/screen/main/rescuer/rescuer.map.screen.dart';
import 'package:ralert/presentation/screen/main/user/help.screen.dart';
import 'package:ralert/presentation/screen/main/user/user.map.screen.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.userType});

  final String userType;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  static final List<Widget> _userPages = [
    const UserMapScreen(),
    const HelpScreen(),
    const ProfileScreen()
  ];

  static final List<Widget> _rescuerPages = [
    const RescuerMapScreen(),
    const EmergenciesListScreen(),
    const ProfileScreen()
  ];

  void _onNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "RALERT",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: widget.userType == "user"
        ? _userPages.elementAt(_selectedIndex)
        : _rescuerPages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        selectedIconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'MAP',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.info),
            label: widget.userType == "user"
              ? "HELP INFO"
              : "EMERGENCIES",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'PROFILE',
          ),
        ],
      ),
    );
  }
}
