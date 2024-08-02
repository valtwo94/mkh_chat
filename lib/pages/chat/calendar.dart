import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../widgets/tiles/schedule.dart';

class ChatCalendarPage extends StatefulWidget {
  const ChatCalendarPage({super.key});

  @override
  State<ChatCalendarPage> createState() => _ChatCalendarPageState();
}

class _ChatCalendarPageState extends State<ChatCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "커플 캘린더",
          style: Theme.of(context).textTheme.labelLarge,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: TableCalendar(
                locale: AppLocalizations.of(context)!.localeName,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
            ),
          ),
          Container(
            color: Theme.of(context).primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    '일정',
                    style: Theme.of(context)
                        .textTheme
                        .labelMedium!
                        .copyWith(color: Colors.white),
                  ),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ))
              ],
            ),
          ),
          Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ScheduleTile(
                      onTap: (){},
                      deleteOnPressed: (context) {},
                      shareOnPressed: (context) {},
                      chatOnPressed: (context) {},
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      color: Colors.grey.withOpacity(0.2),
                      height: 1,
                    );
                  },
                  itemCount: 10))
        ],
      ),
    );
  }
}

