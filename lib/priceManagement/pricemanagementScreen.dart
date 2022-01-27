import 'package:another_xlider/another_xlider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/constance/constance.dart';
import 'package:my_cab_driver/networking/Access.dart';

class VehicalManagement extends StatefulWidget {
  double _value = double.parse(ConstanceData.prof.min_rate.toString());

  @override
  _VehicalManagementState createState() => _VehicalManagementState();
}

class _VehicalManagementState extends State<VehicalManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 14),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4,
              margin: EdgeInsets.all(0),
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundColor: Theme.of(context).primaryColor,
                          radius: 30,
                          child: getPhoto(ConstanceData.prof.vehicle_id
                                      .toString()) ==
                                  null
                              ? Icon(
                                  FontAwesomeIcons.filePdf,
                                  color: ConstanceData.secoundryFontColor,
                                )
                              : Image.network(
                                  ConstanceData.image_url.toString() +
                                      getPhoto(ConstanceData.prof.vehicle_id
                                          .toString())),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          AppLocalizations.of(
                              '${getName(ConstanceData.prof.vehicle_id.toString())}'),
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontWeight: FontWeight.bold,
                                color:
                                    Theme.of(context).textTheme.headline6.color,
                              ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          '${ConstanceData.prof.load_capacity}',
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).disabledColor,
                              ),
                        ),
                      ],
                    ),
                    Expanded(child: SizedBox()),
                    Icon(
                      Icons.check_circle,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Minimum rate:',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).disabledColor,
                          )),
                  Text('${ConstanceData.prof.min_rate}',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0b0b0b),
                          )),
                  Text('Selected rate:',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).disabledColor,
                          )),
                  Text('${widget._value.toInt()}',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0b0b0b),
                          )),
                  Text('Maximum rate:',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).disabledColor,
                          )),
                  Text('${ConstanceData.prof.max_rate}',
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff0b0b0b),
                          )),
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            FlutterSlider(
              min: double.parse(ConstanceData.prof.min_rate.toString()),
              max: double.parse(ConstanceData.prof.max_rate.toString()),
              step: FlutterSliderStep(
                  step: 5,
                  // default
                  isPercentRange: true,
                  // ranges are percents, 0% to 20% and so on... . default is true
                  rangeList: [
                    FlutterSliderRangeStep(
                        from: double.parse(
                            ConstanceData.prof.min_rate.toString()),
                        to: double.parse(
                            ConstanceData.prof.max_rate.toString()),
                        step: 10),
                  ]),
              values: [widget._value],
              onDragCompleted: (one, two, three) {
                setState(() {
                  widget._value = two;
                });
              },
            ),
            SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                Access()
                    .setPrice(widget._value.toInt().toString())
                    .then((value) => {
                          Access().getProfile().then((value) => {
                                ConstanceData.prof = value,
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
            Expanded(
              child: SizedBox(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
            SizedBox(
              height: MediaQuery.of(context).padding.bottom + 16,
            )
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      automaticallyImplyLeading: false,
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
          Text(
            AppLocalizations.of('Price Management'),
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.headline6.color,
                ),
          ),
          SizedBox(),
        ],
      ),
    );
  }

  String getName(vehicle_id) {
    for (var i in ConstanceData.vehicletype) {
      if (vehicle_id == i.vehicle_id.toString()) {
        return i.vehicle;
      }
    }
  }

  String getPhoto(vehicle_id) {
    for (var i in ConstanceData.vehicletype) {
      if (vehicle_id == i.vehicle_id.toString()) {
        return i.vehicle_icon;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      setState(() {
        if (ConstanceData.prof.driver_rate != null &&
            ConstanceData.prof.driver_rate >= ConstanceData.prof.min_rate &&
            ConstanceData.prof.driver_rate <= ConstanceData.prof.max_rate) {
          widget._value =
              ConstanceData.prof.driver_rate >= ConstanceData.prof.min_rate
                  ? double.parse(ConstanceData.prof.driver_rate.toString())
                  : double.parse(ConstanceData.prof.min_rate.toString());
        }
      });
    } else {
      if (ConstanceData.prof.driver_rate != null &&
          ConstanceData.prof.driver_rate >= ConstanceData.prof.min_rate &&
          ConstanceData.prof.driver_rate <= ConstanceData.prof.max_rate) {
        widget._value =
            ConstanceData.prof.driver_rate >= ConstanceData.prof.min_rate
                ? double.parse(ConstanceData.prof.driver_rate.toString())
                : double.parse(ConstanceData.prof.min_rate.toString());
      }
    }
  }
}
