import 'package:bloc_cubit/modules/home/cubits/todo_cubit.dart';
import 'package:bloc_cubit/modules/home/cubits/todo_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TodoCubit cubit;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<TodoCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
        ),
        body: Stack(
          children: [
            BlocBuilder(
              bloc: cubit,
              builder: (context, state) {
                if (state is InitialTodoState) {
                  return const Center(
                    child: Text('Nenhuma tarefa foi adicionada'),
                  );
                } else if (state is LoadingTodoState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is LoadedTodoState) {
                  return _buildTodoList(state.todos);
                } else {
                  return _buildTodoList(cubit.todos);
                }
              },
            ),
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.03),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Digite um nome',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (nameController.text.isEmpty) return;
                          cubit.addTodo(todo: nameController.text);
                          nameController.clear();
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Center(
                            child: Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget _buildTodoList(List<String> todos) {
    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.blue,
            child: Center(child: Text(todos[index][0])),
          ),
          title: Text(todos[index]),
          trailing: GestureDetector(
            onTap: () {
              cubit.removeTodo(index: index);
            },
            child: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }
}
