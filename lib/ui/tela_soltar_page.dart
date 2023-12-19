import 'package:flutter/material.dart';
import 'package:terceira_prova/db/local/database.dart';
import 'package:terceira_prova/db/local/pokemon_dao.dart';
import 'package:terceira_prova/domain/pokemon.dart';


class TelaSoltar extends StatelessWidget {
  final int id;
  const TelaSoltar({super.key, required this.id}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TelaSoltarBody(id: id,),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class TelaSoltarBody extends StatefulWidget {
  const TelaSoltarBody({super.key, required this.id});
  final int id;
  @override
  State<TelaSoltarBody> createState() => _TelaSoltarBodyState();
}

class _TelaSoltarBodyState extends State<TelaSoltarBody> {
  
  
  late Pokemon pokemonCapturado;
  late Future<Pokemon?> pokemon;
  late PokemonDao dao;
  Future<Pokemon?> findPokemonCaptured() async {
    AppDatabaseProvider provider = AppDatabaseProvider();
    AppDatabase db = await provider.initializeDatabase();
    dao = db.pokemonDao;
    return dao.getPokemonById(widget.id);
  }

  @override
  void initState(){
      super.initState();
      pokemon = findPokemonCaptured();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('SOLTAR', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: FutureBuilder<Pokemon?>(
          future: pokemon,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return const Center(child: Text('Nenhum dado encontrado', style: TextStyle(color: Colors.deepOrange),));
            } else {
              Pokemon? pokemon = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: CircleAvatar(backgroundImage: NetworkImage(pokemon.imageUrl.toString(), scale: 10), radius: 80,),
                    ),   
                    const Row(children: [Text('')],),
                    Row(children: [
                      const Text('ID: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 22)),
                      Text(pokemon.id.toString(), style: const TextStyle(color: Colors.deepOrange, fontSize: 22),),
                    ],),
                    Row(children: [
                      const Text('NAME: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 22)),
                      Text(pokemon.name.toString().toUpperCase(), style: const TextStyle(color: Colors.deepOrange, fontSize: 22),),
                    ],),
                    Row(children: [
                      const Text('EXP: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 22)),
                      Text(pokemon.baseExperience.toString().toUpperCase(), style: const TextStyle(color: Colors.deepOrange, fontSize: 22),),
                    ],),
                    Row(children: [
                      const Text('HEIGHT: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 22)),
                      Text(pokemon.height.toString().toUpperCase(), style: const TextStyle(color: Colors.deepOrange, fontSize: 22),),
                    ],),
                    Row(children: [
                      const Text('WEIGHT: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 22)),
                      Text(pokemon.weight.toString().toUpperCase(), style: const TextStyle(color: Colors.deepOrange, fontSize: 22),),
                    ],),

                    const Text('IMAGE URL: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 22)),
                    Text(pokemon.imageUrl.toString(), style: const TextStyle( color: Colors.deepOrange, fontSize: 22),),
                
                    Row(children: [
                      const Text('ABILITIES: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 22)),
                      if(pokemon.abilities.toString().length < 18)
                        Text(pokemon.abilities.toString().toUpperCase(), style: const TextStyle(color: Colors.deepOrange, fontSize: 22),),
                    ],),
                    if(pokemon.abilities.toString().length > 18)
                      Text(pokemon.abilities.toString().toUpperCase(), style: const TextStyle(color: Colors.deepOrange, fontSize: 22),),
                    
                    Row(children: [
                      const Text('TYPES: ', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.deepPurple, fontSize: 22)),
                      Text(pokemon.types.toString().toUpperCase(), style: const TextStyle(color: Colors.deepOrange, fontSize: 22),),
                    ],),
                    const Row(children: [Text('')],),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepOrange), elevation: MaterialStatePropertyAll(10)),

                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('CANCEL', style: TextStyle(color: Colors.white)),
                        ),
                        ElevatedButton(
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.deepPurple), elevation: MaterialStatePropertyAll(10)),
                          onPressed: () {
                            dao.deletePokemon(pokemon);
                            
                            Navigator.pop(context);
                          },
                          child: const Text('RELEASE', style: TextStyle(color: Colors.white),),
                        ),
                      ],
                    ),
                    
                  ],
                ),
              );
            }
          },
        ),      
    );
  }
}