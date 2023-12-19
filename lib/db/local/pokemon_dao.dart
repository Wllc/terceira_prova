import 'package:floor/floor.dart';
import 'package:terceira_prova/domain/pokemon.dart';

@dao
abstract class PokemonDao{
  @Query('SELECT * FROM table_pokemon WHERE id = :id')
  Future<Pokemon?> getPokemonById(int id);

  @Query('SELECT * FROM table_pokemon')
  Future<List<Pokemon>> findAllPokemons();

  @insert
  Future<void> insertPokemon(Pokemon pokemon);

  @delete
  Future<void> deletePokemon(Pokemon pokemon);

}