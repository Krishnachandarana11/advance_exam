import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/recipt_controller.dart';
import 'add_recipt_screen.dart';
import 'edit_recipt_screen.dart';
import 'liked_recipe_page.dart';

class HomePage extends StatelessWidget {
  final RecipeController recipeController = Get.put(RecipeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Light blue background
      appBar: AppBar(
        title: Text(
          'Recipes',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue[800], // Deep blue AppBar
        centerTitle: true,
        elevation: 3,
      ),
      body: Obx(() {
        if (recipeController.recipes.isEmpty) {
          return Center(
            child: Text(
              "No recipes found!",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.blueGrey),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: recipeController.recipes.length,
            itemBuilder: (context, index) {
              final recipe = recipeController.recipes[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                color: Colors.blue[100], // Light blue card background
                child: ListTile(
                  contentPadding: EdgeInsets.all(20),
                  title: Text(
                    recipe.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue[900]),
                  ),
                  subtitle: Text(
                    recipe.description,
                    style: TextStyle(color: Colors.blueGrey[700]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.blueAccent),
                        onPressed: () => recipeController.addToFavorites(recipe),
                      ),
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue[700]),
                        onPressed: () => Get.to(EditRecipeScreen(recipe: recipe)),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () => recipeController.deleteRecipe(recipe.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(AddRecipeScreen()),
        backgroundColor: Colors.blue[700], // Deep blue button
        child: Icon(Icons.add, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue[800], // Deep blue bottom bar
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () => Get.to(LikedRecipePage()),
          ),
        ),
      ),
    );
  }
}
