import 'package:bloc/bloc.dart';
import 'package:bloc_cubit/modules/home/cubits/todo_states.dart';

class TodoCubit extends Cubit<TodoState> {
  final List<String> _todos = [];

  List<String> get todos => _todos;
  TodoCubit() : super(InitialTodoState());

  Future<void> addTodo({required String todo}) async {
    emit(LoadingTodoState());
    await Future.delayed(const Duration(milliseconds: 100));

    if (_todos.contains(todo)) {
      emit(ErrorTodoState(message: 'Todo já existe'));
    } else {
      _todos.add(todo);
      emit(LoadedTodoState(todos: _todos));
    }
  }

  Future removeTodo({required int index}) async {
    emit(LoadingTodoState());
    await Future.delayed(const Duration(milliseconds: 100));
    _todos.removeAt(index);
    emit(LoadedTodoState(todos: _todos));
  }
}
