import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute('''
                    CREATE TABLE tweets (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    author TEXT DEFAULT 'Formula 1',
                    text TEXT,
                    bodyImageUrl TEXT DEFAULT '',
                    profilePicUrl TEXT DEFAULT 'https://pbs.twimg.com/profile_images/1612433922733887489/7f5XFklA_400x400.jpg',
                    date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
''');
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase("f1db.db", version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  static Future<int> createData(
      String author, String text, String bodyImageUrl) async {
    final db = await SQLHelper.db();

    final data = {'author': author, 'text': text, 'bodyImageUrl': bodyImageUrl};
    final id = await db.insert('tweets', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String, dynamic>>> getData() async {
    final db = await SQLHelper.db();
    return db.query('tweets', orderBy: 'date DESC');
  }
}
