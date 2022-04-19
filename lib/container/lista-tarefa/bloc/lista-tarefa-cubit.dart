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

  bool verificarSeTemItemSalvo = false;

  Future<File> buscarAquivo() async{
    final diretorioDoAplicativo = await getApplicationDocumentsDirectory();

    return  File("${diretorioDoAplicativo.path}/tarefa.json");
  }

  Future<File> salvarNovaTarefa () async{
    String dados = json.encode(state.listaDeTarefas);
    final arquivo = await buscarAquivo();
    return arquivo.writeAsString(dados);
  }

  Future<String> lerInformacoesDaLista () async {
   try{
     final arquivo = await buscarAquivo();
     verificarSeTemItemSalvo = true;
     return arquivo.readAsString();
   }catch(e){
     verificarSeTemItemSalvo = false;
     return "";
   }
  }

  @override
  void adicionarNovaTarefa(String textoDaTarefa){
    Map<String,dynamic> novaTarefa = Map();
    List tarefaAdicionada = state.listaDeTarefas;
    novaTarefa["title"] = textoDaTarefa;
    novaTarefa["ok"] = false;

    tarefaAdicionada.add(novaTarefa);
    emit(state.patchState(listaDeTarefas: tarefaAdicionada));
    salvarNovaTarefa();
  }

  @override
  void atualizarStatusTarefaCompleta(bool check, int index) {
    List listaTarefaAtualizada = state.listaDeTarefas;
    listaTarefaAtualizada[index]["ok"] = check;

    emit(state.patchState(listaDeTarefas: listaTarefaAtualizada));
    salvarNovaTarefa();
  }

  Future<void> carregarListaSalva(String data){
    List lista;
    lista = json.decode(data);
    emit(state.patchState(listaDeTarefas: lista));
  }
}