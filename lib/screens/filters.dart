import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}
class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key,required this.currentFilters});
  final Map<Filter, bool> currentFilters;
  @override
  State<StatefulWidget> createState() {
    return _FilterScreen();
  }
}

class _FilterScreen extends State<FilterScreen> {
  var _glutenfreefilterset = false;
  var _lactosefreefilterset = false;
  var _vegetarianfilterset = false;
  var _veganfilterset = false;
  @override
  void initState() {
    super.initState();
     _glutenfreefilterset = widget.currentFilters[Filter.glutenFree]!;
    _lactosefreefilterset = widget.currentFilters[Filter.lactoseFree]!;
     _vegetarianfilterset = widget.currentFilters[Filter.vegetarian]!;
     _veganfilterset = widget.currentFilters[Filter.vegan]!;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Filters',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
     /* drawer: MainDrawer(onSelectScreen: (identifier) {
        Navigator.of(context).pop();
        if(identifier == 'meals') {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const TabsScreen(),),);
        }
      }),*/
      // ignore: deprecated_member_use
      body: WillPopScope(
       onWillPop: () async {
          Navigator.of(context).pop({
          Filter.glutenFree:_glutenfreefilterset,
          Filter.lactoseFree:_lactosefreefilterset,
          Filter.vegetarian:_vegetarianfilterset,
          Filter.vegan:_veganfilterset,
          });
          return false;
          },
        child: Column(
          children: [
            SwitchListTile(
              value: _glutenfreefilterset,
              onChanged: (changed) {
                setState(
                  () {
                    _glutenfreefilterset = changed;
                  },
                );
              },
              title: Text(
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free neals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
             SwitchListTile(
              value: _lactosefreefilterset,
              onChanged: (changed) {
                setState(
                  () {
                    _lactosefreefilterset = changed;
                  },
                );
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free neals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
             SwitchListTile(
              value: _vegetarianfilterset,
              onChanged: (changed) {
                setState(
                  () {
                    _vegetarianfilterset = changed;
                  },
                );
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegetarian neals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
             SwitchListTile(
              value: _veganfilterset,
              onChanged: (changed) {
                setState(
                  () {
                    _veganfilterset = changed;
                  },
                );
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              subtitle: Text(
                'Only include vegan neals',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
