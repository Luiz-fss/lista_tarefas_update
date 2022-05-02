import 'package:flutter/material.dart';

abstract class ListaTarefaCubitActions {
  void adicionarNovaTarefa(String textoDaTarefa);
  void atualizarStatusTarefaCompleta(bool check, int index);
  void removerTarefaDaLista(List<dynamic> tarefas, int index);
  void desfazerExclusao(Map<String,dynamic> ultimaTarefaRemovida, int indexUltimaTarefaRemovida, List<dynamic> tarefas);
  void mudarCorAppBar(Color corNova);
  void mudarTituloCorAppBar(Color corNova);
  void mudarCorBotaoAdicionarTarefa(Color corNova);
  void mudarCorIconeBotaoAdicionarTarefa(Color corNova);
  void mudarCorIconeTarefaNaoConcluida(Color corNova);
  void mudarCorFundoTarefaNaoConcluida(Color corNova);
  void mudarCorTarefaConcluida(Color corNova);
  void mudarCorFundoTarefaConcluida(Color corNova);
}