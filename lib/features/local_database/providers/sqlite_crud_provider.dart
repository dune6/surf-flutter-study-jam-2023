import 'package:sqflite/sqflite.dart';
import 'package:surf_flutter_study_jam_2023/features/local_database/services/sqite_service.dart';

abstract class ISQLiteCrudProvider {
  Future<List<Map<String, dynamic>>> getTickets();

  Future<void> addTicket(Map<String, dynamic> ticketMap);
}

class SQLiteCrudProvider implements ISQLiteCrudProvider {
  // init database
  final SQLiteService dbService;

  SQLiteCrudProvider({required this.dbService});

  @override
  Future<void> addTicket(Map<String, dynamic> ticketMap) async {
    final db = await dbService.database;
    try {
      await db.insert(
        'tickets',
        ticketMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Map<String, dynamic>>> getTickets() async {
    try {
      final db = await dbService.database;
      var maps = await db.query(
        'tickets',
      );
      return maps;
    } catch (e) {
      rethrow;
    }
  }
}
