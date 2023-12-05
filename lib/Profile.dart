import 'package:flutter/material.dart';
import 'package:projeto_intregador/Database_Login/Database/userDao.dart';
import 'package:projeto_intregador/Database_Login/models/usermodel.dart';

class EditProfilePage extends StatefulWidget {
  late String userEmail;

  EditProfilePage({Key? key, required this.userEmail}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late UserDao _userDao;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool editingEmail = false;

  @override
  void initState() {
    super.initState();
    _userDao = UserDao();

    // Busque os dados do usuário no banco de dados ao inicializar
    _loadUserData();
  }

  void _loadUserData() async {
    List<UserModel> users = await _userDao.getUsers();
    if (users.isNotEmpty) {
      UserModel user = users.first;
      setState(() {
        nameController.text = user.name;  // Inicialize o controlador com o nome do usuário
        emailController.text = user.email;
        widget.userEmail = user.email;  // Atualize o userEmail com o e-mail do usuário
      });
    }
  }

  void _saveChanges() async {
    // Adicione a lógica para salvar as alterações
    String newName = nameController.text;
    String newEmail = emailController.text;

    // Atualize o usuário no banco de dados
    List<UserModel> users = await _userDao.getUsers();
    if (users.isNotEmpty) {
      UserModel user = users.first;
      user.name = newName;
      user.email = newEmail;
      await _userDao.updateUser(user);

      // Atualize o e-mail na variável widget para refletir as alterações
      setState(() {
        widget.userEmail = newEmail;
      });
    }

    // Após salvar, você pode retornar à tela anterior
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Perfil'),
        actions: [
          // Adicione um ícone de perfil no topo
          IconButton(
            onPressed: () {
              // Adicione a lógica para lidar com a ação do ícone de perfil
            },
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exibição da foto do usuário (usando um ícone de perfil padrão)
              Align(
                alignment: Alignment.center,
                child: Container(
                  child: CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.account_circle, size: 50),
                  ),
                ),
              ),
              SizedBox(height: 16),
              // Exibição do nome do usuário
              Text(
                'Nome do Usuário: ${nameController.text}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              // Exibição do e-mail do usuário com ícone de lápis para edição
              Row(
                children: [
                  Expanded(
                    child: editingEmail
                        ? TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              hintText: 'Digite seu e-mail',
                            ),
                          )
                        : Text(
                            'Email: ${emailController.text}',
                          ),
                  ),
                  IconButton(
                    onPressed: () {
                      // Alternar entre modo de edição e visualização
                      setState(() {
                        editingEmail = !editingEmail;
                      });
                    },
                    icon: Icon(editingEmail ? Icons.save : Icons.edit),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Adicione a lógica para salvar as alterações
                  // Nome, e-mail e foto
                  // Você pode chamar uma função para isso
                  _saveChanges();
                },
                child: Text('Salvar Alterações'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


