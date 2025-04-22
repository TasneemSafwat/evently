import 'package:evently/event_details_screen.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/tabs/home/eventItem.dart';
import 'package:evently/tabs/home/home_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EventProvider eventProvider = Provider.of<EventProvider>(context);

    return Column(
      children: [
        HomeHeader(),
        SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (_, index) {
              var event = eventProvider.filteredEvent[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EventDetailScreen(event: event),
                    ),
                  );
                },
                child: Eventitem(event),
              );
            },
            itemCount: eventProvider.filteredEvent.length,
            separatorBuilder: (_, __) => SizedBox(
              height: 16,
            ),
          ),
        ),
      ],
    );
  }
}
