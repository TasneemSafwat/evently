import 'package:evently/app_theme.dart';
import 'package:evently/models/category.dart';
import 'package:flutter/material.dart';

class TabsItem extends StatelessWidget {
  TabsItem(
      {required this.category,
      required this.isSelected,
      required this.selectedBackgroundColor,
      required this.selectedForeBackgroundColor,
      required this.unselectedForeBackgroundcorlor});
  Category category;
  bool isSelected;
  Color selectedBackgroundColor;
  Color selectedForeBackgroundColor;
  Color unselectedForeBackgroundcorlor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
          decoration: BoxDecoration(
            color: isSelected ? selectedBackgroundColor : Colors.transparent,
            border: isSelected
                ? null
                : Border.all(
                    width: 1,
                    color: isSelected
                        ? Colors.transparent
                        : unselectedForeBackgroundcorlor),
            borderRadius: BorderRadius.circular(46),
          ),
          child: Row(
            children: [
              Icon(
                category.icon,
                color: isSelected
                    ? selectedForeBackgroundColor
                    : unselectedForeBackgroundcorlor,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                category.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isSelected
                        ? selectedForeBackgroundColor
                        : unselectedForeBackgroundcorlor),
              )
            ],
          )),
    );
  }
}
