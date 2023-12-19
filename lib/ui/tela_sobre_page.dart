import 'package:flutter/material.dart';

class TelaSobre extends StatelessWidget {
  const TelaSobre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('SOBRE', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
      ),
      body: 
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
                Text('DESENVOLVEDORES',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo), 
                  textAlign: TextAlign.center, ),
                SizedBox(height: 20,),
                Text('Wallace Gabriel de Oliveira Araújo\nNathan Galdêncio Leocádio',
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange), 
                  textAlign: TextAlign.center, ),
                SizedBox(height: 40,),
                Text('PROFESSOR',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo), 
                  textAlign: TextAlign.center, ),
                Text('Taniro Chacon',
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange), 
                  textAlign: TextAlign.center, ),
                  SizedBox(height: 40,),
                Text('UNIDADE',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.indigo), 
                  textAlign: TextAlign.center, ),
                Text('EAJ/UFRN',
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange), 
                  textAlign: TextAlign.center, ),
              ],
            )
          ),
        ),
      )
    ),
    
    );
  }
}