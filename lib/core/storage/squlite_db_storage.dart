import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:swan_match/core/storage/database_config.dart';
import 'package:swan_match/match_status.dart';
import 'package:swan_match/shared/models/user.dart';

class SQLiteDbStorage {
  static Database? db;

  static Future<Database?>? open() async {
    db = await openDatabase(
      join(await getDatabasesPath(), DatabaseConfig.databaseName),
      onCreate: (db, version) {
        return _createDb(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute("DROP TABLE IF EXISTS recommended_matches");

          await db.execute(DatabaseConfig.createTableRecommendMatches);
        }
      },
      version: DatabaseConfig.databaseVersion,
    );
    return db;
  }

  static Future<void> _createDb(Database db) async {
    await Future.forEach(DatabaseConfig.createTableQueries, (
      createTableQuery,
    ) async {
      await db.execute(createTableQuery);
    });
  }

  static Future<void> clearFullDb() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, DatabaseConfig.databaseName);

      await deleteDatabase(path);

      db = null; // reset reference

      log("✅ Database cleared successfully");
    } catch (e) {
      log("❌ Error clearing DB: $e");
    }
  }

  Future<List<User>> getProfiles({required String status}) async {
    try {
      if (db == null) {
        await open();
      }

      if (status == MatchStatus.ACCEPTED.name) {
        final List<Map<String, dynamic>> rows = await db!.rawQuery(
          DatabaseConfig.getProfilesByStatus,
          [status],
        );

        return rows.map((row) => User.fromDb(row)).toList();
      } else {
        bool isSentByMe = true;
        if (status == MatchStatus.RECIEVED.name) {
          status = MatchStatus.SENT.name;
          isSentByMe = false;
        }

        final List<Map<String, dynamic>> rows = await db!.rawQuery(
          DatabaseConfig.getProfilesByStatusByUser,
          [status, isSentByMe],
        );

        return rows.map((row) => User.fromDb(row)).toList();
      }
    } catch (e) {
      log("error $e");
    }
    return [];
  }

  Future<void> changeMatchStatus({
    required String status,
    required String matchId,
  }) async {
    if (db == null) {
      await open();
    }
    await db!.rawUpdate(DatabaseConfig.changeMatchStatus, [status, matchId]);
  }

  Future<void> insertMatches(List<User> matches) async {
    try {
      if (db == null) await open();

      await db!.transaction((txn) async {
        final batch = txn.batch();

        for (final match in matches) {
          batch.insert(
            DatabaseConfig.recommendedMatchesTable,
            match.toDb(),
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }

        await batch.commit(noResult: true);
      });
    } catch (e) {
      log("error $e");
    }
  }
}
