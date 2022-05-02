import 'package:flutter/material.dart';

class ListaTarefaCubitModel {
  List listaDeTarefas;
  Color corAppBar;
  Color corTituloAppBar;
  Color corBotaoAdicionarTarefa;
  Color corIconeBotaoAdicionarTarefa;
  Color corIconeTarefaNaoConcluida;
  Color corDoFundoTarefaNaoConcluida;
  Color corIconeTarefaConcluida;
  Color corDoFundoTarefaConcluida;

  ListaTarefaCubitModel({this.listaDeTarefas, this.corAppBar,this.corTituloAppBar,this.corBotaoAdicionarTarefa,this.corIconeBotaoAdicionarTarefa,this.corIconeTarefaNaoConcluida,this.corDoFundoTarefaNaoConcluida,this.corIconeTarefaConcluida,this.corDoFundoTarefaConcluida});

  ListaTarefaCubitModel patchState({List listaDeTarefas, Color corAppBar,Color corTituloAppBar,Color corBotaoAdicionarTarefa,Color corIconeBotaoAdicionarTarefa,Color corIconeTarefaNaoConcluida,Color corDoFundoTarefaNaoConcluida,Color corIconeTarefaConcluida, Color corDoFundoTarefaConcluida}) {
    return ListaTarefaCubitModel(
        listaDeTarefas: listaDeTarefas ?? this.listaDeTarefas,
        corAppBar: corAppBar ?? this.corAppBar,
        corTituloAppBar: corTituloAppBar ?? this.corTituloAppBar,
        corBotaoAdicionarTarefa: corBotaoAdicionarTarefa ?? this.corBotaoAdicionarTarefa,
        corIconeBotaoAdicionarTarefa: corIconeBotaoAdicionarTarefa ?? this.corIconeBotaoAdicionarTarefa,
        corIconeTarefaNaoConcluida: corIconeTarefaNaoConcluida ?? this.corIconeTarefaNaoConcluida,
        corDoFundoTarefaNaoConcluida: corDoFundoTarefaNaoConcluida ?? this.corDoFundoTarefaNaoConcluida,
        corIconeTarefaConcluida: corIconeTarefaConcluida ?? this.corIconeTarefaConcluida,
        corDoFundoTarefaConcluida:  corDoFundoTarefaConcluida ?? this.corDoFundoTarefaConcluida
    );
  }
}
