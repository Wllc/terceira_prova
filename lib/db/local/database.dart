import 'dart:async';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/db/local/pokemon_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Pokemon])
abstract class AppDatabase extends FloorDatabase {
  PokemonDao get pokemonDao;
}

class AppDatabaseProvider with ChangeNotifier {
  late final AppDatabase _db;


  Future<AppDatabase> initializeDatabase() async {
    _db = await $FloorAppDatabase.databaseBuilder('database.db').build();
    notifyListeners();
    return _db;
  }
}