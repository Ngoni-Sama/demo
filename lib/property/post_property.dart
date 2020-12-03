import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:solo_property_app/property/property_listing.dart';
import '../models/model_propertysell.dart';
import '../utils/solo_theme.dart';
import '../utils/method_utils.dart';
import '../utils/network_utils.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';

class PropertySell extends StatefulWidget {
  final PropertySellModel sellModel;
  static const routeName = "/property-sell";

  PropertySell({this.sellModel, this.sellCategory, this.itemToPost});
  final sellCategory;
  final itemToPost;
  @override
  _PropertySellState createState() => _PropertySellState();
}

class _PropertySellState extends State<PropertySell> {
  static int currentPage = 0;
  PageController pageController =
      PageController(viewportFraction: 1, initialPage: currentPage);

  dynamic vehicleModel;
  dynamic vehicleMileage;
  dynamic vehicleTransmission;
  dynamic fuelType;
  dynamic year;
  dynamic colour;
  dynamic licensePlate;
  dynamic problems;
  dynamic landPricePerSqrMeter;
  dynamic landSize;
  DateTime boostExpiryDate;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController regionController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();
  TextEditingController contactController = TextEditingController();
  TextEditingController bedroomController = TextEditingController();
  TextEditingController bathroomController = TextEditingController();
  TextEditingController numberOfRooms = TextEditingController();
  TextEditingController sizeController = TextEditingController();

  int selected = 0;
  List<String> _imageFilesList = [];
  var isUploadingPost = false;
  var isEditInitialised = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (widget.sellModel != null) {
      if (isEditInitialised) {
        addressController.text = widget.sellModel.sellAddress;
        cityController.text = widget.sellModel.sellCity;
        regionController.text = widget.sellModel.sellRegion;
        countryController.text = widget.sellModel.sellCountry;
        priceController.text = widget.sellModel.sellPrice;
        bedroomController.text = widget.sellModel.sellBedrooms;
        bathroomController.text = widget.sellModel.sellBathrooms;
        descriptionController.text = widget.sellModel.sellDescription;
        contactController.text = widget.sellModel.sellContact;

        numberOfRooms.text = widget.sellModel.sellRooms;

        if (widget.sellModel.sellImages != null &&
            widget.sellModel.sellImages.length > 0) {
          _imageFilesList = widget.sellModel.sellImages;

          print("_imageFilesList : ${_imageFilesList.length}");
          print("_imageFilesList : ${_imageFilesList}");
        }

        isEditInitialised = false;
      }
    }

    super.didChangeDependencies();
  }

  _getLocation() async {
    try {
      print("GEOLOCATION GET ");

      Geolocator geolocator = Geolocator();

      Position currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
          currentLocation.latitude, currentLocation.longitude);

      if (currentLocation != null) {
        print("country : ${placemark[0].country}");
        print("position : ${placemark[0].position}");
        print("locality : ${placemark[0].locality}");
        print("administrativeArea : ${placemark[0].administrativeArea}");
        print("postalCode : ${placemark[0].postalCode}");
        print("name : ${placemark[0].name}");
        print("subAdministrativeArea : ${placemark[0].subAdministrativeArea}");
        print("isoCountryCode : ${placemark[0].isoCountryCode}");
        print("subLocality : ${placemark[0].subLocality}");
        print("subThoroughfare : ${placemark[0].subThoroughfare}");
        print("thoroughfare : ${placemark[0].thoroughfare}");

        if (placemark[0] != null) {
          if (placemark[0].country.isNotEmpty) {
            countryController.text = placemark[0].country;
          }

          if (placemark[0].administrativeArea.isNotEmpty) {
            regionController.text = placemark[0].administrativeArea;
          }

          if (placemark[0].subAdministrativeArea.isNotEmpty) {
            cityController.text = placemark[0].subAdministrativeArea;
          }

          if (placemark[0].name.isNotEmpty) {
            addressController.text = placemark[0].name;
          }

          setState(() {});
        }
      }
    } on PlatformException catch (error) {
      print(error.message);
    } catch (error) {
      print("Error: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: navyTheme,
        titleSpacing: 0,
        title: Text(
            "Property Details -> ${widget.itemToPost}"), //${widget.sellCategory}"
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
          color: navyTheme.withOpacity(0.2),
          image: new DecorationImage(
            image: new AssetImage('assets/images/bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _buildLabel("PROPERTY PHOTOS"),
                      _buildPropertyPhotosWidget(),
                      _buildLabel("PROPERTY ADDRESS"),
                      _buildPropertyLocationWidget(),
                      _buildLabel("PRICE"),
                      _buildPriceWidget(),
                      _buildLabel("PROPERTY DETAILS"),
                      _buildPropertyDetailsWidget(),
                      _buildLabel("CONTACT DETAILS"),
                      _buildContactDetailsWidget(),
                      _buildLabel("OTHER DETAILS"),
                      _buildOtherDetailsWidget(),
                    ],
                  ),
                ),
              ),
            ),
            _buildSubmitPostWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      child: Text(
        label,
        style: GoogleFonts.oswald(
          fontSize: 12,
          color: textLabelColor,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildPropertyPhotosWidget() {
    return Container(
      color: Colors.white,
      height: 120.0,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 10.0),
            child: Column(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    _openImagePicker(context);
                  },
                  icon: Icon(Icons.camera_enhance),
                  color: navyTheme,
                  iconSize: 65.0,
                ),
                Text(
                  "Add Photos",
                  style: GoogleFonts.oswald(
                    fontSize: 13,
                    color: textLabelColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: ListView.builder(
                itemCount: _imageFilesList.length,
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Container(
                      margin: EdgeInsets.only(right: 10.0),
                      height: 80.0,
                      width: 80.0,
                      child: Stack(
                        children: <Widget>[
                          ClipOval(
                            child: _imageFilesList[index] != null &&
                                    _imageFilesList[index].isNotEmpty
                                ? checkForFileOrNetworkPath(
                                        _imageFilesList[index])
                                    ? fetchImageFromNetworkFileWithPlaceHolderWidthHeight(
                                        80.0, 80.0, _imageFilesList[index])
                                    /*Image.network(
                                        _imageFilesList[index],
                                        fit: BoxFit.cover,
                                        height: 80.0,
                                        width: 80.0,
                                      )*/
                                    : Image.file(
                                        File(_imageFilesList[index]),
                                        fit: BoxFit.cover,
                                        height: 80.0,
                                        width: 80.0,
                                      )
                                : Image.asset(
                                    "assets/images/transparent_placeholder.png",
                                    fit: BoxFit.cover,
                                    height: 80.0,
                                    width: 80.0,
                                  ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _imageFilesList.removeAt(index);
                              });
                            },
                            child: Container(
                              alignment: Alignment.topRight,
                              child: Image.asset(
                                "assets/images/cancel.png",
                                fit: BoxFit.fitHeight,
                                height: 20.0,
                                width: 20.0,
                                color: navyTheme,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 150.0,
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(
                    "Select Image",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                      color: themeColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                GestureDetector(
                  onTap: () {
                    _getImage(context, ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.photo_camera,
                        size: 30.0,
                        color: themeColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                      ),
                      Text(
                        "Use Camera",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: themeColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6.0,
                ),
                GestureDetector(
                  onTap: () {
                    _getImage(context, ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.camera,
                        size: 30.0,
                        color: themeColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.0,
                        ),
                      ),
                      Text(
                        "Use Gallery",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: themeColor,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  _getImage(BuildContext context, ImageSource source) async {
    ImagePicker.pickImage(
      source: source,
      maxWidth: 400.0,
      maxHeight: 400.0,
    ).then((File image) async {
      if (image != null) {
        setState(() {
          _imageFilesList.add(image.path);
          print("_imageFile : $image");
          print("filePath : ${image.path}");
          print("fileURI : ${image.uri}");
          /*String filePath = image.path;
          Uri fileURI = image.uri;*/
        });
      }
    });
  }

  Widget _buildPropertyLocationWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              _getLocation();
            },
            child: Container(
              height: 50.0,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 10.0),
                    child: Icon(
                      Icons.my_location,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 20.0),
                    child: Text("Detect Property Location",
                        style: simpleTextStyle()),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: TextFormField(
              controller: addressController,
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Address"),
              validator: (String address) {
                if (address.isEmpty) {
                  return "Address field is required!!";
                }
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: TextFormField(
              controller: cityController,
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("City"),
              validator: (String city) {
                if (city.isEmpty) {
                  return "City field is required!!";
                }
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: TextFormField(
              controller: regionController,
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Region (Optional)"),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            child: TextFormField(
              validator: (String country) {
                if (country.isEmpty) {
                  return "Country field is required!!";
                }
              },
              controller: countryController,
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Country"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (String price) {
            if (price.isEmpty) {
              return "Price field is required!!";
            }
          },
          keyboardType: TextInputType.number,
          controller: priceController,
          style: simpleTextStyle(),
          decoration: textFieldInputDecoration("Price"),
        ),
      ),
    );
  }

  Widget _buildPropertyDetailsWidget() {
    Widget widgetToDisplay;
    if (widget.itemToPost == 1) {
      widgetToDisplay = _buildVehicleDetailsWidget();
    } else if (widget.itemToPost == 2) {
      widgetToDisplay = _buildVehicleDetailsWidget();
    } else if (widget.itemToPost == 3) {
      widgetToDisplay = _buildVehicleDetailsWidget();
    } else if (widget.itemToPost == 11) {
      widgetToDisplay = _buildlandSizeWidget();
    } else if (widget.itemToPost == 12) {
      widgetToDisplay = _buildlandSizeWidget();
    } else if (widget.itemToPost == 13) {
      widgetToDisplay = _buildlandSizeWidget();
    } else {
      widgetToDisplay = Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        margin: EdgeInsets.only(top: 10.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: TextFormField(
                validator: (String bedrooms) {
                  if (bedrooms.isEmpty) {
                    return "Rooms field is required!!";
                  }
                },
                controller: numberOfRooms,
                keyboardType: TextInputType.number,
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration("Room(s)"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: TextFormField(
                validator: (String bedrooms) {
                  if (bedrooms.isEmpty) {
                    return "Bedroom field is required!!";
                  }
                },
                controller: bedroomController,
                keyboardType: TextInputType.number,
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration("Bedroom(s)"),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              child: TextFormField(
                controller: bathroomController,
                keyboardType: TextInputType.number,
                style: simpleTextStyle(),
                decoration: textFieldInputDecoration("Bathroom(s)"),
              ),
            ),
          ],
        ),
      );
    }
    return widgetToDisplay;
  }

  Widget _buildContactDetailsWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          validator: (String contact) {
            if (contact.isEmpty) {
              return "Contact field is required!!";
            }
          },
          keyboardType: TextInputType.number,
          maxLength: 10,
          controller: contactController,
          style: simpleTextStyle(),
          decoration: textFieldInputDecoration("Contact"),
        ),
      ),
    );
  }

  Widget _buildOtherDetailsWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: TextFormField(
          controller: descriptionController,
          style: simpleTextStyle(),
          decoration:
              textFieldInputDecoration("Additional Property Description"),
        ),
      ),
    );
  }

  Widget _buildlandSizeWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              validator: (String size) {
                if (size.isEmpty) {
                  return "Size of land required!!";
                }
              },
              keyboardType: TextInputType.number,
              maxLength: 7,
              onSaved: (value) {
                landSize = value;
              },
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Size of Land /sqr meters"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              validator: (String size) {
                if (size.isEmpty) {
                  return "Price per sqr meter required";
                }
              },
              keyboardType: TextInputType.number,
              maxLength: 4,
              onSaved: (value) {
                landPricePerSqrMeter = value;
              },
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Price per sqr meter"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleDetailsWidget() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              validator: (String model) {
                if (model.isEmpty) {
                  return "Car Model is required!!";
                }
              },
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Model"),
              onSaved: (value) {
                vehicleModel = value;
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TextFormField(
              validator: (String year) {
                if (year.isEmpty) {
                  return "Year is required!!";
                }
              },
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Year"),
              onSaved: (value) {
                year = value;
              },
              keyboardType: TextInputType.number,
              maxLength: 4,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              validator: (String fuelType) {
                if (fuelType.isEmpty) {
                  return "Fuel type is required!!";
                }
              },
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Fuel Type"),
              onSaved: (value) {
                fuelType = value;
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TextFormField(
              validator: (String color) {
                if (color.isEmpty) {
                  return "Color is required!!";
                }
              },
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Colour"),
              onSaved: (value) {
                colour = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              validator: (String plate) {
                if (plate.isEmpty) {
                  return "License plate is required!!";
                }
              },
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("License Plate"),
              onSaved: (value) {
                licensePlate = value;
              },
              keyboardType: TextInputType.number,
              maxLength: 10,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TextFormField(
              validator: (String mileage) {
                if (mileage.isEmpty) {
                  return "Transmission is required!!";
                }
              },
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Transmission"),
              onSaved: (value) {
                vehicleTransmission = value;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: TextFormField(
              validator: (String mileage) {
                if (mileage.isEmpty) {
                  return "Mileage is required!!";
                }
              },
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Mileage"),
              onSaved: (value) {
                vehicleMileage = value;
              },
              keyboardType: TextInputType.number,
              maxLength: 6,
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            child: TextFormField(
              style: simpleTextStyle(),
              decoration: textFieldInputDecoration("Problems"),
              onSaved: (value) {
                problems = value;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitPostWidget() {
    return GestureDetector(
      onTap: () {
        if (isUploadingPost == false || _formKey.currentState.validate()) {
          _formKey.currentState.save(); //onSaved is called!
          _submitPropertySellPost();
        }
      },
      child: Container(
        color: navyTheme,
        padding: const EdgeInsets.only(top: 10.0),
        margin: EdgeInsets.only(top: 10.0),
        width: double.infinity,
        height: 50.0,
        child: Center(
          child: Text(
            isUploadingPost ? "Uploading..." : "Submit Post",
            style: whiteBiggerTextStyle(),
          ),
        ),
      ),
    );
  }

  _submitPropertySellPost() async {
    setState(() {
      selected = widget.itemToPost;
    });
    if (selected == 0) {
      final snackBar = SnackBar(content: Text("Select property type!!"));

      _scaffoldKey.currentState.showSnackBar(snackBar);
      return;
    }

    if (!_formKey.currentState.validate()) {
      return;
    }

    NetworkCheck networkCheck = NetworkCheck();
    networkCheck.checkInternet((isNetworkPresent) async {
      if (!isNetworkPresent) {
        setState(() {
          isUploadingPost = false;
        });
        final snackBar =
            SnackBar(content: Text("Please check your internet connection !!"));

        _scaffoldKey.currentState.showSnackBar(snackBar);
        return;
      } else {
        setState(() {
          isUploadingPost = true;
        });
      }
    });

    try {
      List<String> imagePaths = [];
      try {
        if (_imageFilesList != null && _imageFilesList.length > 0) {
          imagePaths = await uploadImage(_imageFilesList);
          print("imagePaths : $imagePaths");
          print("imagePaths : ${imagePaths.length}");
        }
      } catch (error) {
        print("uploadError : ${error.toString()}");
      }

      // final propertySellReference =
      //     FirebaseDatabase.instance.reference().child("Sell");

      final Firestore myDatabase = Firestore.instance;
      print("_imageFilesList : ${_imageFilesList.length}");
      print("imagePaths : ${imagePaths.length}");

      localStorage = await SharedPreferences.getInstance();
      print(
          "Email Id: ${localStorage.get('email')}  Password: ${localStorage.get('password')}");
      Geolocator geolocator = Geolocator();

      Position currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);

      final Geoflutterfire geo = Geoflutterfire();

      GeoFirePoint userLocation = geo.point(
          latitude: currentLocation.latitude,
          longitude: currentLocation.longitude);

      if (widget.sellModel == null || widget.sellModel.id == null) {
        if (widget.itemToPost == 1 ||
            widget.itemToPost == 2 ||
            widget.itemToPost == 3) {
          print("VEHICLE DATA UPLOAD BEGINS ");
          await myDatabase.collection('listings').add({
            "sellerId": localStorage.get('email'),
            "sellType": widget.itemToPost,
            "sellImages":
                imagePaths != null && imagePaths.length > 0 ? imagePaths : "",
            "sellAddress": addressController.text,
            "sellCity": cityController.text,
            "sellRegion": regionController.text,
            "sellCountry": countryController.text,
            "sellPrice": priceController.text,
            "sellGeolocation": userLocation.data,
            "sellContact": contactController.text,
            "sellDescription": descriptionController.text,
            "updatedAt": DateTime.now().toIso8601String(),
            "vehicleModel": vehicleModel,
            "vehicleMileage": vehicleMileage,
            "vehicleTransmission": vehicleTransmission,
            "fuelType": fuelType,
            "year": year,
            "VehicleColour": colour,
            "licensePlate": licensePlate,
            "vehicleProblems": problems,
            "boost": false
          });
        } else if (widget.itemToPost == 11 ||
            widget.itemToPost == 12 ||
            widget.itemToPost == 13) {
          print("LAND DATA UPLOAD BEGINS ");
          await myDatabase.collection('listings').add({
            "sellerId": localStorage.get('email'),
            "sellType": widget.itemToPost,
            "sellImages":
                imagePaths != null && imagePaths.length > 0 ? imagePaths : "",
            "sellAddress": addressController.text,
            "sellCity": cityController.text,
            "sellRegion": regionController.text,
            "sellCountry": countryController.text,
            "sellPrice": priceController.text,
            "pricePerSquareMeter": landPricePerSqrMeter,
            "landSize": landSize,
            "sellGeolocation": userLocation.data,
            "sellContact": contactController.text,
            "sellDescription": descriptionController.text,
            "updatedAt": DateTime.now().toIso8601String(),
            "boost": false
          });
        } else {
          print("ACCOMODATION DATA UPLOAD BEGINS ");

          await myDatabase.collection('listings').add({
            "sellerId": localStorage.get('email'),
            "sellType": widget.itemToPost,
            "sellImages":
                imagePaths != null && imagePaths.length > 0 ? imagePaths : "",
            "sellAddress": addressController.text,
            "sellCity": cityController.text,
            "sellRegion": regionController.text,
            "sellCountry": countryController.text,
            "sellPrice": priceController.text,
            "sellBathrooms": bathroomController.text,
            "sellBedrooms": bedroomController.text,
            "sellGeolocation": userLocation.data,
            "sellContact": contactController.text,
            "sellDescription": descriptionController.text,
            "updatedAt": DateTime.now().toIso8601String(),
            "boost": false,
            "boostExpiry": boostExpiryDate
          });
        }
      }
      print("DATA UPLOAD DONE ");

      setState(() {
        isUploadingPost = false;
      });

      if (isUploadingPost == false) {
        showDialog(
          context: context,
          child: new AlertDialog(
            // title: new Text("Property Posted", style: biggerTextStyle()),
            //content: new Text("Hello World"),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  Icon(
                    Icons.check,
                    color: navyTheme,
                    size: 80.0,
                  ),
                  Center(
                      child: new Text("Property Posted",
                          style: simpleTextStyle())),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                children: [
                  // new FlatButton(
                  //   child: new Text('Edit'),
                  //   onPressed: () {
                  //     Navigator.of(context).pop();
                  //   },
                  // ),
                  new FlatButton(
                    child: new Text(
                      'Continue',
                      style: simpleTextStyle(),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   CupertinoPageRoute(
                      //       builder: (context) => PostingOptions()),
                      // );
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => PropertyListing()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      }

      // Navigator.push(
      //   context,
      //   CupertinoPageRoute(builder: (context) => PropertyListing()),
      // );
    } catch (error) {
      print("catch block : " + error.toString());

      setState(() {
        isUploadingPost = false;
      });
      final snackBar = SnackBar(
          content: Text(" $error Something went wrong. please try again !!"));
      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }

  Future<List<String>> uploadImage(List<String> imageFiles) async {
    List<String> filePaths = [];

    print("filePaths : ${filePaths}");
    for (int i = 0; i < imageFiles.length; i++) {
      if (checkForFileOrNetworkPath(imageFiles[i])) {
        filePaths.add(imageFiles[i]);
        continue;
      }
      StorageReference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("images/sell/${DateTime.now().toIso8601String()}");

      StorageUploadTask uploadTask =
          firebaseStorageRef.putFile(File(imageFiles[i]));
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
      String storagePath = await taskSnapshot.ref.getDownloadURL();
      filePaths.add(storagePath);
    }

    print("filePaths : ${filePaths}");
    return filePaths;
  }
}

/*CachedNetworkImage(
imageUrl: _imageFilesList.length == 0
? "file:///storage/emulated/0/Android/data/com.jaym.flutter_property_app/files/Pictures/scaled_Screenshot_20190927-114712.png"
    : "http://via.placeholder.com/200x150",
placeholder: (context, url) => CircularProgressIndicator(),
errorWidget: (context, url, error) => Icon(Icons.error),
imageBuilder: (context, imageProvider) => Container(
decoration: BoxDecoration(
image: DecorationImage(
image: imageProvider,
fit: BoxFit.cover,
colorFilter:
ColorFilter.mode(Colors.red, BlendMode.colorBurn)),
),
),
),*/
