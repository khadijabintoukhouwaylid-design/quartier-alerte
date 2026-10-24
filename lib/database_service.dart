
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initialiserBaseDeDonnees();
    return _database!;
  }

  Future<Database> _initialiserBaseDeDonnees() async {
    final String chemin = join(
      await getDatabasesPath(),
      'quartier_alerte.db',
    );

    return openDatabase(
      chemin,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE signalements (
            id TEXT PRIMARY KEY,
            categorie TEXT NOT NULL,
            description TEXT,
            photoPath TEXT,
            latitude REAL,
            longitude REAL,
            audioPath TEXT,
            dateCreation TEXT NOT NULL,
            statut TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<void> ajouterSignalement(Map<String, dynamic> donnees) async {
    final Database db = await database;

    await db.insert(
      'signalements',
      donnees,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> obtenirSignalements() async {
    final Database db = await database;

    return db.query(
      'signalements',
      orderBy: 'dateCreation DESC',
    );
  }

  Future<void> supprimerSignalement(String id) async {
    final Database db = await database;

    await db.delete(
      'signalements',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
