import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'click_state.dart';

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());

  int count = 0;
  List<String> widgetList = <String>[];

  void onClickInc(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      count++;
      widgetList.add('${count.toString()} Светлая тема');
    } else {
      count += 2;
      widgetList.add('${count.toString()} Темная тема');
    }
    if (count == -53){
      emit(ClickPicture());
      widgetList.add("Вывод приколюхи");
      return;
    }
    emit(Click(count));
  }

  void onClickDec(ThemeMode themeMode) {
    if (themeMode == ThemeMode.light) {
      count--;
      widgetList.add('${count.toString()} Светлая тема');
    } else {
      count -= 2;
      widgetList.add('${count.toString()} Темная тема');
    }
    if (count == -53){
      emit(ClickPicture());
      widgetList.add("Вывод приколюхи");
      return;
    }
    emit(Click(count));
  }

  void onThemeChanged(BuildContext buildContext) {
    widgetList.add("Смена темы");
  }
}
