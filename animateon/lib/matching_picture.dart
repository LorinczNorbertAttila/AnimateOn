import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'camera_screen.dart';

class Matching extends StatefulWidget {
  const Matching({super.key});

  @override
  State<Matching> createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: getImage(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.waiting){
            return CircularProgressIndicator(color: Colors.orange[800],);
          }
          if(snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(
            child: FutureBuilder(
              future: listStorage(snapshot.data),
              builder: (context, snapshot1){
                if(snapshot1.connectionState == ConnectionState.waiting){
                  return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(snapshot.data), 
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(Colors.grey.withOpacity(1), BlendMode.modulate,)
                          ),
                      ),
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Scanning the image',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontFamily: 'LilitaOne',
                              decoration: TextDecoration.none,
                            ),
                          )
                            .animate() // this wraps the previous Animate in another Animate
                            .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                            .slide(),
                          CircularProgressIndicator(color: Colors.orange[800],),
                        ],
                    ),
                  );
                }
                if(snapshot1.hasError){
                  snapshot1.error.toString();
                }
                else{
                  if((100 - snapshot1.data!.match*100) > 30) {
                    return Scaffold(
                    appBar: AppBar(backgroundColor: Colors.transparent,),
                    backgroundColor: Colors.white,
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                        SizedBox(
                          width : MediaQuery.of(context).size.width*0.5,
                          height: MediaQuery.of(context).size.height*0.5,
                          child: Image.network(snapshot1.data!.url)
                          .animate()
                          .shimmer(angle: -pi / 2, size: 3, curve: Curves.easeOutCubic)
                          .flip(),
                        ),
                        Text (
                              snapshot1.data!.name.toString(),
                              style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'LilitaOne',
                            ),
                        ),
                        Text (
                              'Similarity: ${(100 - snapshot1.data!.match*100).toStringAsFixed(2)}%',
                              style: const TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                              fontFamily: 'LilitaOne',
                              ),
                        ),
                        ],
                      ),
                    ),
                    );
                  }
                  else{
                    return Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(backgroundColor: Colors.transparent,),
                      body: const Center(child: Text("There is no match :(", 
                              style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontFamily: 'LilitaOne',
                            ),)),
                    );
                  }
                }
                return SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}