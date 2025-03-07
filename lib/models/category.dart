import 'package:flutter/material.dart';

class Category {
  Category(
      {required this.id,
      required this.name,
      required this.icon,
      required this.imageName});
  String id;
  String name;
  IconData icon;
  String imageName;
  static List<Category> categories = [
    Category(
        id: '1',
        name: 'Sports',
        icon: Icons.sports_basketball_outlined,
        imageName: 'sports'),
    Category(
        id: '2',
        name: 'Birthday',
        icon: Icons.cake_outlined,
        imageName: 'birthday'),
    Category(
        id: '3',
        name: 'Meeting',
        icon: Icons.laptop_chromebook_outlined,
        imageName: 'meeting'),
    Category(
        id: '4',
        name: 'Gaming',
        icon: Icons.games_outlined,
        imageName: 'gaming'),
    Category(
        id: '5',
        name: 'Eating',
        icon: Icons.food_bank_outlined,
        imageName: 'eating'),
    Category(
        id: '6',
        name: 'Holiday',
        icon: Icons.holiday_village_outlined,
        imageName: 'holiday'),
    Category(
        id: '7',
        name: 'Exhibition',
        icon: Icons.lock_clock_sharp,
        imageName: 'exhibition'),
    Category(
        id: '8',
        name: 'Workshop',
        icon: Icons.work_sharp,
        imageName: 'workshop'),
    Category(
        id: '9',
        name: 'Book Club',
        icon: Icons.bookmarks,
        imageName: 'bookclub'),
  ];
}
