import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppBarCommon extends StatelessWidget {
  const AppBarCommon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AppBar(
        elevation: 0,
        leadingWidth: double.infinity,
        leading: InkWell( onTap: () {},
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(backgroundColor: Colors.grey.shade300,child: Image.asset("assets/1C-Innovation-logo.png",alignment: Alignment.center),),
              const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("1C innovation",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                    Text("Social Web App",style: TextStyle(color: Colors.black),)
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(top: 8,bottom: 8),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8,right: 8),
              child: Row(
                children: [
                  InkWell( onTap: () {},
                    child:  const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                        // (backIcon==true)?
                        Icon(
                          Icons.person_pin,
                          color: Colors.black,)
                      // :
                      // IconButton(
                      //  icon:const Icon( Icons.notifications),
                      //   onPressed: (){Get.to(const NotificationTest());},
                      //   color: Colors.black,)
                    ),
                  ),
                  InkWell( onTap: () {},
                    child:  const Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                        // (backIcon==true)?
                        Icon(
                          Icons.menu_outlined,
                          color: Colors.black,)
                      // :
                      // IconButton(
                      //  icon:const Icon( Icons.notifications),
                      //   onPressed: (){Get.to(const NotificationTest());},
                      //   color: Colors.black,)
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor:Colors.white,
      ),
    );
  }
}
