import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-model.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit.dart';

class DialogCadastroNovaTarefa extends StatefulWidget {
  const DialogCadastroNovaTarefa({Key key}) : super(key: key);

  @override
  _DialogCadastroNovaTarefaState createState() => _DialogCadastroNovaTarefaState();
}

class _DialogCadastroNovaTarefaState extends State<DialogCadastroNovaTarefa> {

  ListaTarefaCubit _bloc = new ListaTarefaCubit();

  @override
  Widget build(BuildContext context) {
   _bloc = ModalRoute.of(context)?.settings.arguments as ListaTarefaCubit;
    return BlocProvider.value(
        value: _bloc,
      child: BlocBuilder<ListaTarefaCubit,ListaTarefaCubitModel>(
        builder: (context,state){
          return Container();
        },
      ),
    );
  }
}
