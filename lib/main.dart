import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterapp/blocs/apiBloc.dart';
import 'package:flutterapp/models/apiModel.dart';
import 'package:page_indicator/page_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<ApiBloc>(
          create:(_)=> ApiBloc(),
          child: MyHomePage(title: 'Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiBloc _bloc ;
  PageController controller;
  GlobalKey<PageContainerState> key ;
@override
  void initState() {
  _bloc = BlocProvider.of<ApiBloc>(context);
    // TODO: implement initState
    super.initState();
  controller = PageController();
  key = GlobalKey();
  }
  var height ;
  var width ;

  @override
  Widget build(BuildContext context) {
     height = MediaQuery.of(context).size.height;
     width = MediaQuery.of(context).size.width;
     _bloc.add(ApiEvent());
    return Scaffold(
      body: Stack(
          children: <Widget>[
            ApiListener(),
          ],
        ),
      );
  }
  Widget ApiListener (){
  return BlocBuilder<ApiBloc , ApiState>(
    builder: (context , ApiState state){
      if (state.state==resultState.Loading){
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      else if (state.state==resultState.Loaded){
        return   getContent(state.model);
      }
      else if (state.state==resultState.Error){
        return Container();

      }
      return Container();
    },
  );
  }
  viewer (List<String> images){
    return  Stack(
        children: <Widget>[
          SizedBox(height: 7,),
          Container(
            height: height*.25,
            width: width,
            child: PageIndicatorContainer(
              indicatorSelectorColor: Colors.white,
              indicatorColor: Colors.grey,
              key: key,
              align: IndicatorAlign.bottom,
              length: 4,
              indicatorSpace: 10.0,
              shape: IndicatorShape.circle(size: 10),
              child: PageView(
                controller: controller,
                reverse: true,
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Image.network(images[0],width: width,height: height*.25,scale: .5,fit: BoxFit.cover),
                  Image.network(images[1],width: width,height: height*.25,scale: .5,fit: BoxFit.cover),
                  Image.network(images[2],width: width,height: height*.25,scale: .5,fit: BoxFit.cover),
                  Image.network(images[3],width: width,height: height*.25,scale: .5, fit: BoxFit.cover,)

                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Icon(Icons.star_border, color: Colors.white,size: 40,),
              Icon(Icons.share,color:Colors.white,size: 40,),
              Spacer(),
              Icon(Icons.arrow_forward_ios , color: Colors.white,size: 40,),
            ],
          ),
        ]);
  }
  getContent (apiModel model){
    return Column(
      children: <Widget>[
       viewer(model.img),
         Container(
            alignment: Alignment.topRight,
            height: height * .12,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right :8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text( '#موسيقى',textDirection: TextDirection.rtl,style: headLineStyle(),),
                      Text( model.title,textDirection: TextDirection.rtl,style: LineStyle()),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(model.date,textDirection: TextDirection.rtl,style: LineStyle()),
                        Icon(Icons.date_range,textDirection: TextDirection.rtl),
                      ],),
                      Row(
                        children: <Widget>[
                          Text(model.address, textDirection: TextDirection.rtl,style: LineStyle()),
                          Icon(Icons.content_paste),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.blueGrey),
            ),
          ),
        ),
        Container(
          height: height * .10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right :8.0),
                        child: Text(model.trainerName,style: headLineStyle()),
                      ),
                      CircleAvatar(backgroundImage: NetworkImage('https://skillzycp.com/upload/trainer/389_BaseImage_636896408382239890.jpg'),),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right :24.0),
                    child: Text(model.trainerInfo,style: headLineStyle()),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
        ),
          Flexible(
            child: Container(
            height: height * .40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding : EdgeInsets.only(right:8),
                    child : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text('عن الدورة', textDirection: TextDirection.rtl, textAlign: TextAlign.right,style: headLineStyle()),
                    Text(model.occasionDetail.trim(), textDirection: TextDirection.rtl, textAlign: TextAlign.right,style: LineStyle()),
                  ],
                ))
              ],
            ),
        ),
          ),
        Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey),
            ),
          ),
        ),
        Text('تكلفة الدورة', textDirection: TextDirection.rtl,style: headLineStyle()),
        Container(
            width: width,
            alignment: Alignment.topRight,
            height: height*.10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: <Widget>[
                      Text('SAR 40 ',style: LineStyle()),
                      Text('SAR 80',style: LineStyle()),
                      Text('SAR 120',style: LineStyle()),

                    ],
                  ),
                ),
                   Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right :16.0),
                  child: Column(
                    children: <Widget>[
                      Text('الحجز العادى',style: LineStyle()),
                      Text('الحجز المميز',style: LineStyle()),
                      Text('الحجز السريع',style: LineStyle()),

                    ],
                  ),
                ),
                  ],
                ),

    ),
        Align(
          alignment: FractionalOffset.bottomCenter,
          child: Container(
            height: height *.05,
            width: width ,
            child: Container(
              alignment: Alignment.center,
              color: Colors.purple,
              child: Text(
                'قم بالحجز الأن ',
                style: TextStyle(
                    color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
  TextStyle headLineStyle(){
    return TextStyle(color: Colors.grey , fontWeight: FontWeight.bold , fontSize: 20);
  }
  TextStyle LineStyle(){
    return TextStyle(color: Colors.grey , fontWeight: FontWeight.normal , fontSize: 12);
  }
  TextStyle borderStyle(){
    return TextStyle(color: Colors.blueGrey , fontWeight: FontWeight.normal , fontSize: 10);
  }
}
