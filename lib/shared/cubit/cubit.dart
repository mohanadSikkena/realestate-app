
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gsheets/gsheets.dart';
import 'package:newavenue/shared/cubit/model.dart';
import 'package:newavenue/shared/cubit/states.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());
  static AppCubit get(context)=>BlocProvider.of(context);


  //put your spread sheet id here
  final String _spreadSheetId="";
  //put your google sheets api credentials here like this
  final String _credentials=r'''
{
  "type": "",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": ""
}
''';
  final FocusNode _focusNode=FocusNode();
  final String _na="N/A";
  final String _defaultImageUrl="assets/noImage.jpg";
  TextEditingController searchController = TextEditingController();
  List<ProjectModel>_allProjects=[];
  List<ProjectModel>_searchResult=[];
  bool _isSearching=false;
  bool _isGettingData=false;
  bool get isSearching=>_isSearching;
  bool get isGettingData=>_isGettingData;
  FocusNode get focusNode=>_focusNode;
  String get na=>_na;
  String get defaultImageUrl=>_defaultImageUrl;
  // final formatCurrency = NumberFormat.simpleCurrency();
  List<ProjectModel> get allProjects=>_allProjects;
  List<ProjectModel> get searchResult=>_searchResult;

  launchFromUrl(String url,context)async{
      if(await canLaunchUrlString(url)){
        await launchUrl(
            Uri.parse(url),
            mode:LaunchMode.inAppWebView
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
          content: Text("Failed to open in drive"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 3),

        ));
      }
  }
  String percentageCalculator(String input){
    String output="";
    if (input.isEmpty){
      return na;
    }else{
      try{
        output="${(double.parse(input)*100).toString()}%";
        return output;

      }on FormatException{
        return input;
      }

    }
  }
  String driveToImage(String driveImageUrl){
    try{
      int lastIndex=driveImageUrl.indexOf("/view?usp=sharing");
      String imageId=driveImageUrl.substring(32,lastIndex);
      String newUrl="https://drive.google.com/uc?export=view&id=$imageId";
      return newUrl;
    }catch(e){
      return defaultImageUrl;
    }
  }
  String checkIfEmpty(String input){
    if(input.isEmpty){
      return na;
    }else{
      return input;
    }
  }
  void navigateTo(context,widget)=>Navigator.push(context,MaterialPageRoute(builder: (context)=>widget));
  void readSpreadSheet()async{
    _isGettingData=true;
    emit(GetExcelState());
    _allProjects=[];
    GSheets _gSheets=GSheets(_credentials);
    Spreadsheet spreadSheet=await _gSheets.spreadsheet(_spreadSheetId);
    var sheet=spreadSheet.worksheetById(0);
    List<List> allRows=await sheet!.values.allRows(fromRow: 2);
    allRows.forEach((project) {
      int projectLenght=project.length;
      ProjectModel model=ProjectModel(
        id: checkIfEmpty(project[0]),
        projectName: checkIfEmpty(project[1]),
        mixedUse: projectLenght<3?na:checkIfEmpty(project[2]),
        developerName: projectLenght<4?na:checkIfEmpty(project[3]),
        location: projectLenght<5?na:checkIfEmpty(project[4]),
        theAddress: projectLenght<6?na:checkIfEmpty(project[5]),
        groundFloor: projectLenght<7?na:checkIfEmpty(project[6]),
        upperFirst: projectLenght<8?na:checkIfEmpty(project[7]),
        typicalFloor: projectLenght<9?na:checkIfEmpty(project[8]),
        minSpaces: projectLenght<10?na:checkIfEmpty(project[9]),
        maxSpaces: projectLenght<11?na:checkIfEmpty(project[10]),
        outDoor: projectLenght<12?na:checkIfEmpty(project[11]),
        minPrice: projectLenght<13?na:checkIfEmpty(project[12]),
        averagePrice: projectLenght<14?na:checkIfEmpty(project[13]),
        maxPrice: projectLenght<15?na:checkIfEmpty(project[14]),
        minTotal: projectLenght<16?na:checkIfEmpty(project[15]),
        investment: projectLenght<17?na:checkIfEmpty(project[16]),
        paymentPlan: projectLenght<18?na:checkIfEmpty(project[17]),
        deliveryDate: projectLenght<19?na:checkIfEmpty(project[18]),
        deliveryPercentage: percentageCalculator(project[19]),
        netGross: percentageCalculator(project[20]),
        maintanance: percentageCalculator(project[21]),
        agentName:projectLenght<23?na:checkIfEmpty(project[22]),
        projectDriveUrl:projectLenght<25?na:checkIfEmpty(project[24]),
        projectImageUrl: projectLenght<26
            ?defaultImageUrl
            :project[25].isEmpty
            ?defaultImageUrl
            :driveToImage(project[25]),
      );
      _allProjects.add(model);
      _isGettingData=false;
      emit(GetExcelState());

    });
  }
  void searchByName(String searchWord){
    if(searchWord.isNotEmpty){
      _searchResult=_allProjects.where((element){
        if(
        element.projectName!=null
            &&element.projectName!.toLowerCase().contains(
            searchWord.toLowerCase()
        )){
          return true;
        }else{
          return false;
        }
      } ).toList();
    }else{
      _searchResult=_allProjects;
    }emit(SearchState());


    }
  void onTapFunction(){

    if(searchController.text.isEmpty){
      _searchResult=_allProjects;
    }
    _isSearching=true;
    emit(FirstSearchState());
  }
  void onSubmitFunction(){
  }
  void closeSearch(TextEditingController controller){
    _focusNode.unfocus();
    _isSearching=false;
    controller.clear();

    _focusNode.unfocus();
    emit(SecondSearchState());

  }

}