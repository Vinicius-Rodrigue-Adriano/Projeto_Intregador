import 'package:flutter/material.dart';
import 'package:projeto_intregador/Database_Login/Database/userDao.dart';
import 'package:projeto_intregador/Database_Login/models/usermodel.dart';
import 'package:projeto_intregador/loginScreen.dart';

class CadastroPage extends StatelessWidget {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final UserDao userDao = UserDao();

  void _navigateToLoginScreen(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()), // Substitua "LoginScreen" pelo nome da sua tela de login
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              colors: [
                Colors.orange.shade900,
                Colors.orange.shade800,
                Colors.orange.shade400,
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 80,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Cadastro", style: TextStyle(color: Colors.white, fontSize: 40)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 60,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [BoxShadow(
                          color: Color.fromRGBO(225, 95, 27, .3),
                          blurRadius: 20,
                          offset: Offset(0, 10),
                        )]
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                            ),
                            child: TextField(
                              controller: nomeController,
                              decoration: InputDecoration(
                                hintText: "Nome",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                            ),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
                            ),
                            child: TextField(
                              controller: senhaController,
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: "Senha",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    MaterialButton(
                      onPressed: () async {
                        String nome = nomeController.text;
                        String email = emailController.text;
                        String senha = senhaController.text;

                        UserModel newUser = UserModel(name: nome, email: email, password: senha);

                        int userId = await userDao.createUser(newUser);

                        if (userId != -1) {
                          print('Usuário cadastrado com ID: $userId');
                          _navigateToLoginScreen(context); // Chama a função de navegação para a tela de login
                        } else {
                          print('Erro ao cadastrar o usuário.');
                        }
                      },
                      height: 60,
                      color: Colors.orange[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text("Cadastrar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

