import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_sub_committee.dart';
import 'package:flutter_application_111_copy/Union/union_activity.dart';

class UnionImageSlider extends StatefulWidget {
  const UnionImageSlider({super.key});

  @override
  State<UnionImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<UnionImageSlider> {
  List imageList= [
    {"id":1, "image_path": 'assets/images/cat.jpg'},
    {"id":2, "image_path": 'assets/images/dna.jpg'},
    {"id":3, "image_path": 'assets/images/sunflower.jpg'},
  ];
  final CarouselController carouselController= CarouselController();
  int currentIndex=0;
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Union"),
        backgroundColor: Colors.teal,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Stack(
              children: [
                InkWell(
                  onTap: (){
                    print(currentIndex);
                  },
                  child: CarouselSlider(
                    items: imageList 
                    .map(
                      (item) => Image.asset(
                        item ['image_path'],
                        fit: BoxFit.cover,
                        width: double.infinity,
                        ),
                        )
                        .toList(),
                        carouselController: carouselController,
                        options: CarouselOptions(
                          scrollPhysics: const BouncingScrollPhysics(),
                          autoPlay: true,
                          aspectRatio: 2,
                          viewportFraction: 1,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex=index;
                            });
                          },
                          ),
        
                    ),
                ),
                Positioned(
                  bottom: 10,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imageList.asMap().entries.map((entry){
                      print(entry);
                      print(entry.key);
                      return GestureDetector(
                        onTap: () => carouselController.animateToPage(entry.key),
                        child: Container(
                          width: currentIndex==entry.key ? 17 : 7,
                          height: 7.0,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 3.0,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: currentIndex==entry.key
                            ? Colors.red 
                            :Colors.teal ,
                          ),
                        ),
                      );
                    }).toList(),
                  )
                  )
              ],
            ),
            Padding(padding: EdgeInsets.all(10)),
            Text("Executive Committee",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
            ),
            Padding(padding: EdgeInsets.all(10)),
            SingleChildScrollView(),
            ListView(
              shrinkWrap: true,
          children:  [
            ExpansionTile(
              leading:
            CircleAvatar(child: Image.asset('assets/images/1.jpg')),
            title: Text("Munavar Hafiz"),
        
            children: [
              Text('He is the chairman of majlis wafy college'),
              Text('E-mail: munnu@gmail.com'),
            ],
        
            expandedAlignment: Alignment.center,
            onExpansionChanged: (bool expaned){
              if (expaned){
                print('List is expaned');
              }else{
                print('List is collapsed');
              }
            },
            ),
            ExpansionTile(
              leading:
            CircleAvatar(child: Image.asset('assets/images/1.jpg')),
            title: Text("Yaseen MT"),
        
            children: [
              Text('He is the secratery of majlis wafy college'),
              Text('E-mail: yaseen@gmail.com'),
            ],
        
            expandedAlignment: Alignment.center,
            onExpansionChanged: (bool expaned){
              if (expaned){
                print('List is expaned');
              }else{
                print('List is collapsed');
              }
            },
            ),
            ExpansionTile(
              leading:
            CircleAvatar(child: Image.asset('assets/images/1.jpg')),
            title: Text("Khaleel Jibran"),
        
            children: [
              Text('He is the treasurer of majlis wafy college'),
              Text('E-mail: jibran@gmail.com'),
            ],
        
            expandedAlignment: Alignment.center,
            onExpansionChanged: (bool expaned){
              if (expaned){
                print('List is expaned');
              }else{
                print('List is collapsed');
              }
            },
            ),
            ExpansionTile(
              leading:
            CircleAvatar(child: Image.asset('assets/images/1.jpg')),
            title: Text("Thabsheer"),
        
            children: [
              Text('He is the vice-chairman of majlis wafy college'),
              Text('E-mail: thabsheer@gmail.com'),
            ],
        
            expandedAlignment: Alignment.center,
            onExpansionChanged: (bool expaned){
              if (expaned){
                print('List is expaned');
              }else{
                print('List is collapsed');
              }
            },
            ),
            ExpansionTile(
              leading:
            CircleAvatar(child: Image.asset('assets/images/1.jpg')),
            title: Text("Abshir"),
        
            children: [
              Text('He is the joint-secratery of majlis wafy college'),
              Text('E-mail: abshir@gmail.com'),
            ],
        
            expandedAlignment: Alignment.center,
            onExpansionChanged: (bool expaned){
              if (expaned){
                print('List is expaned');
              }else{
                print('List is collapsed');
              }
            },
            ),
            ExpansionTile(
              leading:
            CircleAvatar(child: Image.asset('assets/images/1.jpg')),
            title: Text("Jazeel AV"),
        
            children: [
              Text('He is the CUC of majlis wafy college'),
              Text('E-mail: jzyl@gmail.com'),
            ],
        
            expandedAlignment: Alignment.center,
            onExpansionChanged: (bool expaned){
              if (expaned){
                print('List is expaned');
              }else{
                print('List is collapsed');
              }
            },
            ),
          ],
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton( 
                    child: Text('Sub-committee'),
                    onPressed: () {
                      Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionSubcommittee(),
            ),
            );
            },
            ),
            ),
           ElevatedButton( 
          child: Text('Activities'),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionACtivity(),
            ),
            );
          },
          ),
              ],
              ),
              ], 
              ),
        ),
    );
  }
}