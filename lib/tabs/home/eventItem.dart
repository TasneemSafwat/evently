import 'package:evently/app_theme.dart';
import 'package:flutter/material.dart';

class Eventitem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/sport.png',
          width: double.infinity,
          height: MediaQuery.sizeOf(context).height * 0.32,
          fit: BoxFit.fill,
        ),
      ),
      Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text(
              '21',
              style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold, color: AppTheme.primary),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              'Nov',
              style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold, color: AppTheme.primary),
            ),
          ],
        ),
      ),
      Positioned(
        width: MediaQuery.sizeOf(context).width - 32,
        right: 0,
        bottom: 8,
        child: Container(
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: AppTheme.white, borderRadius: BorderRadius.circular(8)),
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Text(
                'Meeting for Updating The Development Method ',
                style:
                    textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.favorite_outline_rounded))
            ],
          ),
        ),
      ),
    ]);
  }
}
