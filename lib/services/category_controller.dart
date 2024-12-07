import 'package:coursework1_partb_mad/Model/category_model.dart';

List<CategoryModel> getCategories(){

  List<CategoryModel> category = [];
  CategoryModel categoryModel = new CategoryModel();


  categoryModel.categoryName = "Business";
  categoryModel.image = "assets/images/business.jpg";
  category.add(categoryModel);

  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Entertainment";
  categoryModel.image = "assets/images/entertainment.jpg";
  category.add(categoryModel);


  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Health";
  categoryModel.image = "assets/images/health.jpeg";
  category.add(categoryModel);


  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Science";
  categoryModel.image = "assets/images/science.jpg";
  category.add(categoryModel);


  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Sports";
  categoryModel.image = "assets/images/sports.jpeg";
  category.add(categoryModel);


  categoryModel = new CategoryModel();
  categoryModel.categoryName = "Technology";
  categoryModel.image = "assets/images/technology.jpeg";
  category.add(categoryModel);

  return category;

}