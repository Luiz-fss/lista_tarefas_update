import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-model.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit.dart';
import 'package:lista_tarefas_atualizado/utils/dialog-cadastro-nova-tarefa.dart';
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
    return BlocBuilder<ListaTarefaCubit,ListaTarefaCubitModel>(
      builder: (context,state){

        if(!_bloc.verificarSeTemItemSalvo){
          _bloc.lerInformacoesDaLista().then((value) =>
          _bloc.carregarListaSalva(value));
        }
        return _retornarListagemDeTarefas(state);
      },
    );
  }

  Widget _botaoAdicionar () {
    return FloatingActionButton(
      onPressed: ()async{
        await showDialog(context: context, builder: (context){
          return  DialogCadastroNovaTarefa(_bloc);
        });
      },
      child: const Icon(Icons.add,),
    );
  }

  Widget _retornarListagemDeTarefas(ListaTarefaCubitModel state){
    if(state.listaDeTarefas.isEmpty){
      return Container();
    }else{
      return Container(
        margin: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: state.listaDeTarefas.length,
          itemBuilder: (context, index){
            return CheckboxListTile(
              title: Text(state.listaDeTarefas[index]["title"]),
              value: state.listaDeTarefas[index]["ok"],
              secondary: _retornarIconeDeStatusDaLista(state.listaDeTarefas[index]["ok"],
              ),
              onChanged: (valorAlterado){},
            );
          },
        ),
      );
    }
  }

   Widget _retornarIconeDeStatusDaLista(bool check){
     if(check){
       return const CircleAvatar(child: Icon(Icons.check, color: Colors.green,));
     }else{
       return const CircleAvatar(child: Icon(Icons.warning, color: Colors.amberAccent,));
     }
   }
}
