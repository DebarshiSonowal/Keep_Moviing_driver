import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/Model/Document.dart';
import 'package:my_cab_driver/networking/Access.dart';

import 'Preview.dart';

class documentUploadSingle extends StatefulWidget {
  const documentUploadSingle({Key key}) : super(key: key);

  @override
  _documentUploadSingleState createState() => _documentUploadSingleState();
}

class _documentUploadSingleState extends State<documentUploadSingle> {
  final ImagePicker _picker = ImagePicker();
  XFile rc, insu, puc, tax, fitness, permit, driving;
  final double size = 40;

  AlertDialog alert;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(left: 14, right: 14),
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      rc = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (rc != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(rc),
                                          ),
                                        );
                                        if (result == 'Yes') {
                                          setState(() {
                                            Fluttertoast.showToast(
                                                msg: "Image selected",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        } else {
                                          setState(() {
                                            rc = null;
                                          });
                                        }
                                      }
                                    },
                                    child: rc == null
                                        ? Icon(
                                            FontAwesomeIcons.idCard,
                                            size: size,
                                          )
                                        : Image.file(
                                            File(rc.path),
                                            height: size,
                                            width: size,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Registration Certificate',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      insu = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (insu != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(insu),
                                          ),
                                        );
                                        if (result == 'Yes') {
                                          setState(() {
                                            Fluttertoast.showToast(
                                                msg: "Image selected",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        } else {
                                          setState(() {
                                            insu = null;
                                          });
                                        }
                                      }
                                    },
                                    child: insu == null
                                        ? Icon(
                                            FontAwesomeIcons.idCard,
                                            size: size,
                                          )
                                        : Image.file(
                                            File(insu.path),
                                            height: size,
                                            width: size,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Insurance',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      puc = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (puc != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(puc),
                                          ),
                                        );
                                        if (result == 'Yes') {
                                          setState(() {
                                            Fluttertoast.showToast(
                                                msg: "Image selected",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        } else {
                                          setState(() {
                                            puc = null;
                                          });
                                        }
                                      }
                                    },
                                    child: puc == null
                                        ? Icon(
                                            FontAwesomeIcons.idCard,
                                            size: size,
                                          )
                                        : Image.file(
                                            File(puc.path),
                                            height: size,
                                            width: size,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Pollution Under Control',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      tax = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (tax != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(tax),
                                          ),
                                        );
                                        if (result == 'Yes') {
                                          setState(() {
                                            Fluttertoast.showToast(
                                                msg: "Image selected",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        } else {
                                          setState(() {
                                            tax = null;
                                          });
                                        }
                                      }
                                    },
                                    child: tax == null
                                        ? Icon(
                                            FontAwesomeIcons.idCard,
                                            size: size,
                                          )
                                        : Image.file(
                                            File(tax.path),
                                            height: size,
                                            width: size,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Tax',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      fitness = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (fitness != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(fitness),
                                          ),
                                        );
                                        if (result == 'Yes') {
                                          setState(() {
                                            Fluttertoast.showToast(
                                                msg: "Image selected",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        } else {
                                          setState(() {
                                            fitness = null;
                                          });
                                        }
                                      }
                                    },
                                    child: fitness == null
                                        ? Icon(
                                            FontAwesomeIcons.idCard,
                                            size: size,
                                          )
                                        : Image.file(
                                            File(fitness.path),
                                            height: size,
                                            width: size,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Fitness',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      permit = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (permit != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(permit),
                                          ),
                                        );
                                        if (result == 'Yes') {
                                          setState(() {
                                            Fluttertoast.showToast(
                                                msg: "Image selected",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        } else {
                                          setState(() {
                                            permit = null;
                                          });
                                        }
                                      }
                                    },
                                    child: permit == null
                                        ? Icon(
                                            FontAwesomeIcons.idCard,
                                            size: size,
                                          )
                                        : Image.file(
                                            File(permit.path),
                                            height: size,
                                            width: size,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Permit',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Card(
                        margin: EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        elevation: 4,
                        child: Container(
                          padding: EdgeInsets.all(10),
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      driving = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (driving != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(driving),
                                          ),
                                        );
                                        if (result == 'Yes') {
                                          setState(() {
                                            Fluttertoast.showToast(
                                                msg: "Image selected",
                                                toastLength: Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        } else {
                                          setState(() {
                                            driving = null;
                                          });
                                        }
                                      }
                                    },
                                    child: driving == null
                                        ? Icon(
                                            FontAwesomeIcons.idCard,
                                            size: size,
                                          )
                                        : Image.file(
                                            File(driving.path),
                                            height: size,
                                            width: size,
                                          ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 3,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  color: Colors.black54,
                                ),
                              ),
                              Text(
                                'Driving License',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
                                          .textTheme
                                          .headline6
                                          .color,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    showLoaderDialog(context);
                    if (insu != null &&
                        tax != null &&
                        rc != null &&
                        puc != null &&
                        fitness != null &&
                        driving != null &&
                        permit != null) {
                      send();
                    } else {
                      Navigator.pop(context);
                      Fluttertoast.showToast(
                          msg: "Please upload all the documents",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    }
                  },
                  child: Text('Submit'),
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
            AppLocalizations.of('Document Upload'),
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

  void send() async {
    document doc = document(rc.path, driving.path, insu.path, puc.path,
        tax.path, fitness.path, permit.path);
    Access().uploadDocument(doc).then((value) => {
          Navigator.pop(context),
          Fluttertoast.showToast(
              msg: "${value}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0),
          Navigator.pop(context),
        });
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
