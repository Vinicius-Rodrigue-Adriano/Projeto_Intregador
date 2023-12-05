import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> documentations = ["Documentação 1", "Documentação 2", "Documentação 3"];
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  void _showDocumentation(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Documentação'),
          content: Text('Documentação para a mensagem: $message'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showAllDocumentations() async {
    for (String documentation in documentations) {
      String content = await _readDocumentation(documentation);
      print('Documentação: $documentation\nConteúdo:\n$content');
    }
  }

  Future<String> _readDocumentation(String documentation) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentsDirectory.path;
    File documentFile = File('$documentPath/$documentation.txt');

    if (await documentFile.exists()) {
      return await documentFile.readAsString();
    } else {
      return 'Arquivo não encontrado';
    }
  }

  void _showDocumentWebView(String documentation) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentsDirectory.path;
    String fileUrl = 'file://$documentPath/$documentation.txt';

    flutterWebviewPlugin.launch(
      fileUrl,
      rect: Rect.fromPoints(Offset.zero, Offset(context.screenWidth, context.screenHeight)),
    );
  }

  void _sendDocumentation(String documentation) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String documentPath = documentsDirectory.path;

    File documentFile = File('$documentPath/$documentation.txt');

    await documentFile.writeAsString('Conteúdo da documentação: $documentation');

    // Adicione esta linha para exibir o WebView com o conteúdo do documento
    _showDocumentWebView(documentation);
  }

  Widget _buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration.collapsed(
              hintText: "Enviar uma mensagem",
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            String message = _controller.text.toLowerCase();
            if (message == 'Templates de Documentos\n Manutenção exterior Documentação Reparo interior\nEstofamento e Revestimento:\nAssentos: Revestimento de assentos, troca de espumas e materiais de estofamento para garantir conforto e durabilidade.\nPainéis: Revestimento de painéis interiores, incluindo laterais, teto e piso.\nIluminação e Eletrônicos:\nSistemas de Iluminação: Atualização de sistemas de iluminação interior, incluindo luzes de teto, luzes de leitura e luzes de emergência.\nEntretenimento a Bordo: Instalação ou atualização de sistemas de entretenimento a bordo, como monitores, sistemas de áudio e conectividade.\nConectividade e Comodidades:\nWi-Fi a Bordo: Instalação de sistemas Wi-Fi para proporcionar conectividade aos passageiros.\nTomadas de Energia: Adição de pontos de energia para carregamento de dispositivos eletrônicos.') {
              _showAllDocumentations();
            } else {
              _showDocumentation(_controller.text);
              // Adicione esta linha para enviar o arquivo de documentação .txt
              _sendDocumentation(_controller.text);
            }
          },
        ),
        PopupMenuButton<int>(
          icon: const Icon(Icons.article),
          onSelected: (int index) {
            _sendDocumentation(documentations[index]);
          },
          itemBuilder: (BuildContext context) {
            return List.generate(
              documentations.length,
              (index) => PopupMenuItem<int>(
                value: index,
                child: Text('Documentação ${index + 1}'),
              ),
            );
          },
        ),
      ],
    ).px16();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Documentações")),
      body: Column(
        children: [
          Flexible(child: Container(height: context.screenHeight)),
          Container(
            decoration: BoxDecoration(
              color: context.cardColor,
            ),
            child: _buildTextComposer(),
          ),
        ],
      ),
    );
  }
}

