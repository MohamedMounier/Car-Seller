import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:voomeg/core/enums/enums.dart';
import 'package:voomeg/core/global/resources/color_manager.dart';
import 'package:voomeg/core/global/resources/values_manager.dart';
import 'package:voomeg/core/global/routes/app_routes_names.dart';
import 'package:voomeg/features/auth/domain/entities/login.dart';
import 'package:voomeg/features/auth/presentation/controller/login_bloc.dart';
import 'package:voomeg/features/bids/presentation/controller/home_bloc.dart';
import 'package:voomeg/reusable/toasts/app_toastss.dart';
import 'package:voomeg/reusable/widgets/editable_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  bool obsecure = true;
  bool loading = false;
  GlobalKey<FormState> formKeyLogin = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    // LoginBloc.formKeyLogin.currentState?.dispose();
    // BlocProvider.of<LoginBloc>(context).nameCtrl.dispose();
    // BlocProvider.of<LoginBloc>(context).phoneCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor:Theme.of(context).primaryColor,
        body: SafeArea(
          child: BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.loginSteps==LoginSteps.isSavingUserUidSuccess&&state.requestState==RequestState.isSucc) {

                //Navigator.pop(context);


                BlocProvider.of<HomeBloc>(context).add( FetchUserTypeEvent());
                BlocProvider.of<HomeBloc>(context).add(FetchUserUidEvent());
                BlocProvider.of<HomeBloc>(context).add(FetchUserEvent());
                BlocProvider.of<HomeBloc>(context).add(FetchUserCarsForSale());
                state.isTrader
                    ? Navigator.pushReplacementNamed(
                        context, AppRoutesName.traderHome)
                    : Navigator.pushReplacementNamed(
                        context, AppRoutesName.home);
               // state.requestState=RequestState.isNone;
              } else if (state.requestState == RequestState.isLoading&&state.loginSteps==LoginSteps.isLoginUserIn) {
                // showDialog(
                //     context: context,
                //     builder: (builder) {
                //       return AlertDialog(
                //         content: Text('Loading ....'),
                //       );
                //     });
              } else if (state.requestState == RequestState.isError) {

                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.loginErrorMessage)));
              }else if (state.loginSteps==LoginSteps.isLoginUserInSuccess){
                ScaffoldMessenger.of(context).showSnackBar(
                    snackBarToast(isError: false,text: 'Successfully Logged in ...'));
                BlocProvider.of<LoginBloc>(context).add(LoginSaveUserCheck(state.isUserSaved));
                BlocProvider.of<LoginBloc>(context).add(SaveUserUidEvent(state.userUid));
              }
            },
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 20.0),
                  child: Form(
                    key: formKeyLogin,
                    child: ListView(
                      children: [
                        SizedBox(
                          height: screenHeight * 0.1,
                        ),
                        Text(
                          'Login',
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
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return EditableInfoField(
                              hint: 'Password',
                              iconName: Icons.lock_outline,
                              textEditingController: passwordCtrl,
                              // containerWidth: screenWidth*.8,
                              keyboardType: TextInputType.visiblePassword,
                              isPassword: true,
                              isObsecure: state.isPasswordVisible,
                              passwordIcon: IconButton(
                                  onPressed: () {
                                    BlocProvider.of<LoginBloc>(context).add(ShowPasswordEvent(
                                        state.isPasswordVisible));
                                  },
                                  icon: state.isPasswordVisible
                                      ?const  Icon(Icons.remove_red_eye_outlined)
                                      : const Icon(Icons.lock_clock_rounded)),
                            );
                          },
                        ),
                        SizedBox(
                          height: screenHeight * .05,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                              onPressed: () {
                                // Get.toNamed(Routes.forgotPassRoute);
                                Navigator.pushNamed(
                                    context, AppRoutesName.register);
                              },
                              child: Text(
                                'Don\'t Have an account ?',
                                style: TextStyle(
                                    color: ColorManager.primary,
                                    fontSize: 16,
                                    decoration: TextDecoration.underline),
                              )),
                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor:Theme.of(context).primaryColor,
                              checkboxShape: const RoundedRectangleBorder(),
                              value: state.isUserSaved,
                              onChanged: (val) {
                                BlocProvider.of<LoginBloc>(context).add(RememberMeEvent(val));
                              },
                              title: Text(
                                'Save login ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(color: ColorManager.primary),
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: AppSize.s30,
                        ),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            return CheckboxListTile(
                              checkColor: Colors.white,
                              activeColor: Theme.of(context).primaryColor,
                              checkboxShape: const RoundedRectangleBorder(),
                              value: state.isTrader,
                              onChanged: (val) {
                                BlocProvider.of<LoginBloc>(context).add(ChangeUserTypeEvent(val!));
                                BlocProvider.of<LoginBloc>(context).add(SaveUserTypeEvent(val));

                              },
                              title: Text(
                                'Log in as a trader ',
                                style: Theme.of(context)
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
                        BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                          if (state.requestState == RequestState.isLoading) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: ColorManager.darkPrimary,
                              ),
                            );
                          } else {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20.0, vertical: 15),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  validateFields(context);
                                },
                                icon: const Icon(Icons.login),
                                label: const Padding(
                                  padding:  EdgeInsets.all(AppPading.p8),
                                  child: Text('Login'),
                                ),
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
            ),
          ),
        ));
  }

  validateFields(BuildContext context) {
    if (formKeyLogin.currentState!.validate()) {
      BlocProvider.of<LoginBloc>(context).add(LoginEventLogUserIn(LoginEntity(
          email: emailCtrl.text.trim(), password: passwordCtrl.text.trim())));
    }
  }
}
