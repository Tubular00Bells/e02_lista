import 'package:flutter/material.dart';
//import 'package:social_share/social_share.dart'; // dependencies: social_share: ^2.0.5

const mainColor = Colors.red;

void main() {
  runApp(MaterialApp(
    title: 'Lista',
    debugShowCheckedModeBanner: false,
    home: MainApp(),
    theme: ThemeData(
        primarySwatch: mainColor,
      ),
  ));
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final _formKey = GlobalKey<FormState>();
  var _itemController = TextEditingController();
  var _priceController = TextEditingController();
  var _amountController = TextEditingController();
  List _lista = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MO-NA-D-2 ~ Shopping Forgery'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: (){}
           /* onPressed: () async {
              var itens =
                  _lista.reduce((value, element) => value + '\n' + element);
              SocialShare.shareWhatsapp("Lista de Compras:\n" + itens)
                  .then((data) {
                //print(data);
              });
            },*/
          )
        ],
      ),
      body: Scrollbar(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8),
          children: [
            Image.asset('images/title.png',),
            for (int i = 0; i < _lista.length; i++)//{
              ListTile(
                  leading: ExcludeSemantics(
                    child: CircleAvatar(child: Text('${i + 1}')),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _listItemName(i),
                      _listItemPrice(i),
                      //_listPriceTextBox(),
                      //_listAmountTextBox(),
                      _listDeleteIcon(i),
                    ],
                  )),
            //}
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _displayDialog(context),
      ),
    );
  }
/*
  _listPriceTextBox(){
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Preço',
          prefixText: 'R\$ ',
          isDense: true
          //contentPadding: EdgeInsets.all(1.0)
        )
      )
    );
  }

  _listAmountTextBox(){
    return Expanded(
      child: TextField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Qtd.',
          isDense: true
          //contentPadding: EdgeInsets.all(1.0)
        )
      ),
    );
  }*/

  _listItemName(int i){
    return Expanded(
      child: Text(
       _lista[i]["name"].toString()
       //_lista[i].toString()
      ),
    );
  }

  _listItemPrice(int i){
    String text = _lista[i]["price"] != null ? "R\$ "+_lista[i]["price"].toString() : "";
    return Expanded(
      child: Text(
        text
      ),
    );
  }

  _listDeleteIcon(int i){
    return IconButton(
      icon: Icon(
        Icons.delete,
        size: 20.0,
        color: Colors.red[900],
      ),
      onPressed: () {
        setState(() {
          _lista.removeAt(i);
        });
      },
    );
  }

  _displayDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Container(
                child: Column(//dfdfd
                children: [
                  TextFormField(
                    controller: _itemController,
                    validator: (s) {
                      if (s.isEmpty)
                        return "Digite o nome do item.";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.text,//
                    decoration: InputDecoration(labelText: "Nome do item"),
                  ),
                  TextFormField(
                    controller: _priceController,
                    validator: (s) {
                      if (s.isEmpty)
                        return "Digitjhv.";
                      else
                        return null;
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Preço",
                      prefixText: "R\$ "
                    ),
                  ),
                ],
              )
              )
              
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('SAVE'),
                onPressed: () {//
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      _lista.add({
                        "name": _itemController.text,
                        "price": double.tryParse(_priceController.text),
                        "amount": int.tryParse(_amountController.text)
                      });
                      _itemController.text = "";
                      _priceController.text = "";
                      _amountController.text = "";
                    });
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }
}