import 'package:emart_app/consts/consts.dart';

Widget loadingIncicatior(){
  return const CircularProgressIndicator(
    valueColor: AlwaysStoppedAnimation(redColor),
  );
}