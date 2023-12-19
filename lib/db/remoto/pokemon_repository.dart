import 'dart:convert';
import 'dart:math';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/db/remoto/http_client.dart';

class PokemonRepository{
  final HttpCliente client;
  
  PokemonRepository({required this.client});
  
  Future<List<Pokemon>> getPokemons() async {
      final List<Pokemon> pokemons = [];
      final List<int> randomIds = [];
      final random = Random();

      //Sorteio de 6 numeros
      while (randomIds.length < 6) {
        int randomId = random.nextInt(1017) + 1; // 1 a 1017
        if (!randomIds.contains(randomId)) {
          randomIds.add(randomId);
        }
      }

      for (final id in randomIds) {
        final response = await client.get(
          url: 'https://pokeapi.co/api/v2/pokemon/$id/'
        );
        
        if(response.statusCode == 200){
          final body = jsonDecode(response.body);
          final Pokemon pokemon = Pokemon.fromMap(body);
          pokemons.add(pokemon);
        }else if(response.statusCode == 404){
          throw Exception('Failed to load pokemon');
        }     
      }

      return pokemons;
    
  }

}

