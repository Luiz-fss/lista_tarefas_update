import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-model.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit.dart';
import 'package:lista_tarefas_atualizado/utils/card-alteracao-cores.dart';

class AlterarCoresDoSistema extends StatefulWidget {
  const AlterarCoresDoSistema({Key key}) : super(key: key);
  static String ROUTE = "/alterar-cores-sistema";

  @override
  _AlterarCoresDoSistemaState createState() => _AlterarCoresDoSistemaState();
}

class _AlterarCoresDoSistemaState extends State<AlterarCoresDoSistema> {
  ListaTarefaCubit _bloc;
  @override
  Widget build(BuildContext context) {
    _bloc = ModalRoute.of(context).settings.arguments;
    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<ListaTarefaCubit,ListaTarefaCubitModel>(
        builder: (context,state){
          return _contruirAppBar();
        },
      ),
    );
  }

  Widget _contruirAppBar(){
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EDITAR CORES DO SISTEMA"
        ),
        centerTitle: true,
      ),
      body: _montarCamposDeEdicaoDasCores(),
    );
  }

  Widget _montarCamposDeEdicaoDasCores(){
    return Container(

      child: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor da App Bar",
              funcaoDoCard: (){},
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do título da App Bar",
              funcaoDoCard: (){},
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do Botão de Adiconar Tarefa",
              funcaoDoCard: (){},
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do Ícone doBotão de Adiconar Tarefa",
              funcaoDoCard: (){},
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do ícone de tarefa não concluida",
              funcaoDoCard: (){},
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do fundo de tarefa não concluida",
              funcaoDoCard: (){},
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do ícone de tarefa concluida",
              funcaoDoCard: (){},
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do fundo de tarefa concluida",
              funcaoDoCard: (){},
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
        ],
      ),
    );
  }
}
