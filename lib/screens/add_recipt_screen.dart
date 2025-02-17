import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/recipt_controller.dart';

class AddRecipeScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final RecipeController recipeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Light blue background
      appBar: AppBar(
        title: Text(
          "Add Recipe",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blue[800], // Deep blue AppBar
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              style: TextStyle(color: Colors.blue[900]), // Dark blue text
              decoration: InputDecoration(
                labelText: 'Recipe Name',
                labelStyle: TextStyle(color: Colors.blueGrey), // Blue-grey label
                filled: true,
                fillColor: Colors.blue[100], // Light blue input background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              style: TextStyle(color: Colors.blue[900]), // Dark blue text
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.blueGrey), // Blue-grey label
                filled: true,
                fillColor: Colors.blue[100], // Light blue input background
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Add the recipe
                recipeController.addRecipe(nameController.text, descriptionController.text);
                Get.back();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800], // Deep blue button
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12), // Rounded corners
                ),
              ),
              child: Text(
                'Add Recipe',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
