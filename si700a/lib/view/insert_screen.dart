import 'package:flutter/material.dart';

class InsertScreen extends StatelessWidget {
  const InsertScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inserir Novo Registro')),
      body: const Center(
        child: Text('Tela de Cadastro / Inserção', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}