import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final void Function(int) onTap;
  final int currentIndex;

  BottomNavigationBarWidget({required this.onTap, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.grey,
      onTap: onTap,
      currentIndex: currentIndex,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(AntDesign.search1),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Feather.heart),
          label: 'Favorites',
        ),
        BottomNavigationBarItem(
          icon: Icon(MaterialIcons.book),
          label: 'Bookings',
        ),
        BottomNavigationBarItem(
          icon: Icon(MaterialCommunityIcons.message),
          label: 'Inbox',
        ),
        BottomNavigationBarItem(
          icon: Icon(MaterialIcons.person_outline),
          label: 'Profile',
        ),
      ],
    );
  }
}
