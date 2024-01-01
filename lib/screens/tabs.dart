import 'package:flutter/material.dart';
import 'package:meals/dat/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/meals_provider.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/filters.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; 

const kIntailFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});
  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreen();
  }
}

class _TabsScreen extends ConsumerState<TabsScreen> {
  int _selectedPageindex = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filter, bool> _selectedFilters = kIntailFilters;

  void _showInfomessage(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  void _toggleFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfomessage('Favourite deleted');
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfomessage('Favourite added');
      });
    }
  }

  void _selectedPage(int index) {
    setState(() {
      _selectedPageindex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FilterScreen(currentFilters: _selectedFilters,),
        ),
      );
      setState(
        () {
          _selectedFilters = result ??kIntailFilters;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
 final meals = ref.watch(mealsProvider);
    final availableMeals = meals.where((meal){
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
      return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
      return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
      return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
      return false;
      }
      return true;
    },).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleFavouriteStatus,
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';
    if (_selectedPageindex == 1) {
      activePage = MealsScreen(
          onToggleFavorite: _toggleFavouriteStatus, meals: _favouriteMeals);
      activePageTitle = 'Your Favourites';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectedPage,
        currentIndex: _selectedPageindex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.dining_outlined), label: 'Categories'),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
