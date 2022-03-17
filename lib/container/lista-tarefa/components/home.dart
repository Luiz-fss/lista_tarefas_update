import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-model.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);
  static String ROUTE = "/home";

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


   ListaTarefaCubit _bloc =  ListaTarefaCubit();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return _bloc;
      },
      child: Scaffold(
        appBar:  AppBar(
          title: const Text(
            "Lista de Tarefas",
          ),
          centerTitle: true,
        ),
        body: _buildBody(),
        floatingActionButton: _botaoAdicionar(),
      ),
    );
  }

  Widget _buildBody (){
    return Container(
      margin: const EdgeInsets.all(16),
      child: ListView(
        children: [

        ],
      ),
    );
  }

  Widget _botaoAdicionar () {
    return FloatingActionButton(
      onPressed: (){},
      child: const Icon(Icons.add,),
    );
  }
}
