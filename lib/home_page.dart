import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';

import 'dragable/drag_target_widget.dart';
import 'dragable/draggable_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ImageInfo _imageInfo;
  AssetImage assestImage;
  File file;
  //
  File _image;
  final _picker = ImagePicker();
  StreamController streamController = StreamController<File>.broadcast();

  void initState() {
    super.initState();
    assestImage = AssetImage('assets/images/commercialoffice.jpg');
    WidgetsBinding.instance.addPostFrameCallback((a) => _getImageInfo());
  }

  void _getImageInfo() async {
    Image image = new Image.asset('assets/images/commercialoffice.jpg');
    Completer<ImageInfo> completer = Completer();
    image.image
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info);
    }));
  }

  Future _getImageFromTablet() async {
    final image = await _picker.getImage(source: ImageSource.gallery);
    _image = File(image.path);
    return _image;
  }

  Future _getImageFromDesktop() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder<File>(
            stream: streamController.stream,
            builder: (context, snapshot) {
              print("snappshot : ${snapshot.data}");
              return Container(
                padding: EdgeInsets.all(50),
                child: Column(
                  children: [
                    snapshot.hasData
                        ? Container(
                            height: size.height * .7 - 50,
                            width: size.width,
                            child: DragTargetWidget(
                                file: snapshot.hasData ? snapshot.data : null))
                        : Container(
                            height: size.height * .7 - 50,
                            width: size.width,
                            child: GestureDetector(
                              child: Container(
                                child: Icon(
                                  Icons.image,
                                  size: 300,
                                ),
                              ),
                            ),
                          ),
                    Container(
                      // color: Colors.blue,
                      height: size.height * .2 - 50,
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          DraggableWidget(),
                          RaisedButton(
                            onPressed: () async {
                              if (Platform.isIOS || Platform.isAndroid) {
                                print("tablet");
                                streamController.sink
                                    .add(await _getImageFromTablet());
                              } else {
                                print("desktop");
                                // _getImageFromDesktop();
                              }
                            },
                            child: Text("Load"),
                            color: Colors.blue.withOpacity(.5),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
// class _HomePageState extends State<HomePage> {
//   ImageInfo _imageInfo;
//   AssetImage assestImage;
//   double getheight;
//   double getywidth;
//
//   Offset dragOffset;
//   @override
//   void initState() {
//     super.initState();
//     assestImage = AssetImage('assets/images/commercialoffice.jpg');
//     WidgetsBinding.instance.addPostFrameCallback((a) => _getImageInfo());
//   }
//
//   void _getImageInfo() async {
//     Image image = new Image.asset('assets/images/commercialoffice.jpg');
//     Completer<ImageInfo> completer = Completer();
//     image.image
//         .resolve(new ImageConfiguration())
//         .addListener(ImageStreamListener((ImageInfo info, bool _) {
//       completer.complete(info);
//     }));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//           child: Column(
//         children: <Widget>[
//           TapImage(
//             onTap: (Offset offset, RenderBox getBox, TapDownDetails details) {
//               double dx;
//               double dy;
//               dx = offset.dx * _imageInfo.image.width;
//               dy = offset.dy * _imageInfo.image.height;
//               setState(() {
//                 dragEnd(dx, dy);
//               });
//             },
//             image: assestImage,
//           ),
//           Draggable(
//               dragAnchor: DragAnchor.pointer,
//               onDragStarted: () {
//                 WidgetsBinding.instance
//                     .addPostFrameCallback((_) => setState(() {
//                           RenderBox getBox = context.findRenderObject();
//                           getheight = getBox.size.height;
//                           getywidth = getBox.size.width;
//                         }));
//               },
//               onDragEnd: (details) {
//                 double dx;
//                 double dy;
//                 dx = (details.offset.dx / getywidth) * _imageInfo.image.width;
//                 dy =
//                     ((details.offset.dy) / getywidth) * _imageInfo.image.height;
//                 setState(() {
//                   dragEnd(dx, dy);
//                 });
//               },
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 28.0),
//                 child: Container(
//                     color: Colors.green,
//                     child: Text(
//                       'tree',
//                       style: TextStyle(fontSize: 30.0),
//                     )),
//               ),
//               feedback: Container(
//                 height: 10.0,
//                 child: Text(
//                   'tree',
//                   style: TextStyle(fontSize: 15.0),
//                 ),
//               )),
//         ],
//       )),
//     );
//   }
//
//   void dragEnd(double dx, double dy) {
//     if (_imageInfo != null) {
//       if ((673 <= dx && dx <= 822) && (635 <= dy && dy <= 849)) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return _textDescriptionDialog(
//               context,
//               'Drag on tree',
//             );
//           },
//         );
//       } else {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return _textDescriptionDialog(
//               context,
//               'Drag outside',
//             );
//           },
//         );
//       }
//     }
//   }
//
//   Widget _textDescriptionDialog(BuildContext context, String text) {
//     return new FractionallySizedBox(
//         heightFactor: MediaQuery.of(context).orientation == Orientation.portrait
//             ? 0.5
//             : 0.8,
//         widthFactor: MediaQuery.of(context).orientation == Orientation.portrait
//             ? 0.8
//             : 0.4,
//         child: Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.all(
//               Radius.circular(20.0),
//             ),
//           ),
//           child: Container(child: Center(child: Text(text))),
//         ));
//   }
// }
//
// typedef void OnTapLocation(
//     Offset offset, RenderBox getBox, TapDownDetails details);
//
// class TapImage extends StatelessWidget {
//   TapImage({Key key, this.onTap, this.image}) : super(key: key);
//
//   final OnTapLocation onTap;
//   final ImageProvider image;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTapDown: (TapDownDetails details) => _onTap(details, context),
//       child: Image(image: AssetImage('assets/images/commercialoffice.jpg')),
//     );
//   }
//
//   void _onTap(TapDownDetails details, BuildContext context) {
//     RenderBox getBox = context.findRenderObject();
//     print('size is ${getBox.size}');
//     Offset local = getBox.globalToLocal(details.globalPosition);
//     print('local is $local');
//     onTap(Offset(local.dx / getBox.size.width, local.dy / getBox.size.height),
//         getBox, details);
//   }
// }
