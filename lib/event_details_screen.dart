import 'package:evently/firebase_service.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/update_event_screen.dart';
import 'package:evently/widges/default_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class EventDetailScreen extends StatelessWidget {
  static const String routeName = '/event_detail';

  final Event event;

  const EventDetailScreen({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateEventScreen(event: event),
                ),
              );
              Provider.of<EventProvider>(context, listen: false).getEvents();
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _showDeleteDialog(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/${event.category.imageName}.png',
                height: MediaQuery.sizeOf(context).height * 0.25,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 16),
            Text(
              event.title,
              style:
                  textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              event.description,
              style: textTheme.titleMedium,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/date.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(width: 16),
                Text(
                  'Event Date: ${DateFormat('dd/MM/yyyy').format(event.dateTime)}',
                  style: textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/Clock.svg',
                  height: 24,
                  width: 24,
                  fit: BoxFit.scaleDown,
                ),
                SizedBox(width: 16),
                Text(
                  'Event Time: ${TimeOfDay.fromDateTime(event.dateTime).format(context)}',
                  style: textTheme.titleSmall,
                ),
              ],
            ),
            SizedBox(height: 16),
            DefaultElevatedButton(
              lable: 'Join Event',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Confirm Deletion"),
        content: Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseService.deleteEvent(event.id);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Fluttertoast.showToast(
                msg: "Event deleted successfully",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
              Provider.of<EventProvider>(context, listen: false).getEvents();
            },
            child: Text("Delete"),
          ),
        ],
      ),
    );
  }
}
