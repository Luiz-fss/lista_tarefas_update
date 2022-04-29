import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-model.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/components/alterar-cores-do-sistema.dart';
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

   Function _escolhaItemMenu(String escolha){}

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context){
        return _bloc;
      },
      child: BlocBuilder<ListaTarefaCubit,ListaTarefaCubitModel>(
        builder: (context,state){
          return Scaffold(
            appBar:  AppBar(
              title: const Text(
                "Lista de Tarefas",
              ),
              centerTitle: true,
              actions: [
                PopupMenuButton<String>(
                  onSelected: (itemSelecionado){
                    if(itemSelecionado.contains("Alterar")){
                      Navigator.pushNamed(context, AlterarCoresDoSistema.ROUTE,arguments: _bloc);
                    }
                  },
                  itemBuilder: (context){
                    return [
                      PopupMenuItem(
                        value: "Remover",
                        onTap: _removerTodasTarefas(state),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: const Icon(Icons.delete,color: Colors.red,),
                            ),
                            Container(
                              child: const Text(
                                "Remover todos itens",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 14
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: "Alterar",
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(right: 8),
                              child: const Icon(Icons.color_lens_outlined, color: Colors.green,),
                            ),
                            const Text(
                              "Alterar Cores do App",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black
                              ),
                            )
                          ],
                        ),
                      )
                    ];
                  },
                ),
              ],
            ),
            body: _buildBody(),
            floatingActionButton: _botaoAdicionar(),
          );
        },
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
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white),
        margin: const EdgeInsets.all(8),
        child: const Center(
          child: Text(
            "Você ainda não cadastrou nenhuma tarefa !!",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          ),
        ),
      );
    }else{
      return Container(
        margin: const EdgeInsets.all(16),
        child: RefreshIndicator(
          onRefresh: _bloc.refresh,
          child: ListView.builder(
            itemCount: state.listaDeTarefas.length,
            itemBuilder: itensDaLista,
          ),
        ),
      );
    }
  }

  Widget itensDaLista(BuildContext context, int index){
    return  BlocBuilder<ListaTarefaCubit,ListaTarefaCubitModel>(
      builder: (context, state){
        return Dismissible(
          key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
          onDismissed: (direcao)async{
            _bloc.ultimaTarefaRemovida = Map.from(state.listaDeTarefas[index]);
            _bloc.indexUltimaTarefaRemovida = index;
            await _bloc.removerTarefaDaLista(state.listaDeTarefas,index);
            
            final snack = SnackBar(
              content: Text("Tarefa \"${_bloc.ultimaTarefaRemovida["title"]}\" removida"),
              action: SnackBarAction(
                label: "Desfazer",
                onPressed: ()async{
                  await _bloc.desfazerExclusao(
                      _bloc.ultimaTarefaRemovida, _bloc.indexUltimaTarefaRemovida,
                      state.listaDeTarefas);
                },
              ),
              duration: Duration(seconds: 3),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
          },
          background: Container(
            color: Colors.red,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                 Icon(Icons.delete,color: Colors.white,)
              ],
            ),
          ),
          direction: DismissDirection.startToEnd,
          child: CheckboxListTile(
            title: Text(state.listaDeTarefas[index]["title"]),
            value: state.listaDeTarefas[index]["ok"],
            secondary: _retornarIconeDeStatusDaLista(state.listaDeTarefas[index]["ok"],
            ),
            onChanged: (valorAlterado){
              _bloc.atualizarStatusTarefaCompleta(valorAlterado, index);
            },
          ),
        );
      },
    );
  }

   Widget _retornarIconeDeStatusDaLista(bool check){
     if(check){
       return const CircleAvatar(child: Icon(Icons.check, color: Colors.green,),backgroundColor: Colors.black,);
     }else{
       return const CircleAvatar(child: Icon(Icons.warning, color: Colors.amberAccent,));
     }
   }

   Function _removerTodasTarefas(ListaTarefaCubitModel state){
      if(_bloc.state.listaDeTarefas.isNotEmpty){
        return (){
          _bloc.removerTodasTarefas();
        };
      }else{
        return (){};
      }
   }
}
