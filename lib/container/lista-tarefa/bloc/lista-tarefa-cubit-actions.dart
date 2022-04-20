abstract class ListaTarefaCubitActions {
  void adicionarNovaTarefa(String textoDaTarefa);
  void atualizarStatusTarefaCompleta(bool check, int index);
  void removerTarefaDaLista(List<dynamic> tarefas, int index);
  void desfazerExclusao(Map<String,dynamic> ultimaTarefaRemovida, int indexUltimaTarefaRemovida, List<dynamic> tarefas);
}