
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/screens/project_page.dart';
import 'package:newavenue/shared/cubit/cubit.dart';
import 'package:newavenue/shared/cubit/model.dart';
import 'package:newavenue/shared/cubit/states.dart';
import 'package:newavenue/shared/shared_colors.dart';
class PropertyWidget extends StatelessWidget {
  ProjectModel model;
  PropertyWidget(this.model, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height/100*50;
    double width=MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit,AppStates>(
        listener: (context,states){},
        builder: (context,states){
          AppCubit cubit=AppCubit.get(context);
          return InkWell(
            onTap: (){
              cubit.navigateTo(context, ProjectPage(model));
            },
            child: Container(
              padding: const EdgeInsets.only(top: 10,right: 10,left: 10),
              height: height,
              color: Shared.containerBackGroundColor,
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Shared.mainBorderColor,width: 2),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                  Image.network(
                    "${model.projectImageUrl}",
                    height: (height-15)/100*58,fit:
                    BoxFit.fill,
                    errorBuilder: (BuildContext context, ex, StackTrace ?stackTrace) {
                      return Image.asset(
                          cubit.defaultImageUrl,
                        width: width-20,
                        height: (height-15)/100*58,
                        fit: BoxFit.fill,);
                    },
                  width: width-20,
                  loadingBuilder:(
                      BuildContext context,
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
                    Container(
                      width: width,

                      height: (height-15)/100*40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\t\t${model.developerName}",
                            style: Shared.thirdTextStyleF16,
                          ),
                          Text(
                            "\t${
                                model.projectName}",
                            style: Shared.mainTextStyleF20,
                          ),
                          Text(
                            "\t\t${model.location} ",
                            style: Shared.thirdTextStyleF16,
                          ),
                          Row(
                            children: [
                              Container(
                                height: 20,
                                width: width-30,
                              )
                            ],
                          ),
                          Container(
                            height: 49,
                            decoration:
                            BoxDecoration(
                              border:
                              BorderDirectional(
                                  top:
                                  BorderSide(
                                      color: Shared.mainBorderColor,
                                      width: 2)
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\t\tAverage Price",
                                  style:Shared.thirdTextStyleF18 ,),
                                Text(
                                  "\t\t${model.averagePrice}",
                                  style:Shared.thirdTextStyleF18 ,
                                )
                              ],
                            ),
                          )

                        ],
                      ),
                    )

                  ],
                )
                ,
              ),
            ),
          );
        }, );
  }
}

