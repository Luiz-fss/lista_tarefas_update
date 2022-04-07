import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit-model.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/bloc/lista-tarefa-cubit.dart';

class DialogCadastroNovaTarefa extends StatelessWidget {

  ListaTarefaCubit _bloc;

  DialogCadastroNovaTarefa(this._bloc);

  TextEditingController _nomeTarefaController =  TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(
      value: _bloc,
      child: BlocBuilder<ListaTarefaCubit, ListaTarefaCubitModel>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: _buildBody(state,context),
          );
        },
      ),
    );
  }

  Widget _buildBody(ListaTarefaCubitModel state, BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffc7c7c7),
            borderRadius: BorderRadius.circular(6)),
        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
        height: MediaQuery
            .of(context)
            .size
            .height * 0.3,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(top: 16,left: 16),
                child: const Text(
                  "Adicionar nova tarefa do dia",
                  style: TextStyle(
                    fontSize: 16,
                    letterSpacing: -0.24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black
                  ),
                ),
              ),
              Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.070,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6)),
                  margin: const EdgeInsets.only(
                      left: 16, top: 16, bottom: 16, right: 16),
                  padding: const EdgeInsets.all(16),
                  child:  TextField(
                    controller: _nomeTarefaController,
                    maxLines: 5,
                    autofocus: true,
                    textInputAction: TextInputAction.done,
                    decoration:  InputDecoration.collapsed(
                        hintText: "Digite sua mensagem...",
                        hintStyle:  TextStyle(
                            color: Colors.grey.withOpacity(0.5))),
                  )),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                        padding: MaterialStateProperty.all(const EdgeInsets.only(
                            top: 14, bottom: 14, left: 24, right: 24)),
                        shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        )),
                      ),
                      onPressed: () async {
                        _bloc.adicionarNovaTarefa(_nomeTarefaController.text);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Salvar Tarefa")),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
