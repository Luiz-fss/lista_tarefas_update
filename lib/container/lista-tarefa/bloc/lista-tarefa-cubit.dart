import 'dart:convert';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-actions.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-model.dart';
import 'package:path_provider/path_provider.dart';

class ListaTarefaCubit extends Cubit<ListaTarefaCubitModel> implements ListaTarefaCubitActions{
  ListaTarefaCubit() : super(ListaTarefaCubitModel(
    listaDeTarefas: []
  ));


  Future<File> buscarAquivo() async{
    final diretorioDoAplicativo = await getApplicationDocumentsDirectory();

    return new File("${diretorioDoAplicativo.path}/tarefa.json");
  }

  Future<File> salvarNovaTarefa () async{
    String dados = json.encode(state.listaDeTarefas);
    final arquivo = await buscarAquivo();
    return arquivo.writeAsString(dados);
  }

  Future<String> lerInformacoesDaLista () async {
   try{
     final arquivo = await buscarAquivo();
     return arquivo.readAsString();
   }catch(e){
     return "";
   }
  }
}