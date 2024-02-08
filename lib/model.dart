class RecipeModel{
  late String appLabel;
  late String appImageUrl;
  late double appCalories;
  late String appUrl;

  //Default constructor:
  RecipeModel();

  //private constructor which is only visible in the class and library file:
  RecipeModel._internal({this.appLabel = "",this.appImageUrl = "",this.appCalories = 0.000,this.appUrl = ""});

  // factory constructor to return the instances of the class:
  factory RecipeModel.fromMap(Map recipe){
    return RecipeModel._internal(
      appLabel: recipe['label'],
      appImageUrl: recipe['image'],
      appCalories: recipe['calories'],
      appUrl: recipe['url']
    );
  }

  
}