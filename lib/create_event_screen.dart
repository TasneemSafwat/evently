import 'package:evently/app_theme.dart';
import 'package:evently/models/category.dart';
import 'package:evently/tabs/home/tabs_item.dart';
import 'package:evently/widges/default_elevated_button.dart';
import 'package:evently/widges/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = '/create_event';

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int currentIndex = 0;
  Category selectedCateogry = Category.categories.first;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
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
                        category: category,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title',
                      style: textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 8,
                    ),
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
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Description',
                      style: textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    DefaultTextFormField(
                      hintText: 'Event Description,',
                      controller: descriptionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Title can not be empty';
                        }
                        return null;
                      },
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/date.svg',
                          height: 24,
                          width: 24,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Event Date',
                          style: textTheme.bodyLarge,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            DateTime? date = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(Duration(days: 365)),
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
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Clock.svg',
                          height: 24,
                          width: 24,
                          fit: BoxFit.scaleDown,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Event Time',
                          style: textTheme.bodyLarge,
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            TimeOfDay? time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
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
                    SizedBox(
                      height: 16,
                    ),
                    DefaultElevatedButton(
                        lable: 'Add Event', onPressed: createEvent)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void createEvent() {
    if (formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {}
  }
}
