import 'package:flutter_checklist/pessoa.dart';
import 'package:hasura_connect/hasura_connect.dart';

class PessoaRepository{
  final HasuraConnect _hasuraConnect = HasuraConnect("https://flutter-app-checklist.herokuapp.com/v1/graphql");

  PessoaRepository();

  Future<List<Pessoa>> getPessoas() async {
    List<Pessoa> listPessoas = [];
    Pessoa pessoa;
    var query = '''
      query listAll {
        pessoa {
          id
          nome
          cpf,
          idade
        }
      }
    ''';

    var snapshot = await _hasuraConnect.query(query);
    for (var json in (snapshot['data']['pessoa']) as List) {
      pessoa = Pessoa.fromJson(json);
      listPessoas.add(pessoa);
    }
    return listPessoas;
  }

  // novo método adicionado
  Future<int> addPessoa(String nome, String cpf, int? idade) async {
    var query = """
      mutation insert_single_pessoa(\$nome:String!, \$cpf:String!, \$idade:Int!) {
        insert_pessoa_one(
          object: {
            nome: \$nome,
            cpf: \$cpf,
            idade: \$idade
          }
        ) {
          id
        }
      }
      """;
    var data = await _hasuraConnect.mutation(query, variables: {
      "nome": nome,
      "cpf": cpf,
      "idade": idade,
    });
    return data["data"]['insert_pessoa_one']['id'];
  }

  Future<int> updatePessoa(int id, String nome, String cpf, int? idade) async {
    var query = """
      mutation update_single_pessoa(\$id:Int!, \$nome:String!, \$cpf:String!, \$idade:Int!) {
        update_pessoa_by_pk (
          pk_columns: {id: \$id}
          _set: { 
              nome: \$nome
              cpf: \$cpf
              idade: \$idade 
          }
        ) {
          id
        }
      }
      """;
    var data = await _hasuraConnect.mutation(query, variables: {
      "id": id,
      "nome": nome,
      "cpf": cpf,
      "idade": idade,
    });
    return data["data"]['update_pessoa_by_pk']['id'];
  }

  Future<int> removePessoa(int id) async {
    var query = """
                  mutation delete_pessoa(\$id:Int!) {
                    delete_pessoa_by_pk (
                      id: \$id
                    ) {
                      id
                    }
                  }
      """;
    var data = await _hasuraConnect.mutation(query, variables: {
      "id": id,
    });

    return data["data"]['delete_pessoa_by_pk']['id'];
  }
}