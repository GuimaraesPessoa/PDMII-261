
import 'dart:convert';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  Map<String, dynamic> toJson() {
    return {
      "nome": _nome
    };
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }

  Map<String, dynamic> toJson() {
    return {
      "nome": _nome,
      "dependentes": _dependentes
          .map((dependente) => dependente.toJson())
          .toList()
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeProjeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeProjeto;
    _funcionarios = funcionarios;
  }

  Map<String, dynamic> toJson() {
    return {
      "nomeProjeto": _nomeProjeto,
      "funcionarios": _funcionarios
          .map((funcionario) => funcionario.toJson())
          .toList()
    };
  }
}

void main() {
  // 1. Criar vários objetos Dependentes
  var dep1 = Dependente("Alice");
  var dep2 = Dependente("Enzo");
  var dep3 = Dependente("Valentina");

  // 2 e 3. Criar funcionários e associar dependentes
  var func1 = Funcionario("Carlos", [dep1, dep2]);
  var func2 = Funcionario("Maria", [dep3]);
  var func3 = Funcionario("João", []);

  // 4. Criar uma lista de Funcionários
  List<Funcionario> listaFuncionarios = [
    func1,
    func2,
    func3
  ];

  // 5. Criar o objeto EquipeProjeto
  var equipe = EquipeProjeto(
    "Artes Gráficas",
    listaFuncionarios
  );

  // 6. Converter para JSON e imprimir

  var encoder = JsonEncoder.withIndent('  ');
  print(encoder.convert(equipe.toJson())); 
}