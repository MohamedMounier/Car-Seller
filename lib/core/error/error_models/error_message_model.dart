import 'package:equatable/equatable.dart';

class ErrorMessageModel extends Equatable {
  final String message;
  final String code;

  const ErrorMessageModel({required this.message,
    required this.code,
   });

  factory ErrorMessageModel.fromError({String? message,String? code}){
    return ErrorMessageModel(
        message:message??"kindly reopen the application",
        code: code??'internet connection error',
     );
  }

  @override
  List<Object> get props => [message, code];
}

class LocalDataBaseErrorModel extends Equatable {
  final String localErrorMessage;

  const LocalDataBaseErrorModel(this.localErrorMessage);

  @override
  List<Object> get props => [localErrorMessage];
}
