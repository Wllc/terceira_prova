import 'dart:async';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:terceira_prova/connection/connection_notifier.dart';
import 'package:terceira_prova/db/local/database.dart';
import 'package:terceira_prova/db/local/pokemon_dao.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/db/remoto/http_client.dart';
import 'package:terceira_prova/db/remoto/pokemon_repository.dart';


class TelaCaptura extends StatelessWidget {
  const TelaCaptura({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TelaCapturaBody(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}


class TelaCapturaBody extends StatefulWidget {
  const TelaCapturaBody({super.key});

  @override
  State<TelaCapturaBody> createState() => _TelaCapturaBodyState();
}

class _TelaCapturaBodyState extends State<TelaCapturaBody> {
  final PokemonRepository pokemonRepository = PokemonRepository(client: HttpCliente());
  late Future<List> pokemons = Future(() => []);
  //late AppDatabase db;
  late final StreamSubscription<InternetConnectionStatus> listener;

  checkConnection(){
    listener = InternetConnectionChecker().onStatusChange.listen((status){
        final notifier = ConnectionNotifier.of(context);
        notifier.value = status == InternetConnectionStatus.connected ? true : false;
    });
  }
  @override
  void initState(){
      super.initState();
      checkConnection();
      //pokemons = pokemonRepository.getPokemons();
  }
  
  @override
  void dispose(){
    listener.cancel();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    final hasConnection = ConnectionNotifier.of(context).value;
    if(hasConnection){
      pokemons = pokemonRepository.getPokemons();
    }

    return FutureBuilder(
      future: pokemons,
      builder: (context, snapshot) {
        if(hasConnection){
          return snapshot.hasData  ? ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ListItem(pokemon: snapshot.data![i]);
                  },
                ) : const Center(
                  child: CircularProgressIndicator(),
                );
        }else{
          return const Center( child: Text('Please turn on your wifi or mobile data'));   
        }
      },
    ) ;
  }

}

class ListItem extends StatefulWidget {
  final Pokemon pokemon;

  const ListItem({Key? key, required this.pokemon,}) : super(key: key);

  @override
  ListItemState createState() => ListItemState();
}

class ListItemState extends State<ListItem> {
  bool isButtonPressed = false;

  Future<void> addPokemonCaptured(Pokemon pokemon) async {
    AppDatabaseProvider provider = AppDatabaseProvider();
    AppDatabase db = await provider.initializeDatabase();
    PokemonDao pokemonDao = db.pokemonDao;
    pokemonDao.insertPokemon(pokemon);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: CircleAvatar(backgroundImage: NetworkImage(widget.pokemon.imageUrl.toString()),radius: 30),
        title: Text(
          widget.pokemon.name.toString(),
          style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('EXP:${widget.pokemon.baseExperience}', style: const TextStyle(color: Colors.deepOrange)),
        trailing: IconButton(
          icon: Icon(Icons.catching_pokemon, color: isButtonPressed ? Colors.grey : const Color.fromARGB(255, 238, 21, 21), size: 50),
          onPressed: () {
            setState(() {         
              if(!isButtonPressed){
                addPokemonCaptured(widget.pokemon);
              }
              isButtonPressed = true;
            });
          },
        ),
      ),
    );
  }
}
