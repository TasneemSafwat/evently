import 'package:evently/app_theme.dart';
import 'package:evently/auth/login_screen.dart';
import 'package:evently/firebase_service.dart';
import 'package:evently/providers/setting_provider.dart';
import 'package:evently/providers/user_provider.dart';
import 'package:evently/tabs/profile/profile_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget {
  List<language> languages = [
    language(code: 'en', name: 'English'),
    language(code: 'ar', name: 'العربية'),
  ];
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
                      },
                      focusColor: AppTheme.primary,
                      activeColor: AppTheme.primary,
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Language',
                      style: textTheme.titleLarge?.copyWith(
                          color: settingProvider.isDark
                              ? AppTheme.white
                              : AppTheme.black),
                    ),
                    DropdownButton(
                      value: settingProvider.languageCode,
                      items: languages
                          .map(
                            (language) => DropdownMenuItem(
                              child: Text(
                                language.name,
                                style: textTheme.titleLarge
                                    ?.copyWith(color: AppTheme.primary),
                              ),
                              value: language.code,
                            ),
                          )
                          .toList(),
                      onChanged: (languageCode) {
                        if (languageCode != null) {
                          settingProvider.changeLanguage(languageCode);
                        }
                      },
                      underline: SizedBox(),
                      iconEnabledColor: AppTheme.primary,
                    ),
                  ],
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

class language {
  String code;
  String name;
  language({required this.code, required this.name});
}
