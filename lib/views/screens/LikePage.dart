import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/json_decode_provider.dart';
import '../../models/json_decode_model.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;
    double h = s.height;
    double w = s.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Like Page"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
                leading: Text(
                  Provider.of<ShlokJsonDecodeProvider>(context, listen: false)
                      .shlokJsonDecodeModel
                      .allShloks[shlokIndex]
                      .verse,
                  style: TextStyle(
                    fontSize: h * 0.02,
                  ),
                ),
                title: Text(
                  Provider.of<ShlokJsonDecodeProvider>(context, listen: false)
                      .shlokJsonDecodeModel
                      .allShloks[shlokIndex]
                      .sanskrit,
                  style: TextStyle(
                    fontSize: h * 0.015,
                  ),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                    ))),
          ),
          Card(
            child: ListTile(
                leading: Text(
                  Provider.of<ShlokJsonDecodeProvider>(context, listen: false)
                      .shlokJsonDecodeModel
                      .allShloks[shlokIndex + 5]
                      .verse,
                  style: TextStyle(
                    fontSize: h * 0.02,
                  ),
                ),
                title: Text(
                  Provider.of<ShlokJsonDecodeProvider>(context, listen: false)
                      .shlokJsonDecodeModel
                      .allShloks[shlokIndex + 5]
                      .sanskrit,
                  style: TextStyle(
                    fontSize: h * 0.015,
                  ),
                ),
                trailing: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.delete,
                    ))),
          ),
          // Card(
          //   child: ListTile(
          //       leading: Text(
          //         Provider.of<ShlokJsonDecodeProvider>(context, listen: false)
          //             .shlokJsonDecodeModel
          //             .allShloks[shlokIndex + 8]
          //             .verse,
          //         style: TextStyle(
          //           fontSize: h * 0.02,
          //         ),
          //       ),
          //       title: Text(
          //         Provider.of<ShlokJsonDecodeProvider>(context, listen: false)
          //             .shlokJsonDecodeModel
          //             .allShloks[shlokIndex + 8]
          //             .sanskrit,
          //         style: TextStyle(
          //           fontSize: h * 0.015,
          //         ),
          //       ),
          //       trailing: IconButton(
          //           onPressed: () {},
          //           icon: Icon(
          //             Icons.delete,
          //           ))),
          // ),
        ],
      ),
    );
  }
}
