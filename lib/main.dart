import 'package:flutter/material.dart';
import 'package:lista_tarefas_atualizado/container/lista-tarefa/components/home.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Z Candidato',
      debugShowCheckedModeBanner: false,
      home:  Home(),
      routes: {
        Home.ROUTE: (context) => const Home()
      },
    );
  }
}
