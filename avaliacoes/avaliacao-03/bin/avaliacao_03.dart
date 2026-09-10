import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Future<void> main() async {
  Database? banco;

  // Inicializa o SQLite para aplicações Dart no Windows.
  sqfliteFfiInit();

  final databaseFactory = databaseFactoryFfi;

  // 1. Criando ou abrindo o banco de dados
  try {
    print('Abrindo banco de dados...');

    banco = await databaseFactory.openDatabase(
      'alunos.db',
    );

    print('Banco de dados conectado com sucesso!');
  } catch (e) {
    print('Erro ao abrir o banco de dados: $e');
    return;
  }

  // 2. Criando a tabela
  try {
    print('Criando tabela tb_alunos...');

    await banco.execute('''
      CREATE TABLE IF NOT EXISTS tb_alunos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        idade INTEGER NOT NULL
      )
    ''');

    print('Tabela criada com sucesso!');
  } catch (e) {
    print('Erro ao criar a tabela: $e');
  }

  // 3. Inserindo três alunos
  try {
    print('Inserindo alunos...');

    await banco.insert('tb_alunos', {
      'nome': 'Pedro',
      'idade': 17,
    });

    await banco.insert('tb_alunos', {
      'nome': 'João',
      'idade': 18,
    });

    await banco.insert('tb_alunos', {
      'nome': 'Maria',
      'idade': 17,
    });

    print('Três alunos inseridos com sucesso!');
  } catch (e) {
    print('Erro ao inserir alunos: $e');
  }

  // 4. Listando o conteúdo da tabela
  try {
    print('\n=== ALUNOS CADASTRADOS ===');

    final List<Map<String, Object?>> alunos = await banco.query(
      'tb_alunos',
    );

    for (final aluno in alunos) {
      print(
        'ID: ${aluno['id']} | '
        'Nome: ${aluno['nome']} | '
        'Idade: ${aluno['idade']}',
      );
    }
  } catch (e) {
    print('Erro ao listar os alunos: $e');
  }

  // Fechando o banco
  try {
    await banco.close();

    print('\nBanco de dados fechado.');
  } catch (e) {
    print('Erro ao fechar o banco de dados: $e');
  }
}