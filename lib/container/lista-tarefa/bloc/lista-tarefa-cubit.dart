import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-actions.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-model.dart';
import 'package:lista_tarefas_atualizado/utils/tipo-edicao-cor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListaTarefaCubit extends Cubit<ListaTarefaCubitModel> implements ListaTarefaCubitActions{
  ListaTarefaCubit() : super(ListaTarefaCubitModel(
    listaDeTarefas: [],
    corAppBar: Colors.red,
    corTituloAppBar: Colors.white,
    corBotaoAdicionarTarefa: Colors.blue,
    corIconeBotaoAdicionarTarefa: Colors.white,
    corIconeTarefaNaoConcluida: Colors.yellow,
    corDoFundoTarefaNaoConcluida: Colors.blueAccent,
    corIconeTarefaConcluida: Colors.green,
    corDoFundoTarefaConcluida: Colors.black,
    buscouCoresDoSistema: false
  ));

  bool verificarSeTemItemSalvo = false;

  Map<String,dynamic> ultimaTarefaRemovida;
  int indexUltimaTarefaRemovida;

  Future<File> buscarAquivo() async{
    final diretorioDoAplicativo = await getApplicationDocumentsDirectory();

    return  File("${diretorioDoAplicativo.path}/tarefa.json");
  }

  Future<File> salvarDadosPermanentemente () async{
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
    salvarDadosPermanentemente();
  }

  @override
  void atualizarStatusTarefaCompleta(bool check, int index) {
    List listaTarefaAtualizada = state.listaDeTarefas;
    listaTarefaAtualizada[index]["ok"] = check;

    emit(state.patchState(listaDeTarefas: listaTarefaAtualizada));
    salvarDadosPermanentemente();
  }

  Future<void> carregarListaSalva(String data){
    List lista;
    lista = json.decode(data);
    emit(state.patchState(listaDeTarefas: lista));
  }

  @override
  Future<void> removerTarefaDaLista(List tarefas, int index) {
   tarefas.removeAt(index);
   emit(state.patchState(listaDeTarefas: tarefas));
   salvarDadosPermanentemente();
  }

  @override
  Future<void> desfazerExclusao(
      Map<String, dynamic> ultimaTarefaRemovida, int indexUltimaTarefaRemovida,
      List<dynamic> tarefas) {
    tarefas.insert(indexUltimaTarefaRemovida, ultimaTarefaRemovida);
    emit(state.patchState(listaDeTarefas: tarefas));
    salvarDadosPermanentemente();
  }

  Future<void> refresh()async{
    await Future.delayed(Duration(seconds: 1));
    state.listaDeTarefas.sort((a,b){
      if(a["ok"] && !b["ok"]){
        return 1;
      }else if(!a["ok"] && b["ok"]){
        return -1;
      }else{
        return 0;
      }
    });
    emit(state.patchState(listaDeTarefas:state.listaDeTarefas));
    salvarDadosPermanentemente();
  }

  Future<void> removerTodasTarefas()async{
    List<dynamic> lista = state.listaDeTarefas;
    for(int i =0; i < state.listaDeTarefas.length;i++){
      lista.removeAt(i);
    }
    emit(state.patchState(listaDeTarefas: lista));
    salvarDadosPermanentemente();
  }

  @override
  void mudarCorAppBar(Color corNova) {
    emit(state.patchState(corAppBar: corNova));
  }

  @override
  void mudarTituloCorAppBar(Color corNova) {
    emit(state.patchState(corTituloAppBar: corNova));
  }

  @override
  void mudarCorBotaoAdicionarTarefa(Color corNova) {
    emit(state.patchState(corBotaoAdicionarTarefa: corNova));
  }

  @override
  void mudarCorIconeBotaoAdicionarTarefa(Color corNova) {
    emit(state.patchState(corIconeBotaoAdicionarTarefa: corNova));
  }

  @override
  void mudarCorIconeTarefaNaoConcluida(Color corNova) {
    emit(state.patchState(corIconeTarefaNaoConcluida: corNova));
  }

  @override
  void mudarCorFundoTarefaNaoConcluida(Color corNova) {
    emit(state.patchState(corDoFundoTarefaNaoConcluida: corNova));
  }

  @override
  void mudarCorTarefaConcluida(Color corNova) {
    emit(state.patchState(corIconeTarefaConcluida: corNova));
  }

  @override
  void mudarCorFundoTarefaConcluida(Color corNova) {
    emit(state.patchState(corDoFundoTarefaConcluida: corNova));
  }

  Future<void> verificarCoresSalvas()async{
    SharedPreferences _sharedPreferences;
    _sharedPreferences = await SharedPreferences.getInstance();
    int valorAppBar = _sharedPreferences.getInt(TipoEdicaoCorSelecao[TipoEdicaoCor.COR_APP_BAR]);
    int valorTituloAppBar = _sharedPreferences.getInt(TipoEdicaoCorSelecao[TipoEdicaoCor.COR_TITULO_APP_BAR]);
    int valorFundoTarefaConcluida = _sharedPreferences.getInt(TipoEdicaoCorSelecao[TipoEdicaoCor.COR_FUNDO_TAREFA_CONCLUIDA]);
    int valorIconeTarefaConcluida = _sharedPreferences.getInt(TipoEdicaoCorSelecao[TipoEdicaoCor.COR_ICONE_TAREFA_CONCLUIDA]);
    int valorFundoTarefaNaoConcluida = _sharedPreferences.getInt(TipoEdicaoCorSelecao[TipoEdicaoCor.COR_FUNDO_TAREFA_NAO_CONCLUIDA]);
    int valorIconeTarefaNaoConcluida = _sharedPreferences.getInt(TipoEdicaoCorSelecao[TipoEdicaoCor.COR_ICONE_TAREFA_NAO_CONCLUIDA]);
    int valorIconeAdicionarTarefa = _sharedPreferences.getInt(TipoEdicaoCorSelecao[TipoEdicaoCor.COR_ICONE_ADICIONAR_TAREFA]);
    int valorBotaoAdicionarTarefa = _sharedPreferences.getInt(TipoEdicaoCorSelecao[TipoEdicaoCor.COR_BOTAO_ADICIONAR_TAREFA]);

    Color corAppBar;
    Color corTituloAppBar;
    Color corFundoTarefaConcluida;
    Color corIconeTarefaConcluida;
    Color corFundoTarefaNaoConcluida;
    Color corIconeTarefaNaoConcluida;
    Color corIconeAdicionarTarefa;
    Color corBotaoAdicionarTarefa;

    if(valorAppBar == null){
      corAppBar = state.corAppBar;
    }else{
      corAppBar = Color(valorAppBar);
    }

    if(valorTituloAppBar == null){
      corTituloAppBar = state.corTituloAppBar;
    }else{
      corTituloAppBar = Color(valorTituloAppBar);
    }

    if(valorFundoTarefaConcluida == null){
      corFundoTarefaConcluida = state.corDoFundoTarefaConcluida;
    }else{
      corFundoTarefaConcluida = Color(valorFundoTarefaConcluida);
    }

    if(valorIconeTarefaConcluida == null){
      corIconeTarefaConcluida = state.corIconeTarefaConcluida;
    }else{
      corIconeTarefaConcluida = Color(valorIconeTarefaConcluida);
    }

    if(valorFundoTarefaNaoConcluida == null){
      corFundoTarefaNaoConcluida = state.corDoFundoTarefaNaoConcluida;
    }else{
      corFundoTarefaNaoConcluida = Color(valorFundoTarefaNaoConcluida);
    }

    if(valorIconeTarefaNaoConcluida == null){
      corIconeTarefaNaoConcluida = state.corIconeTarefaNaoConcluida;
    }else{
      corIconeTarefaNaoConcluida = Color(valorIconeTarefaNaoConcluida);
    }
    if(valorIconeAdicionarTarefa == null){
      corIconeAdicionarTarefa = state.corIconeBotaoAdicionarTarefa;
    }else{
      corIconeAdicionarTarefa = Color(valorIconeAdicionarTarefa);
    }
    if(valorBotaoAdicionarTarefa == null){
      corBotaoAdicionarTarefa = state.corBotaoAdicionarTarefa;
    }else{
      corBotaoAdicionarTarefa = Color(valorBotaoAdicionarTarefa);
    }

    emit(state.patchState(
      corAppBar: corAppBar,
      corDoFundoTarefaConcluida: corFundoTarefaConcluida,
      corIconeTarefaConcluida: corIconeTarefaConcluida,
      corDoFundoTarefaNaoConcluida: corFundoTarefaNaoConcluida,
      corIconeTarefaNaoConcluida: corIconeTarefaNaoConcluida,
      corIconeBotaoAdicionarTarefa: corIconeAdicionarTarefa,
      corBotaoAdicionarTarefa: corBotaoAdicionarTarefa,
      corTituloAppBar: corTituloAppBar,
      buscouCoresDoSistema: true
    ));
  }
}