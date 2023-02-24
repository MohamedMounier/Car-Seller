import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String statusMessage;
  final int statusCode;
  final bool isSuccess;

  const ErrorMessageModel({required this.statusMessage,
    required this.statusCode,
    required this.isSuccess});

  factory ErrorMessageModel.fromJson(Map<String, dynamic>json){
    return ErrorMessageModel(
        statusMessage: json["status_message"],
        statusCode: json["status_code"],
        isSuccess: json["success"]);
  }

  @override
  List<Object> get props => [statusMessage, statusCode, isSuccess];
}

class LocalDataBaseErrorModel extends Equatable {
  final String localErrorMessage;

  const LocalDataBaseErrorModel(this.localErrorMessage);

  @override
  List<Object> get props => [localErrorMessage];
}
