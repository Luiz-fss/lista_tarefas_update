import 'package:flutter/material.dart';

class CardAlterarCores extends StatefulWidget {

  String tituloCard;
  Function funcaoDoCard;
  Icon iconeDaOpcao;

  CardAlterarCores({this.tituloCard,this.funcaoDoCard,this.iconeDaOpcao});

  @override
  _CardAlterarCoresState createState() => _CardAlterarCoresState();
}

class _CardAlterarCoresState extends State<CardAlterarCores> {
  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      onTap: widget.funcaoDoCard,
      child:  Card(
        color: Colors.white,
        elevation: 2.0,
        shape: Border.all(color: Colors.black),
        child:  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
             Container(
              child:  Text(widget.tituloCard),
              margin: const EdgeInsets.only(left: 24.0, top: 16.0, bottom: 16.0),
            ),
            Container(
              child: widget.iconeDaOpcao,
              margin: const EdgeInsets.only(right: 16),
            )
          ],
        ),
      ),
    );
  }
}
