import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project1/layout/social_app/cubit/cubit.dart';
import 'package:project1/layout/social_app/cubit/states.dart';
import 'package:project1/shared/components/components.dart';
import '../../shared/styles/icon_broken.dart';


class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state)
      {
        var userModel = SocialCubit.get(context).userModel;
        var profileImageFile = SocialCubit.get(context).profileImageFile;
        var coverImageFile = SocialCubit.get(context).coverImageFile;
        nameController.text = userModel!.name!;
        phoneController.text = userModel.phone!;
        bioController.text = userModel.bio!;
        emailController.text = userModel.bio!;

        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                IconBroken.Arrow___Left_2,
              ),
            ),
            titleSpacing: 0.0,
            title: const Text(
              'Edit Profile',
            ),
            actions: [
              defaultTextButton(
                function: () {
                  SocialCubit.get(context).updateUser(name: nameController.text, phone: phoneController.text, bio: bioController.text, email: emailController.text );
                },
                text: 'Update',
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children:  [
                  if (state is SocialUserUpdateLoadingState)
                  const LinearProgressIndicator(),
                  if (state is SocialUserUpdateLoadingState)
                    const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 220,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topEnd,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 165,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(4),
                                      topRight: Radius.circular(4),
                                    ),
                                    image: DecorationImage(
                                      image: coverImageFile == null
                                          ? NetworkImage(
                                        userModel.cover!,
                                      )
                                          : FileImage(coverImageFile)
                                      as ImageProvider,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              IconButton(
                                onPressed: () {
                                  SocialCubit.get(context).getCoverImage();
                                },
                                icon: const CircleAvatar(
                                  radius: 20,
                                  child: Icon(
                                    IconBroken.Camera,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 64,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileImageFile == null
                                    ? NetworkImage(userModel.image!)
                                    : FileImage(profileImageFile)
                                as ImageProvider,
                              ),
                            ),
                            IconButton(
                              onPressed: ()
                              {
                                SocialCubit.get(context).getProfileImage();
                              },
                              icon: const CircleAvatar(
                                radius: 20,
                                child: Icon(
                                  IconBroken.Camera,
                                  size: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if(SocialCubit.get(context).profileImage !=null ||SocialCubit.get(context).coverImage !=null )
                  Row(
                    children: [
                      if(SocialCubit.get(context).profileImage !=null)
                      Expanded(
                        child: DefaultButton(
                          function: ()
                          {
                            SocialCubit.get(context).uploadProfileImage(
                              name : nameController.text,
                              phone: phoneController.text,
                              bio: bioController.text,
                            );
                          },
                          text: 'upload profile ',
                        ),
                      ),
                        const  SizedBox(
                        width: 5,
                      ),
                      if (state is SocialUserUpdateLoadingState)
                        const LinearProgressIndicator(),
                        const  SizedBox(
                        width: 5,
                      ),
                      if(SocialCubit.get(context).coverImage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            DefaultButton(
                              function: ()
                              {
                                SocialCubit.get(context).uploadCoverImage(
                                    name : nameController.text,
                                    phone: phoneController.text,
                                    bio: bioController.text,
                                );
                              },
                              text: 'upload cover',
                            ),
                              const SizedBox(
                              height: 5,
                            ),
                            if (state is SocialUserUpdateLoadingState)
                              const LinearProgressIndicator(),
                          ],
                        ),

                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DefaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'name must not be empty';
                      }
                    },
                    label: 'Name',
                    prefix: IconBroken.User,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultFormField(
                    controller: bioController,
                    type: TextInputType.text,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'bio must not be empty';
                      }
                      return null;
                    },
                    label: 'Bio',
                    prefix: IconBroken.Info_Circle,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  DefaultFormField(
                    controller: phoneController,
                    type: TextInputType.phone,
                    validate: (String? value) {
                      if (value!.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    label: 'Phone',
                    prefix: IconBroken.Call,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
