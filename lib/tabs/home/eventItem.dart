import 'package:evently/app_theme.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Eventitem extends StatelessWidget {
  Eventitem(this.event);
  Event event;

  @override
  Widget build(BuildContext context) {
    bool isFavourite =
        Provider.of<UserProvider>(context).checkIsEventFavourite(event.id);
    TextTheme textTheme = Theme.of(context).textTheme;
    return Stack(children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          'assets/images/${event.category.imageName}.png',
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
              '${event.dateTime.day}',
              style: textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold, color: AppTheme.primary),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              DateFormat('MMM').format(event.dateTime),
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
              Expanded(
                child: Text(
                  event.title,
                  style: textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {
                  if (isFavourite) {
                    Provider.of<UserProvider>(context, listen: false)
                        .removeEventfromFavourite(event.id);
                    Provider.of<EventProvider>(context, listen: false)
                        .removeToFavourite(event.id);
                  } else {
                    Provider.of<UserProvider>(context, listen: false)
                        .addEventToFavourite(event.id);
                    Provider.of<EventProvider>(context, listen: false)
                        .addToFavourite(event.id);
                  }
                },
                icon: Icon(
                  isFavourite
                      ? Icons.favorite_rounded
                      : Icons.favorite_outline_rounded,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    ]);
  }
}
