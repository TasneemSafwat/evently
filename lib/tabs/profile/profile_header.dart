import 'package:evently/app_theme.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(64),
        ),
      ),
      child: SafeArea(
        child: Row(
          children: [
            Image.asset(
              'assets/images/route.png',
              height: MediaQuery.sizeOf(context).height * 0.12,
            ),
            SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  Provider.of<UserProvider>(context, listen: false)
                      .currentUser!
                      .name,
                  style: textTheme.displayMedium,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  Provider.of<UserProvider>(context, listen: false)
                      .currentUser!
                      .email,
                  style: textTheme.bodyLarge?.copyWith(color: AppTheme.white),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
