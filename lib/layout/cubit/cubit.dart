import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../models/comment_model.dart';
import '../../models/message_model.dart';
import '../../models/post_model.dart';
import '../../models/social_user_model.dart';
import '../../modules/chats/chats_screen.dart';
import '../../modules/feeds/feeds_screen.dart';
import '../../modules/login/social_login_screen.dart';
import '../../modules/new_post/new_post_screen.dart';
import '../../modules/settings/settings_screen.dart';
import '../../modules/users/users_screen.dart';
import '../../shared/components/components.dart';
import '../../shared/components/constants.dart';
import 'states.dart';

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  void getUserData()
  {
    emit(SocialGetUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel =
          SocialUserModel.fromJson(value.data() as Map<String, dynamic>);
      print(value.data());
      emit(SocialGetUserSuccessState());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];
  void changeBottomNav(int? index)
  {
    if (index == 1) {
      getUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index!;
      emit(SocialChangeBottomNavState());
    }
  }

  XFile? profileImage;
  File? profileImageFile;
  final ImagePicker picker = ImagePicker();
  Future<void> getProfileImage() async
  {
    profileImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (profileImage != null) {
      profileImageFile = File(profileImage!.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(SocialProfileImagePickedErrorState());
    }
  }

  XFile? coverImage;
  File? coverImageFile;
  Future<void> getCoverImage() async {
    coverImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (coverImage != null) {
      coverImageFile = File(coverImage!.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(SocialCoverImagePickedErrorState());
    }
  }

  void uploadProfileImage({
    String? name,
    String? phone,
    String? bio,
    String? email,
  }) {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          email: email,
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
        // emit(SocialUploadProfileImageSuccessState());
      }).catchError((error) {
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    String? name,
    String? phone,
    String? bio,
    String? email,
  }) async {
    emit(SocialUserUpdateLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(
          email: email,
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
        // emit(SocialUploadCoverImageSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String? name,
    required String? phone,
    required String? bio,
    required String? email,
    String? cover,
    String? image,
  }) {
    emit(SocialUserUpdateLoadingState());
    SocialUserModel socialUserModel = SocialUserModel(
      name: name,
      phone: phone,
      bio: bio,
      uId: uId,
      email: email,
      isEmailVerified: true,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(socialUserModel.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error);
      emit(SocialUserUpdateErrorState());
    });
  }

  XFile? postImage;
  File? postImageFile;
  Future<void> getPostImage() async
  {
    postImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (postImage != null) {
      postImageFile = File(postImage!.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String? dateTime,
    required String? text,
  }) async {
    emit(SocialCreatePostLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          dateTime: dateTime,
          text: text,
          postImage: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    PostModel postModel = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(postModel.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialCreatePostErrorState());
    });
  }

  void removePostImage()
  {
    postImage = null;
    emit(SocialRemovePostImageState());
  }
  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts()
  {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error));
    });
  }

  void likePosts(String postsId)
  {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postsId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      int index = postsId.indexOf(postsId);
      likes[index] = likes[index] + 1;
      emit(SocialLikePostsSuccessState());
    }).catchError((error) {
      emit(SocialLikePostsErrorState(error));
    });
  }

  XFile? commentImage;
  File? commentImageFile;
  Future<void> getCommentImage() async
  {
    commentImage = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (commentImage != null) {
      commentImageFile = File(commentImage!.path);
      emit(SocialCommentImagePickedSuccessState());
    } else {
      print("please selected image");
      emit(SocialCommentImagePickedErrorState());
    }
  }

  void uploadCommentImage({
    required String? uidComment,
    required String? textComment,
    String? imageComment,
    String? postId,
  }) async {
    emit(SocialCreatePostLoadingState());
    await firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(commentImage!.path).pathSegments.last}')
        .putFile(commentImageFile!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createComment(
          uidComment: uidComment,
          textComment: textComment,
          imageComment: imageComment,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialCreateCommentsErrorState(error));
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateCommentsErrorState(error));
    });
  }

  void createComment({
    required String? uidComment,
    required String? textComment,
    String? imageComment,
    String? postId,
  }) {
    emit(SocialCreatePostLoadingState());
    CommentModel commentModel = CommentModel(
      name: userModel!.name,
      textComment: textComment,
      image: userModel!.image,
      imageComment: imageComment,
      postId: postId,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .doc(uidComment!)
        .collection('comments')
        .doc(userModel!.uId)
        .set(commentModel.toMap())
        .then((value) {
      emit(SocialCreateCommentsSuccessState());
    }).catchError((error) {
      print(error);
      emit(SocialCreateCommentsErrorState(error));
    });
  }

  void removeCommentImage()
  {
    commentImage = null;
    emit(SocialRemoveCommentImageState());
  }

  List<CommentModel> commentsModel = [];
  List<String> commentsId = [];
  List<dynamic> comments = [];
  void getComments()
  {
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
          postsId.add(element.id);
          commentsModel.add(CommentModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      emit(SocialGetCommentsSuccessState());
    }).catchError((error) {
      emit(SocialGetCommentsErrorState(error));
    });
  }

  List<SocialUserModel> user = [];
  void getUsers()
  {
    emit(SocialGetUserLoadingState());

    user.clear();

    FirebaseFirestore.instance.collection("users").get().then((value) {
      value.docs.forEach((element) {
        if (element['uId'] != userModel!.uId)
        {
          user.add(SocialUserModel.fromJson(element.data()));
        }
      });

      // Emit the success event after all the users have been added to the user list
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  void sendMessage({
    required String receiverId,
    required String text,
    required String dateTime,
  }) {
    emit(SocialSendMessageLoadingState());
    MessageModel messageModel = MessageModel(
      senderId: userModel!.uId,
      receiverId: receiverId,
      text: text,
      dateTime: dateTime,
    );
    // my message
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error));
    });
    // receiver message
    FirebaseFirestore.instance
        .collection("users")
        .doc(receiverId)
        .collection("chats")
        .doc(userModel!.uId)
        .collection("messages")
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error));
    });
  }

  List<MessageModel> message = [];
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection("users")
        .doc(userModel!.uId)
        .collection("chats")
        .doc(receiverId)
        .collection("messages")
        .orderBy("dateTime")
        .snapshots()
        .listen((event) {
      message = [];
      event.docs.forEach((element) {
        message.add(
          MessageModel.fromJson(element.data()),
        );
      });
      emit(SocialGetMessageSuccessState());
    });
  }

  void signOut(context)
  {
    FirebaseAuth.instance.signOut().then((value) {
      navigateAndFinish(context,  SocialLoginScreen());
      emit(SocialSiqnOutSuccessState());
    }).catchError((error) {
      emit(SocialSiqnOutErrorState(error));
    });
  }

}
