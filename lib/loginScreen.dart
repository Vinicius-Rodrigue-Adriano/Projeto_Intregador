import 'package:flutter/material.dart';
import 'package:projeto_intregador/Cadastro.dart';
import 'package:projeto_intregador/PaginaSecundaria.dart';
import 'package:projeto_intregador/Database_Login/Database/userDao.dart';  // Import UserDao
import 'package:projeto_intregador/Database_Login/models/usermodel.dart';  // Import UserModel

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  final UserDao userDao = UserDao();  // Create UserDao instance

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
                    Text("Login", style: TextStyle(color: Colors.white, fontSize: 40)),
                    SizedBox(height: 10,),
                    Text("Welcome Back", style: TextStyle(color: Colors.white, fontSize: 18)),
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
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: "Email or Phone number",
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
                                hintText: "Password",
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
                        String email = emailController.text;
                        String senha = senhaController.text;

                        // Fetch user from the database based on email and password
                        List<UserModel> users = await userDao.getUsers();
                        UserModel authenticatedUser = users.firstWhere(
                          (user) => user.email == email && user.password == senha,
                          orElse: () => UserModel(id: -1, name: '', email: '', password: ''),
                        );

                        if (authenticatedUser.id != -1) {
                          // Navigate to the next page if authentication is successful
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MenuScreen(userEmail: authenticatedUser.email)),
                          );
                        } else {
                          // Display an error message if authentication fails
                          print("Authentication failed");
                        }
                      },
                      height: 60,
                      color: Colors.orange[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text("Login", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                    SizedBox(height: 20,),
                    MaterialButton(
                      onPressed: () {
                        // Navigate to the page of registration
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CadastroPage()),
                        );
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
