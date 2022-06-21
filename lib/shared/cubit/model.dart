

class ProjectModel{
  String ?projectImageUrl;
  String ? projectDriveUrl;
  String ? projectName;
  String ? id;
  String ? mixedUse;
  String ? developerName;
  String ? location;
  String ? theAddress;
  String ? groundFloor;
  String ? upperFirst;
  String ? typicalFloor;
  String ? minSpaces;
  String ? maxSpaces;
  String ? outDoor;
  String ? minPrice;
  String ? averagePrice;
  String ? maxPrice;
  String ? minTotal;
  String ? investment;
  String ? paymentPlan;
  String ? deliveryDate;
  String ? deliveryPercentage;
  String ? netGross;
  String ? maintanance;
  String ? agentName;


  ProjectModel({
    required this.projectImageUrl,
    required this.projectDriveUrl,
    required this.agentName,
    required this.averagePrice,
    required this.deliveryDate,
    required this.deliveryPercentage,
    required this.developerName,
    required this.groundFloor,
    required this.id,
    required this.investment,
    required this.location,
    required this.maintanance,
    required this.maxPrice,
    required this.maxSpaces,
    required this.minPrice,
    required this.minSpaces,
    required this.minTotal,
    required this.mixedUse,
    required this.netGross,
    required this.outDoor,
    required this.paymentPlan,
    required this.projectName,
    required this.theAddress,
    required this.typicalFloor,
    required this.upperFirst,

  });
}