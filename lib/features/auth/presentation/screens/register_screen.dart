import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';
import 'package:voomeg/features/auth/domain/entities/login.dart';
import 'package:voomeg/features/auth/domain/entities/user_entity.dart';
import 'package:voomeg/features/auth/presentation/controller/register_bloc.dart';
import 'package:voomeg/reusable/toasts/app_toastss.dart';
import 'package:voomeg/reusable/widgets/editable_text.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final TextEditingController nameCtrl = TextEditingController();
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  GlobalKey<FormState> formKeyRegister = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: BlocListener<RegisterBloc, RegisterState>(
           listener: (context, state) {
        if (state.requestState == RequestState.isSucc &&
            state.registerStep == RegisterSteps.isRegistered) {

          BlocProvider.of<RegisterBloc>(context).add(AddUserEvent(UserEntity(
              email: emailCtrl.text,
              password: passwordCtrl.text,
              id: state.user!.user!.uid,
              name: nameCtrl.text,
              isTrader: state.isTrader,
              phone: phoneCtrl.text)));
        } else if (state.requestState == RequestState.isLoading) {

        } else if (state.requestState == RequestState.isSucc &&
            state.registerStep == RegisterSteps.isAddedUser) {
          // Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(snackBarToast(text: 'Registered Successfully ...', isError: false));
          Navigator.pushReplacementNamed(context, AppRoutesName.login);
        } else if (state.requestState == RequestState.isError) {

          ScaffoldMessenger.of(context).showSnackBar(snackBarToast(text: state.loginErrorMessage, isError: true));

        }
      },
         child: Padding(
           padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
           child: Card(
             child: Padding(
               padding:
               const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
               child: Form(
                 key: formKeyRegister,
                 child: ListView(
                   children: [
                     SizedBox(
                       height: screenHeight * 0.1,
                     ),
                     Text(
                       'Register',
                       style: TextStyle(
                           fontWeight: FontWeight.bold,
                           fontSize: 30,
                           color: ColorManager.primary),
                     ),
                     SizedBox(
                       height: screenHeight * 0.1,
                     ),
                     EditableInfoField(
                       hint: 'Email',
                       iconName: Icons.email_outlined,
                       textEditingController: emailCtrl,
                       // containerWidth: screenWidth*.8,
                       keyboardType: TextInputType.emailAddress,
                       isPassword: false,

                     ),
                     SizedBox(
                       height: screenHeight * .05,
                     ),
                     EditableInfoField(
                       hint: 'Password',
                       iconName: Icons.lock_outline,
                       textEditingController: passwordCtrl,
                       // containerWidth: screenWidth*.8,
                       keyboardType: TextInputType.visiblePassword,
                       isPassword: true,
                     ),
                     const  SizedBox(
                       height: AppSize.s30,
                     ),
                     EditableInfoField(
                       hint: 'Name',
                       iconName: Icons.person_outline,
                       textEditingController: nameCtrl,
                       // containerWidth: screenWidth*.8,
                       keyboardType: TextInputType.text,
                       isPassword: false,
                     ),
                     const SizedBox(
                       height: 30,
                     ),
                     EditableInfoField(
                       hint: 'Phone',
                       iconName: Icons.phone_outlined,
                       textEditingController: phoneCtrl,
                       // containerWidth: screenWidth*.8,
                       keyboardType: TextInputType.phone,
                       isPassword: false,
                     ),
                     const SizedBox(
                       height: 30,
                     ),
                     BlocBuilder<RegisterBloc, RegisterState>(
                       builder: (context, state) {
                         return CheckboxListTile(
                           checkColor: Colors.white,
                           activeColor: Colors.green,
                           checkboxShape: const RoundedRectangleBorder(),
                           value: state.isTrader,
                           onChanged: (val) {
                             BlocProvider.of<RegisterBloc>(context).add(ChangeUserTypeEvent(val!));
                           },
                           title: Text(
                             'Register as a trader  ',
                             style: Theme
                                 .of(context)
                                 .textTheme
                                 .titleMedium
                                 ?.copyWith(color: ColorManager.primary),
                           ),
                         );
                       },
                     ),

                     const SizedBox(
                       height: 30,
                     ),
                     Align(
                       alignment: Alignment.bottomRight,
                       child: TextButton(
                           onPressed: () {
                             // Get.toNamed(Routes.forgotPassRoute);
                           },
                           child: Text(
                             'Forgot Password ?',
                             style: TextStyle(
                                 color: ColorManager.primary,
                                 fontSize: 16,
                                 decoration: TextDecoration.underline),
                           )),
                     ),
                     const SizedBox(
                       height: 30,
                     ),
                     BlocBuilder<RegisterBloc,RegisterState>(builder: (context,state){
                       if(state.requestState != RequestState.isLoading){
                         return Padding(
                           padding: const EdgeInsets.symmetric(
                               horizontal: 20.0, vertical: 15),
                           child: ElevatedButton.icon(
                             onPressed: () {
                               validator(context);
                             },
                             icon: Icon(Icons.login),
                             label: const Padding(
                               padding:  EdgeInsets.all(AppPading.p8),
                               child: Text('Register'),
                             ),
                           ),
                         );
                       }else{
                        return Center(
                           child: CircularProgressIndicator(
                             color: ColorManager.primary,
                           ),
                         );
                       }
                     }),

                     SizedBox(
                       height: screenHeight * .05,
                     ),
                   ],
                 ),
               ),
             ),
           ),
         ),),
    ));
  }
  validator(BuildContext context){
    if(formKeyRegister.currentState!.validate()){
      BlocProvider.of<RegisterBloc>(context).add(
          RegisterUserEvent(LoginEntity(
              email: emailCtrl.text,
              password: passwordCtrl.text)));
    }
  }
}
