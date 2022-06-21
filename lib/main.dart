import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/screens/home_page.dart';
import 'package:newavenue/shared/cubit/cubit.dart';
import 'package:newavenue/shared/cubit/states.dart';
import 'package:newavenue/shared/shared_colors.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create:(context)=>AppCubit()..readSpreadSheet(),)

        ],
        child: BlocConsumer<AppCubit,AppStates>(
          listener: (context,state){},
          builder: (context,state){
            return MaterialApp(

              home: HomePage(),
              theme: ThemeData(scaffoldBackgroundColor: Shared.appBackGroundColor),
            );
          },
        )
    );
  }
}

