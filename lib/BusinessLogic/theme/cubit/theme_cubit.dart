import 'package:bloc/bloc.dart';
import 'package:demoecommerce/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeLoading()) {
    try {
      StorageThemeCheck();
    } catch (exception) {
      print(exception);
      var brightness = SchedulerBinding.instance!.window.platformBrightness;
      bool isbright = brightness == Brightness.dark;
      if (isbright) {
        emit(ThemeLoaded(darkTheme));
      } else {
        emit(ThemeLoaded(lightTheme));
      }
    }
  }

  Future<void> SetTheme(int themeindex) async {
    var status = await Permission.storage.status;
    if (status == PermissionStatus.denied) {
      if (await Permission.storage.request().isGranted) {
        var appdir = await getApplicationDocumentsDirectory();
        Hive..init(appdir.path);
        await Hive.openBox('settings');
      }
    } else if (status == PermissionStatus.granted) {
      var appdir = await getApplicationDocumentsDirectory();
      Hive..init(appdir.path);
      await Hive.openBox('settings');
    }

    var box = Hive.box('settings');
    box.delete('theme');
    box.put('theme', themeindex);
    StorageThemeCheck();
  }

  void StorageThemeCheck() {
    var box = Hive.box('settings');
    var theme = box.get('theme');
    if (theme == 1) {
      emit(ThemeLoaded(darkTheme));
    } else if (theme == 2) {
      emit(ThemeLoaded(lightTheme));
    }
  }
}
