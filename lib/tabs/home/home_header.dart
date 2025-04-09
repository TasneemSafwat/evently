import 'package:evently/app_theme.dart';
import 'package:evently/models/category.dart';
import 'package:evently/providers/event_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/home/tabs_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeHeader extends StatefulWidget {
  @override
  State<HomeHeader> createState() => _HomeHeaderState();
}

class _HomeHeaderState extends State<HomeHeader> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    EventProvider eventProvider = Provider.of<EventProvider>(context);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(bottom: 16, left: 16),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Back ✨',
              style: textTheme.bodyMedium?.copyWith(color: AppTheme.white),
            ),
            Text(
              Provider.of<UserProvider>(context).currentUser!.name,
              style: textTheme.displayMedium,
            ),
            SizedBox(
              height: 16,
            ),
            DefaultTabController(
              length: Category.categories.length + 1,
              child: TabBar(
                  indicatorColor: Colors.transparent,
                  dividerColor: Colors.transparent,
                  tabAlignment: TabAlignment.start,
                  labelPadding: EdgeInsets.symmetric(horizontal: 10),
                  isScrollable: true,
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    eventProvider.changeSelectedCategory(
                        index == 0 ? null : Category.categories[index - 1]);
                  },
                  tabs: [
                    TabsItem(
                      lable: "all",
                      icon: Icons.my_location_outlined,
                      isSelected: currentIndex == 0,
                      selectedBackgroundColor: AppTheme.white,
                      selectedForeBackgroundColor: AppTheme.primary,
                      unselectedForeBackgroundcorlor: AppTheme.white,
                    ),
                    ...Category.categories.map<Widget>((category) => TabsItem(
                          lable: category.name,
                          icon: category.icon,
                          isSelected: currentIndex ==
                              Category.categories.indexOf(category) + 1,
                          selectedBackgroundColor: AppTheme.white,
                          selectedForeBackgroundColor: AppTheme.primary,
                          unselectedForeBackgroundcorlor: AppTheme.white,
                        ))
                  ]),
            )
          ],
        ),
      ),
    );
  }
}
