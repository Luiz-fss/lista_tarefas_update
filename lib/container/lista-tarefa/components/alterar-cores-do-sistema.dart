import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-model.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit.dart';
import 'package:lista_tarefas_atualizado/utils/card-alteracao-cores.dart';
import 'package:lista_tarefas_atualizado/utils/tipo-edicao-cor.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AlterarCoresDoSistema extends StatefulWidget {
  const AlterarCoresDoSistema({Key key}) : super(key: key);
  static String ROUTE = "/alterar-cores-sistema";

  @override
  _AlterarCoresDoSistemaState createState() => _AlterarCoresDoSistemaState();
}

class _AlterarCoresDoSistemaState extends State<AlterarCoresDoSistema> {
  ListaTarefaCubit _bloc;
  SharedPreferences _sharedPreferences;
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
              funcaoDoCard: ()async{
                await editarCorDaAppBar(context);
                _sharedPreferences =await SharedPreferences.getInstance();
                _sharedPreferences.setInt(
                  TipoEdicaoCorSelecao[TipoEdicaoCor.COR_APP_BAR],
                    _bloc.state.corAppBar.value
                );
              },
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do título da App Bar",
              funcaoDoCard: ()async{
                await editarCorTituloDaAppBar(context);
                _sharedPreferences =await SharedPreferences.getInstance();
                _sharedPreferences.setInt(
                    TipoEdicaoCorSelecao[TipoEdicaoCor.COR_TITULO_APP_BAR],
                    _bloc.state.corTituloAppBar.value);
              },
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do Botão de Adiconar Tarefa",
              funcaoDoCard: ()async{
                await editarCorBotaoAdicionarTarefa(context);
                _sharedPreferences.setInt(
                    TipoEdicaoCorSelecao[TipoEdicaoCor.COR_BOTAO_ADICIONAR_TAREFA],
                    _bloc.state.corBotaoAdicionarTarefa.value);
              },
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do ícone do Botão de Adiconar Tarefa",
              funcaoDoCard: ()async{
                await editarCorIconeAdicionarTarefa(context);
                _sharedPreferences.setInt(
                    TipoEdicaoCorSelecao[TipoEdicaoCor.COR_ICONE_ADICIONAR_TAREFA],
                    _bloc.state.corIconeBotaoAdicionarTarefa.value);
              },
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do ícone de tarefa não concluida",
              funcaoDoCard: ()async{
                await editarCorIconeTarefaNaoConcluida(context);
                _sharedPreferences.setInt(
                    TipoEdicaoCorSelecao[TipoEdicaoCor.COR_ICONE_TAREFA_NAO_CONCLUIDA],
                    _bloc.state.corIconeTarefaNaoConcluida.value);
              },
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do fundo de tarefa não concluida",
              funcaoDoCard: ()async{
               await editarCorFundoTarefaNaoConcluido(context);
               _sharedPreferences.setInt(
                   TipoEdicaoCorSelecao[TipoEdicaoCor.COR_FUNDO_TAREFA_NAO_CONCLUIDA],
                   _bloc.state.corDoFundoTarefaNaoConcluida.value);
              },
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do ícone de tarefa concluida",
              funcaoDoCard: ()async{
                await editarCorIconeTarefaConcluido(context);
                _sharedPreferences.setInt(
                    TipoEdicaoCorSelecao[TipoEdicaoCor.COR_ICONE_TAREFA_CONCLUIDA],
                    _bloc.state.corIconeTarefaConcluida.value);
              },
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: CardAlterarCores(
              tituloCard: "Cor do fundo de tarefa concluida",
              funcaoDoCard: ()async{
                await editarCorFundoTarefaConcluido(context);
                _sharedPreferences.setInt(
                    TipoEdicaoCorSelecao[TipoEdicaoCor.COR_FUNDO_TAREFA_CONCLUIDA],
                    _bloc.state.corDoFundoTarefaConcluida.value);
              },
              iconeDaOpcao: const Icon(Icons.add_circle,color: Colors.green,),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> editarCorDaAppBar(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Escolha cor da App Bar"),
        content:  SingleChildScrollView(
          child:  ColorPicker(
            pickerColor: Colors.blue,
            onColorChanged: (Color changeColor){
              _bloc.state.corAppBar = changeColor;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
           FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              _bloc.mudarCorAppBar(_bloc.state.corAppBar);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> editarCorTituloDaAppBar(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Escolha cor do titulo da App Bar"),
        content:  SingleChildScrollView(
          child:  ColorPicker(
            pickerColor: Colors.blue,
            onColorChanged: (Color changeColor)async{
              _bloc.state.corTituloAppBar = changeColor;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              _bloc.mudarTituloCorAppBar(_bloc.state.corTituloAppBar);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }


  Future<void> editarCorBotaoAdicionarTarefa(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Escolha cor do botão de adicionar tarefa"),
        content:  SingleChildScrollView(
          child:  ColorPicker(
            pickerColor: Colors.blue,
            onColorChanged: (Color changeColor){
              _bloc.state.corBotaoAdicionarTarefa = changeColor;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              _bloc.mudarCorBotaoAdicionarTarefa(_bloc.state.corBotaoAdicionarTarefa);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> editarCorIconeAdicionarTarefa(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Escolha cor do ícone do botão de adicionar tarefa"),
        content:  SingleChildScrollView(
          child:  ColorPicker(
            pickerColor: Colors.blue,
            onColorChanged: (Color changeColor){
              _bloc.state.corIconeBotaoAdicionarTarefa = changeColor;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              _bloc.mudarCorIconeBotaoAdicionarTarefa(_bloc.state.corIconeBotaoAdicionarTarefa);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> editarCorIconeTarefaNaoConcluida(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Escolha cor do ícone de tarefa não concluida"),
        content:  SingleChildScrollView(
          child:  ColorPicker(
            pickerColor: Colors.blue,
            onColorChanged: (Color changeColor){
              _bloc.state.corIconeTarefaNaoConcluida = changeColor;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              _bloc.mudarCorIconeTarefaNaoConcluida(_bloc.state.corIconeTarefaNaoConcluida);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> editarCorFundoTarefaNaoConcluido(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Escolha cor do fundo da tarefa não concluida"),
        content:  SingleChildScrollView(
          child:  ColorPicker(
            pickerColor: Colors.blue,
            onColorChanged: (Color changeColor){
              _bloc.state.corDoFundoTarefaNaoConcluida = changeColor;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              _bloc.mudarCorFundoTarefaNaoConcluida(_bloc.state.corDoFundoTarefaNaoConcluida);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> editarCorIconeTarefaConcluido(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Escolha cor do ícone da tarefa concluida"),
        content:  SingleChildScrollView(
          child:  ColorPicker(
            pickerColor: Colors.blue,
            onColorChanged: (Color changeColor){
              _bloc.state.corIconeTarefaConcluida = changeColor;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              _bloc.mudarCorTarefaConcluida(_bloc.state.corIconeTarefaConcluida);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
  Future<void> editarCorFundoTarefaConcluido(BuildContext context) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Escolha cor do fundo da tarefa concluida"),
        content:  SingleChildScrollView(
          child:  ColorPicker(
            pickerColor: Colors.blue,
            onColorChanged: (Color changeColor){
              _bloc.state.corIconeTarefaConcluida = changeColor;
            },
            showLabel: true,
            pickerAreaHeightPercent: 0.8,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('Ok'),
            onPressed: () {
              _bloc.mudarCorTarefaConcluida(_bloc.state.corIconeTarefaConcluida);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
