
import 'package:plantapp/models/plant_type_model.dart';

class PlantModel{
  final int id;
  final String name;
  final PlantTypeModel type;
  final double price;

  PlantModel({required this.id, required this.name, required this.type, required this.price});
  static List<PlantModel> plants =[
    PlantModel(id: 1, name: "Monstera", type: PlantTypeModel.Indoor, price: 25),
    PlantModel(
      id: 2, name: "Spathipyllum", type: PlantTypeModel.Indoor, price: 25
    ),
    PlantModel(
      id: 3, name: "Aloe vera", type: PlantTypeModel.Indoor, price: 25
    ),
    PlantModel(
      id: 4, name: "Yucca Tree", type: PlantTypeModel.Indoor, price: 25
    ),
     PlantModel(
      id: 5, name: "Ravenea Rivularis", type: PlantTypeModel.Indoor, price: 50
    ),
    
  ];
}