import 'dart:convert';

class Tarefa {
  int? id;
  String titulo;
  String descricao;
  int prioridade;
  String criadoEm;
  double indiceRelevancia;

  Tarefa({
    this.id,
    required this.titulo,
    required this.descricao,
    required this.prioridade,
    required this.criadoEm,
    required this.indiceRelevancia,
  });

  Map<String, dynamic> toMap() {
    final json = {
      'id': id,
      'titulo': titulo,
      'descricao': descricao,
      'prioridade': prioridade,
      'criadoEm': criadoEm,
      'indiceRelevancia': indiceRelevancia,
    };

    print("🔎 JSON gerado da Tarefa: $json");

    return json;
  }

  factory Tarefa.fromMap(Map<String, dynamic> map) {
    return Tarefa(
      id: map['id'],
      titulo: map['titulo'],
      descricao: map['descricao'],
      prioridade: map['prioridade'],
      criadoEm: map['criadoEm'],
      indiceRelevancia: map['indiceRelevancia'] is int
          ? (map['indiceRelevancia'] as int).toDouble()
          : map['indiceRelevancia'],
    );
  }
}
