import 'package:flutter/material.dart';
import 'package:projeto_intregador/bot%C3%B5es/Manuten%C3%A7%C3%A3o/UserDaoManu.dart';
import 'package:projeto_intregador/bot%C3%B5es/Manuten%C3%A7%C3%A3o/UserModelManu.dart';

class ShowItemsPage extends StatefulWidget {
  @override
  _ShowItemsPageState createState() => _ShowItemsPageState();
}

class _ShowItemsPageState extends State<ShowItemsPage> {
  UserDaoManu userDaoManu = UserDaoManu();
  List<UserModelManu> selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Itens Selecionados'),
        actions: [
          IconButton(
            onPressed: () {
              // Salvar os itens selecionados no histórico
              // Exemplo: Implemente a lógica para salvar no histórico
              // selectedItems
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Itens salvos no histórico!')),
              );
              // Limpar a lista de itens selecionados
              setState(() {
                selectedItems.clear();
              });
            },
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: FutureBuilder<List<UserModelManu>>(
        future: getMaintenanceHistory(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Erro: ${snapshot.error}');
          } else {
            List<UserModelManu> items = snapshot.data ?? [];
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                UserModelManu item = items[index];
                bool isSelected = selectedItems.contains(item);

                return ListTile(
                  title: Text(item.name),
                  trailing: Checkbox(
                    value: isSelected,
                    onChanged: (value) {
                      setState(() {
                        if (value != null) {
                          if (value) {
                            selectedItems.add(item);
                          } else {
                            selectedItems.remove(item);
                          }
                        }
                      });
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<UserModelManu>> getMaintenanceHistory() async {
    return await userDaoManu.users();
  }
}

