import 'package:expenses/models/features_model.dart';

class CategoryList {
  var catList = [
    FeaturesModel(
      category: 'Gasolina',
      color: '#087800',
      icon: 'local_gas_station_outlined',
    ),
    FeaturesModel(
      category: 'Supermercado',
      color: '042a77',
      icon: 'local_grocery_store_outlined',
    ),
    FeaturesModel(
      category: 'Restaurante',
      color: 'f88709',
      icon: 'local_dining_outlined',
    ),
    FeaturesModel(
      category: 'Hogar',
      color: '853bfb',
      icon: 'home',
    ),
  ];
}
