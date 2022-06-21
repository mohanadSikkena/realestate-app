import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newavenue/shared/cubit/cubit.dart';
import 'package:newavenue/shared/cubit/states.dart';
import 'package:newavenue/shared/shared_colors.dart';
import 'package:newavenue/widgets/property_widget.dart';

class HomePage extends StatelessWidget {
  GlobalKey<FormState> searchKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return BlocConsumer<AppCubit,AppStates>
      (
        listener: (context,AppStates states){},
        builder: (context,AppStates states){
          AppCubit cubit=AppCubit.get(context);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize:Size(width,height/12) ,
              child: Container(
                  margin: const EdgeInsets.only(top: 15,right: 10,left: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10)
                  ),

                  child: TextFormField(
                    focusNode: cubit.focusNode,
                    onTap: (){
                      cubit.onTapFunction();
                    },
                    onChanged: (string){
                      cubit.searchByName(string);
                    },
                    onFieldSubmitted: (ss){
                      cubit.onSubmitFunction();
                    },
                    controller: cubit.searchController,
                    key: key,
                    cursorColor: Shared.mainFontColor,
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: Shared.primaryIconColor,
                        ),
                        suffixIcon: cubit.isSearching?
                        IconButton(
                            onPressed: (){
                              cubit.closeSearch(cubit.searchController);
                              },
                            icon: Icon(
                              Icons.clear,
                              color: Shared.primaryIconColor,)
                        )
                            :null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        labelText: 'Enter Project name',
                        labelStyle:
                        TextStyle(
                            color: Shared.primaryIconColor,
                            fontWeight: FontWeight.bold)
                    ),
                  ),
              ),
            ),
            body: RefreshIndicator(
              onRefresh: ()async{
                 cubit.readSpreadSheet();
              },
              child:
              cubit.isGettingData ?
              const Center(child: CircularProgressIndicator()
              ) :
              ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "\n\t\t\t\t\t${
                              cubit.isSearching
                                  ?cubit.searchResult.length
                                  :cubit.allProjects.length} properties Found ",
                          style:
                          Shared.mainTextStyleF18
                      ),
                      Text(
                        "\nFilter\t\t\t\t",
                        style: Shared.secondTextStyleF20,
                      )
                    ],

                  ),
                  ListView.builder(
                      itemCount: cubit.isSearching
                          ?cubit.searchResult.length
                          :cubit.allProjects.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder:(context,i){
                        return PropertyWidget(
                            cubit.isSearching
                                ?cubit.searchResult[i]
                                :cubit.allProjects[i]
                        );

                      } ),







                ],
              ),
            ),
          );
        }


    );
  }
}