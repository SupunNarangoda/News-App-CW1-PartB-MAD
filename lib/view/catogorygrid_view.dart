import 'package:flutter/material.dart';
import 'package:coursework1_partb_mad/Model/category_model.dart';
import 'package:coursework1_partb_mad/view/category_view.dart';
import 'package:coursework1_partb_mad/controllers/category_controller.dart';

class CategoryGridPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<CategoryModel> categories = getCategories();

    return Scaffold(
      appBar: AppBar(title: const Text('Categories')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            CategoryModel category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryNewsPage(
                      categoryName: category.categoryName,
                    ),
                  ),
                );
              },
              child: GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black54,
                  title: Text(
                    category.categoryName,
                    textAlign: TextAlign.center,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(category.image),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
