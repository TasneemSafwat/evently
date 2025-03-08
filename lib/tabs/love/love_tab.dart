import 'package:evently/tabs/home/eventItem.dart';
import 'package:evently/widges/default_text_form_field.dart';
import 'package:flutter/material.dart';

class LoveTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                itemBuilder: (_, index) => Eventitem(),
                itemCount: 10,
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
