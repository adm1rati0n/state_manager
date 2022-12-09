part of 'click_cubit.dart';

@immutable
abstract class ClickState {}

class ClickInitial extends ClickState {}

class ClickPicture extends ClickState {
  ClickPicture();
}

class Click extends ClickState {
  final int count;

  Click(this.count);
}
