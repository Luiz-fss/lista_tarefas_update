

class ListaTarefaCubitModel {

  List listaDeTarefas;

  ListaTarefaCubitModel(
      {this.listaDeTarefas});

  ListaTarefaCubitModel patchState(
      {List listaDeTarefas

      }) {
    return ListaTarefaCubitModel(
        listaDeTarefas: listaDeTarefas ?? this.listaDeTarefas
    );
  }
}
