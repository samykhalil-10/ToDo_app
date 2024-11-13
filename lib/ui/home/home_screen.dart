import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/core/app_routes.dart';
import 'package:todo/core/theme/app_theme.dart';
import 'package:todo/core/utils/dialog_utils.dart';
import 'package:todo/providers/app_auth_provider.dart';
import 'package:todo/providers/settings_provider.dart';
import 'package:todo/ui/home/add_tasks_bottom_sheet.dart';
import 'package:todo/ui/home/settings_tab/settings_tab.dart';
import 'package:todo/ui/home/tasks_tab/tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AppAuthProvider>(context);
    var settingsProvider = Provider.of<SettingsProvider>(context);
    var isDarkTheme = settingsProvider.currentTheme == ThemeMode.dark;

    print(authProvider.databaseUser?.id);
    print(authProvider.firebaseAuthUser?.uid);
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Text(authProvider.databaseUser!.userName!),
          actions: [
            IconButton(
                onPressed: () {
                  DialogUtils.showMessageDialog(context,
                      message: 'Are u sure u want to sign out',
                      posActionTitle: 'Confirm', posAction: () {
                    logOut();
                    Navigator.pushReplacementNamed(
                        context, AppRoutes.loginRoute);
                  }, negActionTitle: 'Cancel');
                },
                icon: Icon(Icons.logout)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: isDarkTheme ? AppTheme.scaffoldDarkBgColor : AppTheme.lightPrimaryColor,
          shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
          onPressed: () {
            showAddTaskBottomSheet();
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          shape: CircularNotchedRectangle(),
          child: BottomNavigationBar(
            backgroundColor: isDarkTheme ? AppTheme.darkTheme.colorScheme.onPrimary : AppTheme.lightTheme.colorScheme.onPrimary,
            currentIndex: selectedIndex,
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.list,
                  ),
                  label: 'Tasks'),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.settings,
                  ),
                  label: 'Settings'),
            ],
          ),
        ),
        body: tabs[selectedIndex]);
  }

  var tabs = [TasksTab(), SettingsTab()];

  void logOut() {
    var authProvider = Provider.of<AppAuthProvider>(context, listen: false);
    authProvider.signOut();
  }

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => AddTaskBottomSheet(),
    );
  }
}
