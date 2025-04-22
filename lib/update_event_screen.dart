import 'package:evently/app_theme.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/models/category.dart';
import 'package:evently/models/event.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/setting_provider.dart';
import 'package:evently/tabs/home/tabs_item.dart';
import 'package:evently/widges/default_elevated_button.dart';
import 'package:evently/widges/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UpdateEventScreen extends StatefulWidget {
  static const String routeName = '/update_event';

  final Event event;

  const UpdateEventScreen({Key? key, required this.event}) : super(key: key);

  @override
  State<UpdateEventScreen> createState() => _UpdateEventScreenState();
}

class _UpdateEventScreenState extends State<UpdateEventScreen> {
  int currentIndex = 0;
  late Category selectedCateogry;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.event.title;
    descriptionController.text = widget.event.description;
    selectedDate = widget.event.dateTime;
    selectedTime = TimeOfDay.fromDateTime(widget.event.dateTime);
    selectedCateogry = widget.event.category;
    currentIndex = Category.categories.indexOf(selectedCateogry);
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Update Event'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/${selectedCateogry.imageName}.png',
                height: MediaQuery.sizeOf(context).height * 0.22,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
          ),
          DefaultTabController(
            length: Category.categories.length,
            child: TabBar(
              padding: EdgeInsets.only(left: 6),
              indicatorColor: Colors.transparent,
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.start,
              labelPadding: EdgeInsets.symmetric(horizontal: 10),
              isScrollable: true,
              onTap: (index) {
                currentIndex = index;
                selectedCateogry = Category.categories[currentIndex];
                setState(() {});
              },
              tabs: Category.categories
                  .map<Widget>((category) => TabsItem(
                        lable: category.name,
                        icon: category.icon,
                        isSelected: currentIndex ==
                            Category.categories.indexOf(category),
                        selectedBackgroundColor: AppTheme.primary,
                        selectedForeBackgroundColor: AppTheme.white,
                        unselectedForeBackgroundcorlor: AppTheme.primary,
                      ))
                  .toList(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Title', style: textTheme.bodyLarge),
                      SizedBox(height: 8),
                      DefaultTextFormField(
                        hintText: 'Event Title,',
                        controller: titleController,
                        prefixIconImageName: 'Vector',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Title can not be empty';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      Text('Description', style: textTheme.bodyLarge),
                      SizedBox(height: 8),
                      DefaultTextFormField(
                        hintText: 'Event Description,',
                        controller: descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Description can not be empty';
                          }
                          return null;
                        },
                        maxLines: 5,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/date.svg',
                            height: 24,
                            width: 24,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                              settingProvider.isDark
                                  ? AppTheme.white
                                  : AppTheme.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text('Event Date', style: textTheme.bodyLarge),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              DateTime? date = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate:
                                    DateTime.now().add(Duration(days: 365)),
                                initialDate: selectedDate,
                              );
                              if (date != null) {
                                selectedDate = date;
                                setState(() {});
                              }
                            },
                            child: Text(
                              selectedDate == null
                                  ? 'Choose Date'
                                  : dateFormat.format(selectedDate!),
                              style: textTheme.bodyLarge?.copyWith(
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/icons/Clock.svg',
                            height: 24,
                            width: 24,
                            fit: BoxFit.scaleDown,
                            colorFilter: ColorFilter.mode(
                              settingProvider.isDark
                                  ? AppTheme.white
                                  : AppTheme.black,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 16),
                          Text('Event Time', style: textTheme.bodyLarge),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              TimeOfDay? time = await showTimePicker(
                                context: context,
                                initialTime: selectedTime ?? TimeOfDay.now(),
                              );
                              if (time != null) {
                                selectedTime = time;
                                setState(() {});
                              }
                            },
                            child: Text(
                              selectedTime == null
                                  ? 'Choose Time'
                                  : selectedTime!.format(context),
                              style: textTheme.bodyLarge?.copyWith(
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      DefaultElevatedButton(
                        lable: 'Update Event',
                        onPressed: updateEvent,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void updateEvent() {
    if (formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      DateTime dateTime = DateTime(
        selectedDate!.year,
        selectedDate!.month,
        selectedDate!.day,
        selectedTime!.hour,
        selectedTime!.minute,
      );

      Event updatedEvent = Event(
        id: widget.event.id,
        userId: widget.event.userId,
        title: titleController.text,
        description: descriptionController.text,
        dateTime: dateTime,
        category: selectedCateogry,
      );

      FirebaseService.updateEvent(updatedEvent).then((_) {
        Provider.of<EventProvider>(context, listen: false).getEvents();
        Navigator.of(context).pop();
        Fluttertoast.showToast(
          msg: "Event updated successfully",
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      }).catchError((error) {
        Fluttertoast.showToast(
          msg: "Failed to update event",
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      });
    }
  }
}
