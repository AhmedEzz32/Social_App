import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/modules/social_app/register/cubit/cubit.dart';
import 'package:project1/modules/social_app/register/cubit/states.dart';
import 'package:project1/shared/components/components.dart';
import '../../../layout/social_app/social_layout.dart';

class SocialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterStates>(
        listener: (BuildContext context, state) {
          if (state is SocialCreateUserSuccessState) {
            navigateAndFinish(context, SocialLayout());
          }
        },
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              body: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/register.jpg'),
                  ),
                ),
                child: Center(
                  child: SingleChildScrollView(
                    //3shan error aly bygy lma bft7 keyboard
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'REGISTER',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Register now to communicate with your friends',
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: Colors.deepPurple[800]),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: DefaultFormField(
                                controller: nameController,
                                type: TextInputType.name,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your name';
                                  }
                                },
                                label: 'name',
                                prefix: Icons.person,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: DefaultFormField(
                                controller: emailController,
                                type: TextInputType.emailAddress,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your email';
                                  }
                                },
                                label: 'Email Address',
                                prefix: Icons.email,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: DefaultFormField(
                                controller: passwordController,
                                type: TextInputType.visiblePassword,
                                suffix: SocialRegisterCubit
                                    .get(context)
                                    .suffix,
                                onSubmit:
                                    (
                                    value) //da 3shan lma ados sah ydkhol 3ltool mn 8eer ma ados login
                                {},
                                isPassword:
                                SocialRegisterCubit
                                    .get(context)
                                    .isPassword,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'password is to short';
                                  }
                                },
                                suffixPressed: () {
                                  SocialRegisterCubit.get(context)
                                      .changePasswordVisibility();
                                },
                                label: 'password',
                                prefix: Icons.lock_outlined,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: DefaultFormField(
                                controller: phoneController,
                                type: TextInputType.phone,
                                validate: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter your phone';
                                  }
                                },
                                label: 'phone',
                                prefix: Icons.phone,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ConditionalBuilder(
                              condition: state is! SocialRegisterLoadingState,
                              builder: (BuildContext context) =>
                                  DefaultButton(
                                    function: () {
                                      if (formKey.currentState!.validate()) {
                                        SocialRegisterCubit.get(context)
                                            .userRegister(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text,
                                        );
                                      }
                                    },
                                    text: 'register',
                                  ),
                              fallback: (BuildContext context) =>
                              const Center(child: CircularProgressIndicator()),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
