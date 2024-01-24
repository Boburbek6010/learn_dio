import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:learn_dio/models/user_model.dart';
import 'package:learn_dio/server/api.dart';
import 'package:learn_dio/services/dio_service.dart';

class HomePage extends StatefulWidget {
  static const String id = "/home_page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<UserModel> listOfUsers = [];
  bool isLoading = false;

  // Future<void>getData()async{
  //   isLoading = false;
  //   String? result = await DioService.get(context, ApiServer.apiGetAllData);
  //   if(result != null){
  //     listOfUsers = userModelFromJson(result);
  //     isLoading = true;
  //     setState(() {});
  //   }
  // }

  @override
  void initState() {
    List<String?> list = [];
    UserModel userModel = UserModel(createdAt: DateTime.now(), name: "Sardor", avatar: "avatar", id: "id");
    DioService.postAndGet(context, apiForPost: ApiServer.apiGetAllData, dataForPost: userModel.toJson(), apiForGet: ApiServer.apiGetAllData).then((value) {
       list = value;
       if(list[1] != null){
         listOfUsers = userModelFromJson(list[1]!);
         isLoading = true;
       }
       setState(() {});
       log(list.toString());
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text("Home Page"),
        centerTitle: true,
      ),
      body: isLoading ?ListView.builder(
        itemCount: listOfUsers.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(listOfUsers[index].name),
            subtitle: Text(listOfUsers[index].createdAt.toIso8601String()),
          );
        },
      ):const Center(
        child: CircularProgressIndicator(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

          // String? result = await DioService.post(context, ApiServer.apiGetAllData, userModel.toJson());
          // if(result != null){
          //   await getData();
          //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Successfully posted")));
          // }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
