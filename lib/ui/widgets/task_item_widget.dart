
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/utils/data_formatter.dart';
import 'package:todo/core/utils/dialog_utils.dart';
import 'package:todo/database_manager/model/task.dart';
import 'package:todo/database_manager/tasks_dao.dart';
import 'package:todo/providers/app_auth_provider.dart';

class TaskItemWidget extends StatefulWidget {
  Task task;

  TaskItemWidget({required this.task});

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(
        // A motion is a widget used to control how the pane animates.
        motion: const ScrollMotion(),

        // A pane can dismiss the Slidable.

        // All actions are defined in the children parameter.
        children: [
          // A SlidableAction can have an icon and/or a label.
          SlidableAction(
            onPressed: (context) {
              DialogUtils.showMessageDialog(
                context,
                message: 'Are u sure u want to delete it',
                posActionTitle: 'Ok',
                posAction: () {
                  deleteTask();
                },
                negActionTitle: 'Cancel',
              );
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 3,
                height: 65,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.task.title ?? '',
                      style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w400),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      widget.task.description ?? '',
                      style: TextStyle(fontSize: 12, color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      formatDate(widget.task.taskDate!.toDate()) ?? '',
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 9, color: Colors.black),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Icon(
                    Icons.check,
                    size: 30,
                    color: Colors.white,
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void deleteTask() async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    print(widget.task.id);
//    DialogUtils.showLoadingDialog(context, message: 'Deleting Task...');
    try {
      await TasksDao.deleteTask(
          authProvider.databaseUser!.id!, widget.task.id!);
    } catch (e) {
      DialogUtils.hideDialog(context);

      DialogUtils.showMessageDialog(context, message: e.toString());
    }
  }
}