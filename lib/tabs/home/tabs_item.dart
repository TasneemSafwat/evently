import 'package:evently/app_theme.dart';
import 'package:evently/models/category.dart';
import 'package:flutter/material.dart';

class TabsItem extends StatelessWidget {
  TabsItem({required this.category, required this.isSelected});
  Category category;
  bool isSelected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Container(
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.white : Colors.transparent,
            border: Border.all(width: 1, color: AppTheme.white),
            borderRadius: BorderRadius.circular(46),
          ),
          child: Row(
            children: [
              Icon(
                category.icon,
                color: isSelected ? AppTheme.primary : AppTheme.white,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                category.name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: isSelected ? AppTheme.primary : AppTheme.white),
              )
            ],
          )),
    );
  }
}
