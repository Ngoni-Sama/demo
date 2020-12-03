class PropertySellModel {
  String id;
  int sellType;
  List<String> sellImages;
  String sellAddress;
  String sellCity;
  String sellRegion;
  String sellCountry;
  String sellPrice;
  String sellBathrooms;
  String sellBedrooms;
  String sellLocation;
  String sellDescription;
  String sellContact;
  String updatedAt;
  String sellRooms;

  PropertySellModel(
      {this.id,
      this.sellType,
      this.sellImages,
      this.sellAddress,
      this.sellCity,
      this.sellRegion,
      this.sellCountry,
      this.sellPrice,
      this.sellBathrooms,
      this.sellBedrooms,
      this.sellLocation,
      this.sellDescription,
      this.updatedAt,
      this.sellRooms});

  PropertySellModel.fromJson(var value) {
    this.id = value["id"];
    this.sellType = value["sellType"];
    this.sellAddress = value["sellAddress"];
    this.sellCity = value["sellCity"];
    this.sellRegion = value["sellRegion"];
    this.sellCountry = value["sellCountry"];
    this.sellPrice = value["sellPrice"];
    this.sellBathrooms = value["sellBathrooms"];
    this.sellBedrooms = value["sellBedrooms"];
    this.sellLocation = value["sellLocation"];
    this.sellDescription = value["sellDescription"];
    this.sellContact = value["sellContact"];
    this.updatedAt = value["updatedAt"];
    this.sellRooms = value["sellRooms"];

    this.sellImages = [];
    try {
      List<String> data = value["sellImages"].cast<String>();
      for (int i = 0; i < data.length; i++) {
        this.sellImages.add(data[i]);
      }
    } catch (error) {
      this.sellImages = [];
    }
  }
}

