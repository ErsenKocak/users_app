part of 'user_list_cubit.dart';

@immutable
abstract class UserListState {}

class UserListInitialState extends UserListState {}

class UserListLoadingState extends UserListState {}

class UserListLoadedState extends UserListState {
  final List<User> userList;

  UserListLoadedState(this.userList);
}

class UserListErrorState extends UserListState {
  final String errorMessage;

  UserListErrorState(this.errorMessage);
}
