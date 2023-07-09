import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/models/social_app/social_user_model.dart';
import 'package:project1/modules/social_app/register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    print('hello');

    emit(SocialRegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
        email: email,
        name: name,
        phone: phone,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error);
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      bio: 'write your bio ...',
      cover: 'https://scontent.fcai19-7.fna.fbcdn.net/v/t39.30808-6/309632457_5478386212242274_6017426730081648668_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=e3f864&_nc_eui2=AeHN7ZZlf48-B7dblZrm9Oxr1Y4k2v_GfBPVjiTa_8Z8EycGFUy_V7BexNxjAzguanblZldjvrZFLXAok7QC0UMl&_nc_ohc=Rwos0WzTaKQAX9-qn5L&_nc_ht=scontent.fcai19-7.fna&oh=00_AfAvDzRqrew7KQUlIVc8xlYCZIEpoJsnJIQfzNv8OAnoJg&oe=644D2A1E',
      image : 'https://scontent.fcai19-7.fna.fbcdn.net/v/t39.30808-6/334156682_630047018851530_7989187860373151365_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEZXNmQkN7NQdgH_pi2wOrXmSzuySc2q9yZLO7JJzar3GFlBCRHD4I6hxinfneUFqnlsqfIp4lpt9jIAaNdiymg&_nc_ohc=g4LEQRR-UJYAX9pqIR-&_nc_ht=scontent.fcai19-7.fna&oh=00_AfDgZgOMRbuhvZ-TDqwggbISYr1Ihao21AGtYS_guOBQHg&oe=644DFD72',
      isEmailVerified: false,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }


  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
