import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector64;

class AREarthScreen extends StatefulWidget {
  const AREarthScreen({super.key});

  @override
  State<AREarthScreen> createState() => _AREarthScreenState();
}

class _AREarthScreenState extends State<AREarthScreen> {
  ArCoreController? augmentedRealityCoreController;
  augmentedRealityViewCreated(ArCoreController coreController) {
    augmentedRealityCoreController = coreController;

    displayEarthMapSphere(augmentedRealityCoreController!);
  }

  displayEarthMapSphere(ArCoreController coreController) async {
    final ByteData earthTextureBytes = await rootBundle.load('images/earth_map.jpg');
    final materials = ArCoreMaterial(
      color: Colors.blue,
      textureBytes: earthTextureBytes.buffer.asUint8List(),
    );

    final sphere = ArCoreSphere(
      materials: [materials],
    );

    final node = ArCoreNode(
      shape: sphere,
      position: vector64.Vector3(0, 0, -1.5),
    );

    augmentedRealityCoreController!.addArCoreNode(node);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ArCoreView(
        onArCoreViewCreated: augmentedRealityViewCreated,
      ),
    );
  }
}
