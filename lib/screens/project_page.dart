
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/shared/cubit/cubit.dart';
import 'package:newavenue/shared/cubit/model.dart';
import 'package:newavenue/shared/cubit/states.dart';
import '../shared/shared_colors.dart';

class ProjectPage extends StatelessWidget {
  ProjectModel model;

  ProjectPage(this.model,{Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height =MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,states){},
      builder: (context ,states){
        AppCubit cubit=AppCubit.get(context);
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Shared.appBackGroundColor,
        ),
        body: ListView(
          scrollDirection: Axis.vertical,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                    Radius.circular(15))
              ),
              child: Image.network(

                "${model.projectImageUrl}",

                height: height/3,
                fit: BoxFit.fill,
                errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace ?stackTrace) {
                  return Image.asset(
                    cubit.defaultImageUrl,
                    width: width-20,
                    height: height/3,
                    fit: BoxFit.fill,);
                },
                width: width-20,
                loadingBuilder:
                    (BuildContext context,
                    Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null ?
                      loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!.toDouble()
                          : null,
                    ),
                  );
                },
              ),
            ),

            customListTile("Project Name: ", model.projectName),
            customListTile("Mixed Use: ", model.mixedUse),
            customListTile("Developer Name: ", model.developerName),
            customListTile("Location: ", model.location),
            customListTile("The Address: ", model.theAddress),
            customListTile("Ground Floor (Y/N) :", model.groundFloor),
            customListTile("Upper| First (Y/N) :", model.upperFirst),
            customListTile("Typical floor(Y/N): ", model.typicalFloor),
            customListTile("Min Spaces / M: ", model.minSpaces),
            customListTile("Max Spaces / M: ", model.maxSpaces),
            customListTile("Outdoor / M: ", model.outDoor),
            customListTile("Min Price per meter: ", model.minPrice),
            customListTile("Average Price Per Meter: ", model.averagePrice),
            customListTile("Max Price per Meter: ", model.maxPrice),
            customListTile("Min Total Price : ", model.minTotal),
            customListTile("Min Installment / Month: ", model.investment),
            customListTile("Payment plan: ", model.paymentPlan),
            customListTile("Delivery date: ", model.deliveryDate),
            customListTile("Delivery Percentage: ", model.deliveryPercentage),
            customListTile("Net / Gross: ", model.netGross),
            customListTile("Maintnance: ", model.maintanance),
            customListTile("Agent name: ", model.agentName),
            Container(
              height: 70,
              child: TextButton(
                onPressed: () {
                  cubit.launchFromUrl(model.projectDriveUrl!,context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                         Text(
                           "Open in Drive",
                            style: Shared.mainTextStyleF20,
                              ),
                    const SizedBox(width: 15,)
                    ,Image.asset("assets/drive.png",
                      width: 40,
                      height: 40,
                    ),

                  ],
                ),

                style: TextButton.styleFrom(
                  backgroundColor: Shared.appBackGroundColor,
                ),
              ),
            )
          ],
        ),
      );
    }, );
  }
}

Widget customListTile(String leading,String ? trailing){
  return Container(
    decoration: BoxDecoration(
      border: BorderDirectional(
          top:BorderSide(
              color: Shared.mainBorderColor,
              width: 2
          ),
          bottom: BorderSide(
              color: Shared.mainBorderColor,
              width: 1)
      )
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children:  [
        Text(leading,
          style: Shared.mainTextStyleF20,
        ),
        Flexible(child: Container(
          alignment: Alignment.centerRight,
          child:Text(
            "$trailing",
            style: Shared.mainTextStyleF20,
            textWidthBasis: TextWidthBasis.longestLine,) ,
        )
        )

      ],
    ),

  );
}
