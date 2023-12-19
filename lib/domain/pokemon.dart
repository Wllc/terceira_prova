import 'package:floor/floor.dart';

@Entity(tableName: 'table_pokemon')
class Pokemon {
  @PrimaryKey(autoGenerate: true)
  final int id;

  final String? name;
  final int? baseExperience;
  final int? height;
  final int? weight;
  final String? imageUrl;
  final String? abilities;
  final String? types;

  Pokemon({
    required this.id,
    this.name,
    this.baseExperience,
    this.height,
    this.weight,
    this.imageUrl,
    this.abilities,
    this.types,
  });

  factory Pokemon.fromMap(Map<String, dynamic> map){
    return Pokemon(
      id: map['id'] ?? 0,
      name: map['name'], 
      baseExperience: map['base_experience'] ?? 0, 
      height: map['height']?? 0, 
      weight: map['weight'] ?? 0, 
      imageUrl: map['sprites']['front_default'] ?? map['sprites']['back_default'], 
      //List<String>.from(map['abilities']?.map((ability) => ability['ability']['name'].toString()) ?? ['']),
      //types: map['types']?.map((type) => type['type']['name'].toString()) ?? '',
      abilities: (map['abilities'] as List<dynamic>?)
          ?.map((ability) => ability['ability']['name'].toString())
          .join(', '),
      types: (map['types'] as List<dynamic>?)
          ?.map((type) => type['type']['name'].toString())
          .join(', '),
      );
  }
}




