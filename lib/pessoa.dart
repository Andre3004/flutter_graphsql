class Pessoa{

  final int id;
  final String nome;
  final String cpf;
  final int? idade;

  Pessoa({
      required this.id,
      required this.nome,
      required this.cpf,
      required this.idade
  });

  factory Pessoa.fromJson(Map<String, dynamic> json) => Pessoa(
    id: json['id'],
    nome: json['nome'] == null ? null : json['nome'],
    cpf: json['cpf'] == null ? null : json['cpf'],
    idade: json['idade'] == null ? null : json['idade'],
  );

}