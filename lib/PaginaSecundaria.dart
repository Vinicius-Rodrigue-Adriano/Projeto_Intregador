import 'package:flutter/material.dart';
import 'package:projeto_intregador/Profile.dart';
import 'package:projeto_intregador/bot%C3%B5es/Manuten%C3%A7%C3%A3o/Manu.dart';
import 'package:projeto_intregador/bot%C3%B5es/calender.dart';
import 'package:projeto_intregador/chat%20bot/chat_screen.dart';

class MenuScreen extends StatefulWidget {
  final String userEmail;

  MenuScreen({Key? key, required this.userEmail}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<MaintenanceRequest> maintenanceRequests = [];
  List<PartRequest> partRequests = [];
  List<Set<int>> savedSelections = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Minha Conta'),
              onTap: () {
                   Navigator.push(
                   context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(userEmail: widget.userEmail,),
                 ),
                );
             }
            ),
            
            ListTile(
              leading: Icon(Icons.build),
              title: Text('Solicitação de Peça'),
              onTap: () {
                // Implemente a navegação ou ação desejada
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('Histórico de Manutenção'),
              onTap: () {
                // Implemente a navegação ou ação desejada
              },
            ),
            ListTile(
              leading: Icon(Icons.warning),
              title: Text('Manutenção Emergencial'),
              onTap: () {
                // Implemente a navegação ou ação desejada
              },
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          // Adicione o código desejado para o novo botão aqui
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.orange, // Cor de exemplo, ajuste conforme necessário
                        ),
                        child: Text('Novo Botão 1'),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          // Adicione o código desejado para o novo botão aqui
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.orange, // Cor de exemplo, ajuste conforme necessário
                        ),
                        child: Text('Novo Botão 2'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          // Adicione o código desejado para o novo botão aqui
                           Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddItemsPage(),
                            ),
                            );
                        
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text('Manutenção'),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          // Adicione o código desejado para o novo botão aqui
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text('Solicitação de Peça'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DatePickerApp(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text('Agendamento de Manutenção'),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          // Adicione o código desejado para o novo botão aqui
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text('Manutenção Emergencial'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.blue,
                        ),
                        child: Text('Chatbot'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MaintenanceRequest {
  final String title;
  final String status;

  MaintenanceRequest({required this.title, required this.status});
}

class PartRequest {
  final String partName;
  final String status;

  PartRequest({required this.partName, required this.status});
}
