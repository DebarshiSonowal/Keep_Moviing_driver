import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_cab_driver/Language/appLocalizations.dart';
import 'package:my_cab_driver/Model/Document.dart';
import 'package:my_cab_driver/networking/Access.dart';

import 'Preview.dart';

class DocumentUpload extends StatefulWidget {
  const DocumentUpload({Key key}) : super(key: key);

  @override
  _DocumentUploadState createState() => _DocumentUploadState();
}

class _DocumentUploadState extends State<DocumentUpload> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> rc = List<XFile>(2),
      insu = List<XFile>(2),
      puc = List<XFile>(2),
      tax = List<XFile>(2),
      fitness = List<XFile>(2),
      permit = List<XFile>(2),
      driving = List<XFile>(2);

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
                                      rc[0] = await _picker
                                          .pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (rc[0] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(rc[0]),
                                          ),
                                        );
                                        if (result == 'Yes') {
                                          setState(() {
                                            Fluttertoast.showToast(
                                                msg: "Image selected",
                                                toastLength:
                                                Toast.LENGTH_SHORT,
                                                gravity: ToastGravity.CENTER,
                                                timeInSecForIosWeb: 1,
                                                backgroundColor: Colors.red,
                                                textColor: Colors.white,
                                                fontSize: 16.0);
                                          });
                                        } else {
                                          setState(() {
                                            rc[0] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      rc[1] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (rc[1] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(rc[1]),
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
                                            rc[1] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
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
                                      insu[0] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (insu[0] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(insu[0]),
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
                                            insu[0] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      insu[1] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (insu[1] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(insu[1]),
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
                                            insu[1] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
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
                                      puc[0] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (puc[0] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(puc[0]),
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
                                            puc[0] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      puc[1] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (puc[1] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(puc[1]),
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
                                            puc[1] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
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
                                      tax[0] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (tax[0] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(tax[0]),
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
                                            tax[0] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      tax[1] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (tax[1] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(tax[1]),
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
                                            tax[1] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
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
                                      fitness[0] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (fitness[0] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(fitness[0]),
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
                                            fitness[0] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      fitness[1] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (fitness[1] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(fitness[1]),
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
                                            fitness[1] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
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
                                      permit[0] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (permit[0] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(permit[0]),
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
                                            permit[0] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      permit[1] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (permit[1] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(permit[1]),
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
                                            permit[1] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
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
                                      driving[0] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (driving[0] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(driving[0]),
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
                                            driving[0] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      driving[1] = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 50,
                                      );
                                      if (driving[1] != null) {
                                        final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                PreviewPage(driving[1]),
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
                                            driving[1] = null;
                                          });
                                        }
                                      }
                                    },
                                    child: Icon(
                                      FontAwesomeIcons.idCard,
                                      size: 40,
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
                    if (insu[0] != null &&
                        insu[1] != null &&
                        tax[0] != null &&
                        tax[1] != null &&
                        rc[0] != null &&
                        rc[1] != null &&
                        puc[0] != null &&
                        puc[1] != null &&
                        fitness[0] != null &&
                        fitness[1] != null &&
                        driving[0] != null &&
                        driving[1] != null &&
                        permit[0] != null &&
                        permit[1] != null) {
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
    List<String> registration = new List<String>(),
        dl = new List<String>(),
        ins = new List<String>(),
        polution = new List<String>(),
        tax_c = new List<String>(),
        fitness_C = new List<String>(),
        permit_c = new List<String>();
    registration.add(rc[0].path);
    registration.add(rc[1].path);
    dl.add(driving[0].path);
    dl.add(driving[1].path);
    ins.add(insu[0].path);
    ins.add(insu[1].path);
    polution.add(puc[0].path);
    polution.add(puc[1].path);
    tax_c.add(tax[0].path);
    tax_c.add(tax[1].path);
    fitness_C.add(fitness[0].path);
    fitness_C.add(fitness[1].path);
    permit_c.add(permit[0].path);
    permit_c.add(permit[1].path);
    document doc =
        document(registration, dl, ins, polution, tax_c, fitness_C, permit_c);
    Access().uploadDocument(doc).then((value) => {
          Navigator.pop(context),
          Fluttertoast.showToast(
              msg: "${value}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0)
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
