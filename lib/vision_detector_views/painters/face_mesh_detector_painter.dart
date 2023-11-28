import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_face_mesh_detection/google_mlkit_face_mesh_detection.dart';

import 'coordinates_translator.dart';

class FaceMeshDetectorPainter extends CustomPainter {
  FaceMeshDetectorPainter(
    this.meshes,
    this.imageSize,
    this.rotation,
    this.cameraLensDirection,
  );

  final List<FaceMesh> meshes;
  final Size imageSize;
  final InputImageRotation rotation;
  final CameraLensDirection cameraLensDirection;


  Color color = Colors.red;
  @override
  void paint(Canvas canvas, Size size) {

    final Paint paint2 = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 2.0
      ..color = Colors.white;


    for (final FaceMesh mesh in meshes) {
      final left = translateX(
        mesh.boundingBox.left,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final top = translateY(
        mesh.boundingBox.top,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final right = translateX(
        mesh.boundingBox.right,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );
      final bottom = translateY(
        mesh.boundingBox.bottom,
        size,
        imageSize,
        rotation,
        cameraLensDirection,
      );

      // canvas.drawRect(
      //   Rect.fromLTRB(left, top, right, bottom),
      //   paint1,
      // );
      final double centerX = (size.width)/2;
      print(centerX);
      final double centerY = (size.height)/2;
      void paintTriangle(FaceMeshTriangle triangle) {
        // final List<Offset> cornerPoints = <Offset>[];
        // for (final point in triangle.points) {
          // final double x = translateX(
          //   point.x.toDouble(),
          //   size,
          //   imageSize,
          //   rotation,
          //   cameraLensDirection,
          // );
          // final double y = translateY(
          //   point.y.toDouble(),
          //   size,
          //   imageSize,
          //   rotation,
          //   cameraLensDirection,
          // );
          // cornerPoints.add(Offset(x, y));

          if (centerX + 50 > (left + right)/2 && centerY + 50 > (bottom + top)/2) {
            print("oq");
            color = Colors.white;
          } else {
            print("qizil");
            color = Colors.red;
          }
        // }
        // Add the first point to close the polygon

        final Paint paint3 = Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = color;

            canvas.drawOval(Rect.fromLTRB(centerX - 120, centerY - 200, centerX + 120, centerY + 200), paint3); // Oval chizish

        // cornerPoints.add(cornerPoints.first);
        // canvas.drawPoints(PointMode.polygon, cornerPoints, paint2);
      }


      // for (final triangle in mesh.triangles) {
        // paintTriangle(triangle);


        if (centerX + 50 > (left + right)/2 && centerY + 50 > (bottom + top)/2) {
          print("oq");
          final Paint paint3 = Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3.0
            ..color = Colors.green;
        canvas.drawOval(Rect.fromLTRB(centerX - 120, centerY - 200, centerX + 120, centerY + 200), paint3); // Oval chizish
        } else {
          print("qizil");
          final Paint paint3 = Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 3.0
            ..color = Colors.red;
        canvas.drawOval(Rect.fromLTRB(centerX - 120, centerY - 200, centerX + 120, centerY + 200), paint3); // Oval chizish
        }

      // }
    }
  }

  @override
  bool shouldRepaint(FaceMeshDetectorPainter oldDelegate) {
    return oldDelegate.imageSize != imageSize || oldDelegate.meshes != meshes;
  }
}
