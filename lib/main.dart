import 'package:flutter/material.dart';
import 'package:flutter_checklist/pessoa.dart';
import 'package:flutter_checklist/pessoa_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  PessoaRepository _pessoaRepository = PessoaRepository();

  @override
  Widget build(BuildContext context) {
    //_pessoaRepository.addPessoa("Adicionado do flutter", "88888888888", 33);
    //_pessoaRepository.updatePessoa(9, "Atualizado do flutter", "88899888888", 55);
    //_pessoaRepository.removePessoa(9);
    //_pessoaRepository.getPessoas();

    return Scaffold(
      appBar: AppBar(
        title: Text("Teste graphql"),
      ),
      body: FutureBuilder(
        future: _pessoaRepository.getPessoas(),
        builder: (BuildContext context, AsyncSnapshot<List<Pessoa>> snapshot) {
          var pessoas = snapshot.data!;
          return ListView.builder(itemBuilder: (_, index) {
            return Text(pessoas[index].nome);
          }, itemCount: pessoas.length,);
        },
      ),
    );
  }
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
