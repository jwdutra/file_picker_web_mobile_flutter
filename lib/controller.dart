import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class FileUploader {
  final Dio _dio = Dio();

  Future<List<PlatformFile>> chooseFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      return result.files;
    } else {
      log('Nenhum arquivo selecionado');
      return [];
    }
  }

  /// Upload files from mobile devices
  Future<void> uploadFiles() async {
    var formData = FormData();

    List<PlatformFile> files = await chooseFiles();

    if (files.isEmpty) {
      return;
    }

    for (var file in files) {
      formData.files.add(MapEntry(
        "file",
        await MultipartFile.fromFile(file.path!),
      ));
    }

    try {
      var response = await _dio.post(
        "http://localhost:3000/upload",
        data: formData,
      );

      if (response.statusCode == 200) {
        log("Upload realizado com sucesso!");
      } else {
        log("Falha no upload dos arquivos.");
      }
    } catch (e) {
      log("Erro ao fazer upload dos arquivos ", error: e);
    }
  }

  /// Upload files from web
  Future<void> uploadFilesFromBytes() async {
    var formData = FormData();

    List<PlatformFile> files = await chooseFiles();

    if (files.isEmpty) {
      return;
    }

    for (var file in files) {
      formData.files.add(MapEntry(
        "file",
        MultipartFile.fromBytes(file.bytes!, filename: file.name),
      ));
    }

    try {
      var response = await _dio.post(
        "http://localhost:3000/upload",
        data: formData,
      );

      if (response.statusCode == 200) {
        log("Upload realizado com sucesso!");
      } else {
        log("Falha no upload dos arquivos.");
      }
    } catch (e, s) {
      log("Erro ao fazer upload dos arquivos", stackTrace: s);
    }
  }
}
