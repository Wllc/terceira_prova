import 'package:flutter/material.dart';
import 'package:terceira_prova/db/local/database.dart';
import 'package:terceira_prova/db/local/pokemon_dao.dart';
import 'package:terceira_prova/domain/pokemon.dart';
import 'package:terceira_prova/ui/tela_detalhes_page.dart';
import 'package:terceira_prova/ui/tela_soltar_page.dart';



class TelaCapturados extends StatelessWidget {
  const TelaCapturados({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TelaCapturadosBody(),
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}


class TelaCapturadosBody extends StatefulWidget {
  const TelaCapturadosBody({super.key});

  @override
  State<TelaCapturadosBody> createState() => _TelaCapturadosBodyState();
}

class _TelaCapturadosBodyState extends State<TelaCapturadosBody> {
  late Future<List> pokemosCapturados = Future(() => []);
  late PokemonDao pokemonDao;

  Future<void> findPokemonsCaptureds() async {
    AppDatabaseProvider provider = AppDatabaseProvider();
    AppDatabase db = await provider.initializeDatabase();
    pokemonDao = db.pokemonDao;
    setState(() {
      pokemosCapturados = pokemonDao.findAllPokemons();
    });
  }

  @override
  void initState(){
    super.initState(); 
    findPokemonsCaptureds();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: pokemosCapturados,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
        }else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else if (snapshot.data!.isEmpty) {
              return const Center(child: Text('Nenhum dado encontrado', style: TextStyle(color: Colors.deepOrange),));
        } else {
          return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return ListItem(pokemon: snapshot.data![i],);
          },);
        }
      },
    );
  }
}

class ListItem extends StatefulWidget {
  final Pokemon pokemon;

  const ListItem({Key? key, required this.pokemon,}) : super(key: key);

  @override
  ListItemState createState() => ListItemState();
}

class ListItemState extends State<ListItem> {

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: () {
          
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Single Tap"),
          ));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaDetalhes(id: widget.pokemon.id)),
          );
        },    
        onLongPress: () {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Long Press"),
          ));
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaSoltar(id: widget.pokemon.id)),
          ); 
        },
        
        child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        leading: CircleAvatar(backgroundImage: NetworkImage(widget.pokemon.imageUrl.toString()),radius: 30),
        title: Text(
          widget.pokemon.name.toString().toUpperCase(),
          style: const TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        subtitle: Text('EXP:${widget.pokemon.baseExperience}', style: const TextStyle(color: Colors.deepOrange)),
    ),
      );
  }
}