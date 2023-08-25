import 'package:flutter_mdetect/flutter_mdetect.dart';
import 'package:rabbit_converter/rabbit_converter.dart';

class Myfont{
  
  static mmText(String text){
    return MDetect.isUnicode()? text: Rabbit.uni2zg(text);
  }
}
