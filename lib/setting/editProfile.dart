import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/Model/Vehicle.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/networking/Access.dart';

enum truckType { open, closed }

class edit_profile extends StatefulWidget {
  const edit_profile({Key key}) : super(key: key);

  @override
  _edit_profileState createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  var selectedVehicle = ConstanceData.vehicletype[0].vehicle.toString();
  var selectedVehicleIndex = 0;
  var selectedWeightIndex = 0;
  truckType current = truckType.open;

  AlertDialog alert;

  @override
  void initState() {
    if (mounted) {
      setState(() {
        print("before ${selectedVehicle}");
        selectedVehicle = getName(ConstanceData.prof.vehicle_id);
      });
      print("after ${selectedVehicle}");
    } else {
      selectedVehicle = getName(ConstanceData.prof.vehicle_id);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(
          left: 14,
          right: 14,
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Text(
                "Please select the desired vehicle type:",
                style: Theme.of(context).textTheme.headline6.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).dividerColor),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Icon(
                        Icons.car_rental,
                        color: Color(0xff0b0b0b),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: DropdownButton(
                          isExpanded: true,
                          value: selectedVehicle,
                          icon: Icon(Icons.keyboard_arrow_down),
                          items: ConstanceData.vehicletype.map((items) {
                            return DropdownMenuItem(
                              value: items.vehicle,
                              child: Text(
                                items.vehicle,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            );
                          }).toList(),
                          onChanged: (String value) {
                            setState(() {
                              selectedVehicle = value;
                              selectedVehicleIndex = getIndex(value);
                              selectedWeightIndex = selectedVehicleIndex;
                              print(
                                  'The value is ${value} and index ${selectedVehicleIndex} and weight ${ConstanceData.vehicletype[selectedVehicleIndex].loadcapacity}');
                            });
                          }),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(color: Theme.of(context).dividerColor),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Icon(
                        FontAwesomeIcons.weight,
                        color: Color(0xff0b0b0b),
                      ),
                    ),
                    Expanded(
                        flex: 5,
                        child: Text(
                            '${ConstanceData.vehicletype[selectedVehicleIndex].loadcapacity}')),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              setState(() {
                                current = value;
                              });
                            },
                            value: truckType.open,
                            groupValue: current,
                          ),
                          Image.asset(
                            'assets/images/truck_1.webp',
                            width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text('OPEN'),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Radio(
                            activeColor: Theme.of(context).primaryColor,
                            onChanged: (value) {
                              setState(() {
                                current = value;
                              });
                            },
                            value: truckType.closed,
                            groupValue: current,
                          ),
                          Image.asset(
                            'assets/images/truck_2.webp',
                            width: 50,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text('CLOSED'),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  showLoaderDialog(context);
                  // print("${getVehicleId(selectedVehicle)} ${selectedVehicle} ${getLoad(selectedVehicle)} ${getVehicleType(selectedVehicle)}");
                  Access()
                      .saveVehicle(vehicleModel1(
                          getVehicleId(selectedVehicle),
                          selectedVehicle,
                          getLoad(selectedVehicle),
                          getVehicleType(selectedVehicle)))
                      .then((value) => {
                            Access().getProfile().then((value) => {
                                  ConstanceData.prof = value,
                                  print("${value.name}"),
                                  Navigator.pop(context),
                                })
                          });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of('SAVE'),
                      style: Theme.of(context).textTheme.button.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).scaffoldBackgroundColor,
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
      // title: Text('Edit Profile'),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SizedBox(
              child: Icon(
                Icons.arrow_back_ios,
                color: Theme.of(context).textTheme.headline6.color,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => edit_profile(),
                ),
              );
            },
            child: Text(
              AppLocalizations.of('Edit Profile'),
              style: Theme.of(context).textTheme.headline6.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  String getName(vehicle_id) {
    for (var i in ConstanceData.vehicletype) {
      if (vehicle_id == i.vehicle_id) {
        print('${i.vehicle_id.toString()}:${i.vehicle.toString()}');
        return i.vehicle.toString();
      }
    }
  }

  int getIndex(String value) {
    for (int i = 0; i < ConstanceData.vehicletype.length; i++) {
      if (value == ConstanceData.vehicletype[i].vehicle) {
        print("returned ${i}");
        return i;
      }
    }
  }

  int getVehicleId(String selectedVehicle) {
    for (var i in ConstanceData.vehicletype) {
      if (selectedVehicle == i.vehicle.toString()) {
        return i.vehicle_id;
      }
    }
  }

  String getLoad(String selectedVehicle) {
    for (var i in ConstanceData.vehicletype) {
      if (selectedVehicle == i.vehicle.toString()) {
        return i.loadcapacity;
      }
    }
  }

  String getVehicleType(String selectedVehicle) {
    if (current == truckType.open) {
      return "OPEN";
    } else {
      return "CLOSED";
    }
  }

  showLoaderDialog(BuildContext context) {
    alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
