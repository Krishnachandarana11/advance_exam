import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/recipt_controller.dart';

class LikedRecipePage extends StatelessWidget {
  final RecipeController recipeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Light blue background
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text(
          'Liked Recipes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800], // Deep blue AppBar
      ),
      body: Obx(() {
        if (recipeController.favoriteRecipes.isEmpty) {
          return Center(
            child: Text(
              "No favorite recipes!",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.blueGrey,
              ),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: recipeController.favoriteRecipes.length,
            itemBuilder: (context, index) {
              final recipe = recipeController.favoriteRecipes[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8),
                color: Colors.blue[100], // Light blue background for cards
                child: ListTile(
                  contentPadding: EdgeInsets.all(15),
                  title: Text(
                    recipe.name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900], // Dark blue text
                    ),
                  ),
                  subtitle: Text(
                    recipe.description,
                    style: TextStyle(color: Colors.blueGrey[700]), // Blue-grey subtitle
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      Get.defaultDialog(
                        title: "Remove from Favorites?",
                        middleText: "Are you sure you want to remove this recipe?",
                        textConfirm: "Yes",
                        textCancel: "No",
                        confirmTextColor: Colors.white,
                        buttonColor: Colors.redAccent,
                        onConfirm: () {
                          recipeController.removeFromFavorites(recipe.id!);
                          Get.back();
                        },
                      );
                    },
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
