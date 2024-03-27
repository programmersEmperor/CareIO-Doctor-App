import 'package:get/get.dart';

class DayTimeSlot {
  final String _day;
  late final RxBool _isSelected;

  DayTimeSlot(
    this._day,
    this._isSelected,
  );

  get isSelected => _isSelected.value;
  get day => _day;

  set setIsSelected(bool value) => _isSelected.value = value;
}
