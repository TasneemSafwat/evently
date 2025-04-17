import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/eventItem.dart';
import 'package:evently/widges/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoveTab extends StatefulWidget {
  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late EventProvider eventProvider;
  late UserProvider userProvider;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      List<String> favouriteEventIds =
          Provider.of<UserProvider>(context, listen: false)
              .currentUser!
              .favouriteEventIds;
      eventProvider.filterFavoriteEvents(favouriteEventIds);
    });
  }

  @override
  Widget build(BuildContext context) {
    eventProvider = Provider.of<EventProvider>(
      context,
    );
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            DefaultTextFormField(
              onChanged: (quary) {},
              hintText: 'Search for event',
              prefixIconImageName: 'Search',
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (_, index) =>
                    Eventitem(eventProvider.favouriteEvent[index]),
                itemCount: eventProvider.favouriteEvent.length,
                separatorBuilder: (_, __) => SizedBox(
                  height: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
