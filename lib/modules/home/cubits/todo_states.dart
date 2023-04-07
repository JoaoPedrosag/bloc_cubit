abstract class TodoState {}

class InitialTodoState extends TodoState {}

class LoadingTodoState extends TodoState {}

class LoadedTodoState extends TodoState {
  final List<String> todos;

  LoadedTodoState({required this.todos});
}

class ErrorTodoState extends TodoState {
  final String message;

  ErrorTodoState({required this.message});
}
