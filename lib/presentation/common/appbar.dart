import 'package:flutter/material.dart';
import 'package:spark/utils/constants/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  const CustomAppBar({super.key, required this.backgroundColor, required this.title});
  final Color backgroundColor;
  final String title;
  @override
  Widget build(BuildContext context){
    return AppBar(
      centerTitle: true,
      title: Text(title, style:Theme.of(context).textTheme.titleMedium!.copyWith(color: AppColors.blackColor,) ,),
      leading: IconButton(onPressed: ()=> Navigator.pop(context),
      icon: const Icon(Icons.arrow_back_ios_new),
      ),
      backgroundColor: backgroundColor,
      elevation: 0,
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
}