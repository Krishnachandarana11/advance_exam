import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/recipe_model.dart';

class RecipeController extends GetxController {
  var recipes = <Recipe>[].obs;
  var favoriteRecipes = <Recipe>[].obs;
  Database? _database;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    _initDatabase().then((_) {
      fetchRecipes();
      fetchFavorites();
    });
  }

  Future<void> _initDatabase() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'recipes.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE recipes(id TEXT PRIMARY KEY, name TEXT, description TEXT)',
        );
      },
    );
  }

  Future<void> fetchRecipes() async {
    if (_database == null) await _initDatabase();
    final List<Map<String, dynamic>> maps = await _database!.query('recipes');
    recipes.value = maps.map((map) => Recipe.fromMap(map)).toList();
  }

  Future<void> addRecipe(String name, String description) async {
    if (_database == null) await _initDatabase();
    final recipe = Recipe(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        description: description);
    await _database!.insert('recipes', recipe.toMap());
    fetchRecipes();
  }

  Future<void> updateRecipe(String id, String name, String description) async {
    if (_database == null) await _initDatabase();
    await _database!.update(
      'recipes',
      {'name': name, 'description': description},
      where: 'id = ?',
      whereArgs: [id],
    );
    fetchRecipes();
  }

  Future<void> deleteRecipe(String id) async {
    if (_database == null) await _initDatabase();
    await _database!.delete('recipes', where: 'id = ?', whereArgs: [id]);
    fetchRecipes();
  }

  Future<void> addToFavorites(Recipe recipe) async {
    await firestore.collection('favorites').doc(recipe.id).set(recipe.toMap());
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    QuerySnapshot snapshot = await firestore.collection('favorites').get();
    favoriteRecipes.value = snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // Ensure id is included
      return Recipe.fromMap(data);
    }).toList();
  }

  Future<void> removeFromFavorites(String id) async {
    await firestore.collection('favorites').doc(id).delete();
    fetchFavorites();
  }
}
