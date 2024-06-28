import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'task_date_provider.g.dart';

@riverpod
class TaskDate extends _$TaskDate {
  @override
  DateTime? build() => null;

  void changeDate(DateTime date) {
    state = date;
  }

  String? date() {
    if (state == null) return null;
    return DateFormat("dd-MM-yyyy").format(state!);
  }

  void reset() => state = null;
}

@riverpod
class TaskStartTime extends _$TaskStartTime {
  @override
  DateTime? build() => null;

  void changeTime(DateTime date) {
    state = date;
  }

  String? time() {
    if (state == null) return null;
    return DateFormat("hh:mm").format(state!);
  }

  void reset() => state = null;
}

@riverpod
class TaskEndTime extends _$TaskEndTime {
  @override
  DateTime? build() => null;

  void changeTime(DateTime date) {
    state = date;
  }

  String? time() {
    if (state == null) return null;
    return DateFormat("hh:mm").format(state!);
  }

  void reset() => state = null;
}
