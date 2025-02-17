import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/recipt_controller.dart';
import '../models/recipe_model.dart';

class EditRecipeScreen extends StatelessWidget {
  final Recipe recipe;
  EditRecipeScreen({required this.recipe});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RecipeController recipeController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Initialize text fields with existing recipe data
    nameController.text = recipe.name;
    descriptionController.text = recipe.description;

    return Scaffold(
      backgroundColor: Colors.blue.shade50, // Light blue background
      appBar: AppBar(
        title: Text(
          "Edit Recipe",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue.shade800, // Deep blue AppBar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Recipe Name Field
            TextField(
              controller: nameController,
              style: TextStyle(color: Colors.blue.shade900), // Blue text color
              decoration: InputDecoration(
                labelText: 'Recipe Name',
                labelStyle: TextStyle(color: Colors.blueGrey.shade600), // Grey label
                filled: true,
                fillColor: Colors.blue.shade100, // Light blue input background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
            ),
            SizedBox(height: 20),

            // Recipe Description Field
            TextField(
              controller: descriptionController,
              maxLines: 4,
              style: TextStyle(color: Colors.blue.shade900),
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.blueGrey.shade600),
                filled: true,
                fillColor: Colors.blue.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              ),
            ),
            SizedBox(height: 30),

            // Update Button
            ElevatedButton(
              onPressed: () {
                recipeController.updateRecipe(
                  recipe.id!,
                  nameController.text,
                  descriptionController.text,
                );
                Get.back(); // Go back to the previous screen
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700, // Deep blue button
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 4,
                shadowColor: Colors.blue.withOpacity(0.3),
              ),
              child: Text(
                'Update Recipe',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
