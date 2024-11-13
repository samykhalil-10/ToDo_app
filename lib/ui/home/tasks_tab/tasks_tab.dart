
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/flutter_timeline_calendar.dart';
import 'package:provider/provider.dart';
import 'package:todo/database_manager/tasks_dao.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/ui/widgets/task_item_widget.dart';

class TasksTab extends StatefulWidget {
  @override
  State<TasksTab> createState() => _TasksTabState();
}

class _TasksTabState extends State<TasksTab> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context);
    return Column(
      children: [
        TimelineCalendar(
          calendarType: CalendarType.GREGORIAN,
          calendarLanguage: "en",
          calendarOptions: CalendarOptions(
            viewType: ViewType.DAILY,
            toggleViewType: true,
            headerMonthElevation: 10,
            headerMonthShadowColor: Colors.transparent,
            headerMonthBackColor: Colors.transparent,
          ),
          dayOptions: DayOptions(
              selectedBackgroundColor: Theme.of(context).primaryColor,
              compactMode: true,
              weekDaySelectedColor: Theme.of(context).primaryColor,
              disableDaysBeforeNow: true),
          headerOptions: HeaderOptions(
              weekDayStringType: WeekDayStringTypes.SHORT,
              monthStringType: MonthStringTypes.SHORT,
              backgroundColor: Colors.transparent,
              navigationColor: Theme.of(context).primaryColor,
              calendarIconColor: Theme.of(context).primaryColor,
              headerTextColor: Theme.of(context).primaryColor),
          onChangeDateTime: (datetime) {
            selectedDate = datetime.toDateTime();
            setState(() {});
            print(datetime.getDate());
          },
        ),
        StreamBuilder(
          stream: TasksDao.getAllTasksRealTime(
              authProvider.databaseUser!.id!, selectedDate!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }

            var tasksList = snapshot.data?.docs
                .map(
                  (docSnapShot) => docSnapShot.data(),
            )
                .toList();
            return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      TaskItemWidget(task: tasksList![index]),
                  itemCount: tasksList?.length ?? 0,
                ));
          },
        )
      ],
    );
  }
}