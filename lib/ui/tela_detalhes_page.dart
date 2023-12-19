import 'package:flutter/material.dart';
import 'package:terceira_prova/db/local/database.dart';
import 'package:terceira_prova/db/local/pokemon_dao.dart';
import 'package:terceira_prova/domain/pokemon.dart';


class TelaDetalhes extends StatelessWidget {
  final int id;
  const TelaDetalhes({super.key, required this.id}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TelaDetalhesBody(id: id,),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}

class TelaDetalhesBody extends StatefulWidget {
  const TelaDetalhesBody({super.key, required this.id});
  final int id;
  @override
  State<TelaDetalhesBody> createState() => _TelaCapturaBodyState();
}

class _TelaCapturaBodyState extends State<TelaDetalhesBody> {
  
  late Future<Pokemon?> pk;

  Future<Pokemon?> findPokemonCaptured() async {
    AppDatabaseProvider provider = AppDatabaseProvider();
    AppDatabase db = await provider.initializeDatabase();
    PokemonDao dao = db.pokemonDao;
    return dao.getPokemonById(widget.id);
  }

  @override
  void initState(){
      super.initState();
      pk = findPokemonCaptured();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('DETAILS', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: FutureBuilder<Pokemon?>(
        future: pk,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Nenhum dado encontrado', style: TextStyle(color: Colors.deepOrange)));
          } else {
            Pokemon? pokemon = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(backgroundImage: NetworkImage(pokemon.imageUrl.toString(), scale: 10), radius: 80),
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
                  
                ],
              ),
            );
          }
        },
      ),
    );
  }
}