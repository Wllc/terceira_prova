import 'package:flutter/material.dart';
import 'package:terceira_prova/ui/tela_captura_page.dart';
import 'package:terceira_prova/ui/tela_capturados_page.dart';
import 'package:terceira_prova/ui/tela_sobre_page.dart';

class TelaHome extends StatefulWidget {
  const TelaHome({Key? key}) : super(key: key);

  @override
  State<TelaHome> createState() => _TelaHome();
}

class _TelaHome extends State<TelaHome> {
  int _selectedIndex = 0;
  
  static final List<Widget> _widgetOptions = <Widget>[
    const Center(
      child: Card(
        clipBehavior: Clip.hardEdge,
        elevation: 10,
        child: InkWell(
          child: SizedBox(
            width: 370,
            height: 380,
            child: Column(
              children: [
                SizedBox(height: 40,),
                Text('Seja bem-vindo ao aplicativo "Terceira Prova"!',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo), 
                textAlign: TextAlign.justify, ),
                SizedBox(height: 40,),
                Text('Este app foi desenvolvido na disciplina de Programação para Dispositivos Móveis'
                ' com o intuito de guardar dados de Pokémons com base nas informações obtidas através do consumo da API disponibilizada.',
                style: TextStyle(fontSize: 16, color: Colors.indigo), 
                textAlign: TextAlign.justify, ),
                SizedBox(height: 40,),
                Text('API',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo), 
                textAlign: TextAlign.justify, ), 
                Text('PokeAPI (https://pokeapi.co/).',
                style: TextStyle(fontSize: 16, color: Colors.indigo), 
                textAlign: TextAlign.justify, ),
              ],
            )
            
          ),
        ),
      )
    ),
    const TelaCaptura(),
    const TelaCapturados(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(255, 58, 58, 58),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('Terceira Prova', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0), // Ajuste a margem conforme necessário
            child: IconButton(
              icon: const Icon(Icons.info, color: Color.fromARGB(150, 255, 255, 255),),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaSobre()),
                );
              },
            ),
          )
        ],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.catching_pokemon_outlined),
            label: 'Captura',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Capturados',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        onTap: _onItemTapped,
      ),
    );
  }
}