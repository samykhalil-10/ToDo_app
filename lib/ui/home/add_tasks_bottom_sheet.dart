import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/utils/data_formatter.dart';
import 'package:todo/core/utils/dialog_utils.dart';
import 'package:todo/database_manager/model/task.dart';
import 'package:todo/database_manager/tasks_dao.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/ui/widgets/custom_text_form_field.dart';

class AddTaskBottomSheet extends StatefulWidget {
  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final taskTitleController = TextEditingController();
  final taskDescController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  DateTime? finalSelectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add Task',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            CustomTextFormField(
              hint: 'Task Title',
              keyboardType: TextInputType.text,
              controller: taskTitleController,
              validator: (input) => input == null || input.trim().isEmpty
                  ? 'Please enter a task title'
                  : null,
            ),
            CustomTextFormField(
              hint: 'Task Description',
              keyboardType: TextInputType.text,
              controller: taskDescController,
              validator: (input) => input == null || input.trim().isEmpty
                  ? 'Please enter a task description'
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
              child: Text(
                'Select Date',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            InkWell(
              onTap: () => chooseTaskDate(context),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(
                  formatDate(finalSelectedDate!),
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              onPressed: createTask,
              child: Text(
                'Create Task',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void createTask() async {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);

    // Ensure all fields are valid
    if (formKey.currentState?.validate() != true) return;

    // Ensure a date is selected
    if (finalSelectedDate == null) {
      DialogUtils.showMessageDialog(
        context,
        message: 'Please select a date for the task.',
        posActionTitle: 'OK',
      );
      return;
    }

    if (authProvider.databaseUser == null) {
      DialogUtils.showMessageDialog(
        context,
        message: 'User not authenticated. Please log in again.',
        posActionTitle: 'OK',
      );
      return;
    }

    // Create and save task
    Task task = Task(
      id: authProvider.databaseUser!.id!,
      title: taskTitleController.text,
      description: taskDescController.text,
      taskDate: Timestamp.fromMillisecondsSinceEpoch(
        finalSelectedDate!.millisecondsSinceEpoch,
      ),
    );

    DialogUtils.showLoadingDialog(context, message: 'Creating Task...');
    await TasksDao.addTask(task, authProvider.databaseUser!.id!);
    DialogUtils.hideDialog(context);
    DialogUtils.showMessageDialog(
      context,
      message: 'Task Created Successfully',
      posActionTitle: 'OK',
      posAction: () {
        Navigator.pop(context);
      },
    );
  }

  void chooseTaskDate(BuildContext context) async {
    DateTime? userSelectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (userSelectedDate != null) {
      setState(() {
        finalSelectedDate = userSelectedDate;
      });
    }
  }
}
