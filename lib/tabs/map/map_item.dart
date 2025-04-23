import 'package:evently/app_theme.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MapItem extends StatelessWidget {
  final Event event;
  MapItem({
    required this.event,
  });
  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(
      context,
    );
    TextTheme textTheme = Theme.of(context).textTheme;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.02, vertical: height * 0.02),
      margin: EdgeInsets.symmetric(
              horizontal: width * 0.02, vertical: height * 0.02)
          .copyWith(right: width * 0.16, bottom: height * 0.05),
      height: height * 0.2,
      constraints: BoxConstraints(maxWidth: width * 0.83),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppTheme.primary),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        spacing: 8,
        children: [
          ClipRect(
            child: Image.asset(
              'assets/images/${event.category.imageName}.png',
              width: width * 0.4,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                event.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: textTheme.headlineMedium,
              ),
              Row(
                children: [
                  Icon(Icons.location_on_outlined),
                  Expanded(
                    child: Text(
                      event.address ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodyLarge,
                      softWrap: true,
                    ),
                  )
                ],
              ),
            ],
          ))
        ],
      ),
    );
  }
}
