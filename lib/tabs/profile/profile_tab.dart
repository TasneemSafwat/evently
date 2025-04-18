import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/providers/setting_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/profile/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);

    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        ProfileHeader(),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Theme',
                      style: textTheme.titleLarge?.copyWith(
                          color: settingProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black),
                    ),
                    Switch(
                        value: settingProvider.isDark,
                        onChanged: (isdark) {
                          settingProvider.changeTheme(
                              isdark ? ThemeMode.dark : ThemeMode.light);
                        }),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    FirebaseService.logout();
                    Navigator.of(context)
                        .pushReplacementNamed(LoginScreen.routename);
                    Provider.of<UserProvider>(context, listen: false)
                        .updateCurrentUser(null);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 24),
                    height: 56,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppTheme.red,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout_outlined,
                          color: AppTheme.white,
                        ),
                        Text(
                          'Logout',
                          style: textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
