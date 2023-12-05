import 'package:flutter/material.dart';
import 'package:projeto_intregador/bot%C3%B5es/Manuten%C3%A7%C3%A3o/UserDaoManu.dart';
import 'package:projeto_intregador/bot%C3%B5es/Manuten%C3%A7%C3%A3o/UserModelManu.dart';

class AddItemsPage extends StatefulWidget {
  @override
  _AddItemsPageState createState() => _AddItemsPageState();
}

class _AddItemsPageState extends State<AddItemsPage> {
  List<ItemModel> items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Itens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index].name),
                    trailing: Checkbox(
                      value: items[index].isSelected,
                      onChanged: (value) {
                        setState(() {
                          items[index].isSelected = value!;
                        });
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemDialog();
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            _saveMaintenance();
          },
          child: Text('Salvar Manutenções'),
        ),
      ),
    );
  }

  void _showAddItemDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Adicionar Item'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Digite o item'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  items.add(ItemModel(name: controller.text, isSelected: false));
                });
              },
              child: Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  void _saveMaintenance() async {
    // Lógica para salvar as manutenções selecionadas
    List<ItemModel> selectedItems = items.where((item) => item.isSelected).toList();

    // Crie uma instância de UserDaoManu
    UserDaoManu userDaoManu = UserDaoManu();

    // Adicione a lógica para salvar as manutenções no banco de dados
    for (ItemModel item in selectedItems) {
      await userDaoManu.insertUser(UserModelManu(name: item.name));
    }

    print('Manutenções selecionadas: ${selectedItems.map((item) => item.name).toList()}');
    // Limpar a lista de itens selecionados
    setState(() {
      items.clear();
    });
  }
}

class ItemModel {
  String name;
  bool isSelected;

  ItemModel({required this.name, required this.isSelected});
}
