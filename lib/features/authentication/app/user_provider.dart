import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_app/core/helper/db_helper.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User {
  @override
  Future<bool> build() async => DBHelper.userExists();
}
