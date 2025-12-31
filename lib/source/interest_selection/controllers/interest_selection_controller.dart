import 'package:get/get.dart';

class InterestSelectionController extends GetxController{

  final List<String> categories = ['Business', 'Entertainment', 'Health', 'Science', 'Sports',];

  final selectedIndex = Rx<int>(-1);
  final selectedCategory = Rx<String>('');

  void onSelection(int index){
    selectedIndex.value = index;
    selectedCategory.value = categories[selectedIndex.value];
  }

}