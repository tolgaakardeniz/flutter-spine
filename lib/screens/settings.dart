/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'dart:async';

import 'package:clay_containers/clay_containers.dart';
import 'package:spine/animations/FadeIn.dart';
import 'package:spine/animations/FadeInDown.dart';
import 'package:spine/animations/FadeInUp.dart';
import 'package:spine/clippers/background.dart';
import 'package:spine/components/ImageLoader.dart';
import 'package:spine/components/RoundedButton.dart';
import 'package:spine/components/RoundedInputField.dart';
import 'package:spine/components/RoundedPasswordField.dart';
import 'package:spine/components/SettingsMenu.dart';
import 'package:spine/constants.dart';
import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:spine/themes/default.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/SettingsScreen';

  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with RouteAware {
  late dynamic parentObject;
  final String screenName = "SettingsScreen";
  late int screenCount;

  /// for listview
  int selectedMenuItem = 0;

  /// for user gender
  bool genderStatus = false;


  /// for notifications
  List<Map<String, dynamic>> notifications = [
    {"title": "0037", "status": false, "icon": Icons.person_add_alt_1_rounded},
    {"title": "0038", "status": false, "icon": Icons.person_remove_alt_1_rounded},
    {"title": "0039", "status": false, "icon": Icons.favorite},
    {"title": "0040", "status": false, "icon": Icons.block},
    {"title": "0041", "status": false, "icon": Icons.comment},
    {"title": "0042", "status": false, "icon": Icons.login_rounded},
    {"title": "0043", "status": false, "icon": Icons.logout},
    {"title": "0044", "status": false, "icon": Icons.security},
  ];

  List<PlutoColumn> columns = [
    /// Text Column definition
    PlutoColumn(
      title: "",
      field: 'text_field',
      type: PlutoColumnType.text(),
      enableRowChecked: true,
    ),

    /// Number Column definition
    PlutoColumn(
      title: 'number column',
      field: 'number_field',
      type: PlutoColumnType.number(),
    ),

    /// Select Column definition
    PlutoColumn(
      title: 'select column',
      field: 'select_field',
      type: PlutoColumnType.select(['item1', 'item2', 'item3']),
    ),

    /// Datetime Column definition
    PlutoColumn(
      title: 'date column',
      field: 'date_field',
      type: PlutoColumnType.date(),
    ),

    /// Time Column definition
    PlutoColumn(
      title: 'time column',
      field: 'time_field',
      type: PlutoColumnType.time(),
    ),
  ];

  List<PlutoRow> rows = [
    PlutoRow(
      cells: {
        'text_field': PlutoCell(value: ''),
        'number_field': PlutoCell(value: 2020),
        'select_field': PlutoCell(value: 'item1'),
        'date_field': PlutoCell(value: '2020-08-06'),
        'time_field': PlutoCell(value: '12:30'),
      },
    ),
    PlutoRow(
      cells: {
        'text_field': PlutoCell(value: ''),
        'number_field': PlutoCell(value: 2021),
        'select_field': PlutoCell(value: 'item2'),
        'date_field': PlutoCell(value: '2020-08-07'),
        'time_field': PlutoCell(value: '18:45'),
      },
    ),
    PlutoRow(
      cells: {
        'text_field': PlutoCell(value: ''),
        'number_field': PlutoCell(value: 2022),
        'select_field': PlutoCell(value: 'item3'),
        'date_field': PlutoCell(value: '2020-08-08'),
        'time_field': PlutoCell(value: '23:59'),
      },
    ),
  ];

  void reBuild() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => super.widget));

    print("reBuild: " + screenName);
  }

  /// if you want to refresh state please call this function
  void refreshState() {
    setState(() {
      Library.debugPrint("SettingsScreen widget setState is was now run");
    });

    print("refreshState: " + screenName);
  }

  @override
  void didChangeDependencies() {
    print("didChangeDependencies : " + screenName);

    try {
      final arguments = ModalRoute.of(context)!.settings.arguments as dynamic;
      parentObject = arguments["parentObject"];
    } catch (e) {
      Library.debugPrint(e);
    }

    Library.globalData["RouteObserver"].subscribe(this, ModalRoute.of(context)!);
    super.didChangeDependencies();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    print("didPush: " + screenName);
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    print("didPopNext: " + screenName);

    /**
     * Refresh status when it comes back
     */
    refreshState();
  }

  @override
  void dispose() {
    Library.globalData["RouteObserver"].unsubscribe(this);

    print("dispose: " + screenName);

    /**
     * Remove in map list
     */
    Library.globalData["widgetList"].remove(screenCount);
    Library.globalData["widgetNameList"][screenName].remove(screenCount);

    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SettingsScreen oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget == oldWidget) {
      // TODO: start a transition between the previous and new value
    }

    print("didUpdateWidget: " + screenName);
  }

  @override
  void initState() {
    super.initState();


    /**
     * Ana widget sınıfını widgets listesinin içine ekle
     * Add this widget in widgets map lists
     */
    Library.globalData["widgetListCount"]++;
    screenCount = Library.globalData["widgetListCount"];

    /**
     * Bu widget için map oluştur
     */
    Library.globalData["widgetList"][screenCount] = <dynamic, dynamic>{};

    /**
     * Ad listesine ekle
     */
    if (!Library.globalData["widgetNameList"].containsKey(screenName)) {
      Library.globalData["widgetNameList"][screenName] = [];
    }

    Library.globalData["widgetNameList"][screenName].add(screenCount);

    /**
     * Class
     */
    Library.globalData["widgetList"][screenCount]["class"] = this;

    /**
     * Aktif wiget adı
     */
    Library.globalData["widgetList"][screenCount]["name"] = screenName;

    /**
     * Bu widget için animasyon kontrolcülerinin ekleneceği bir "map" oluştur
     * Create a map to add animation controllers for this widget
     */
    Library.globalData["widgetList"][screenCount]["animations"] = <dynamic, dynamic>{};

    print("initState: " + screenName);
  }

  @override
  Widget build(BuildContext context) {
    /**
     * Screen size information
     */
    Size size = MediaQuery.of(context).size;



    return WillPopScope(
      onWillPop: () {
        backPage();

        //We need to return a future
        return Future.value(false);
      },
      child: Scaffold(
        /**
         * true olduğunda TextField tıklandığında klavye çıkıyor ve ekranı yukarı kaydırmıyor
         */
        /*resizeToAvoidBottomInset: false,*/
        body: Container(
          width: size.width,
          height: size.height,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                child: FadeInDown(
                  parentObject: this,
                  startDuration: Duration(milliseconds: 0),
                  child: Container(
                    width: size.width,
                    child: ClipPath(
                      clipper: BackgroundClipper(),
                      child: Container(
                        height: 350,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomRight,
                            colors: [
                              Theme.of(context).primaryColorDark,
                              Theme.of(context).primaryColor,
                              Theme.of(context).primaryColorLight,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Scrollbar(
                    showTrackOnHover: true,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        /*mainAxisSize: MainAxisSize.min,*/
                        children: [
                          Container(
                            width: maxSize(size.width, 1440),
                            height: 400,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
                              child: Container(
                                child: Stack(
                                  children: [
                                    if (Provider.of<Notifier>(context).user.avatar != null)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          image: DecorationImage(
                                            image: NetworkImage(Provider.of<Notifier>(context).user.background.toString()),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    if (Provider.of<Notifier>(context).user.avatar == null)
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          image: DecorationImage(
                                            image: AssetImage("assets/images/gradient.jpg"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Colors.black.withOpacity(0.5),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          child: Center(
                                            child: SizedBox(
                                              width: 200,
                                              height: 150,
                                              child: Stack(
                                                fit: StackFit.expand,
                                                children: [
                                                  if (Provider.of<Notifier>(context).user.avatar != null)
                                                    AnimatedContainer(
                                                      duration: Duration(milliseconds: 500),
                                                      curve: Curves.easeInOut,
                                                      width: 200,
                                                      height: 150,
                                                      child: ImageLoader(
                                                        imageUrl: Provider.of<Notifier>(context).user.avatar.toString(),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                            color: Colors.white.withOpacity(0.7),
                                                            width: 7,
                                                          ),
                                                          shape: BoxShape.circle,
                                                          color: Colors.transparent,
                                                          boxShadow: <BoxShadow>[
                                                            BoxShadow(
                                                              color: Colors.black.withOpacity(0.5),
                                                              offset: Offset(1.0, 6.0),
                                                              blurRadius: 40.0,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  if (Provider.of<Notifier>(context).user.avatar == null)
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(30),
                                                        image: DecorationImage(
                                                          image: AssetImage("assets/images/gradient.jpg"),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                  Positioned(
                                                    bottom: 0,
                                                    right: 20,
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        backPage();
                                                      },
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(5),
                                                        child: Icon(
                                                          Icons.photo_camera,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      style: ElevatedButton.styleFrom(
                                                        shape: CircleBorder(),
                                                        padding: EdgeInsets.all(15),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Container(
                                            child: Text(
                                              Provider.of<Notifier>(context).user.userName,
                                              style: Library.textStyle.copyWith(
                                                fontWeight: FontWeight.w900,
                                                color: Theme.of(context).indicatorColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            child: Text(
                                              Provider.of<Notifier>(context).user.firstName,
                                              style: Library.textStyle.copyWith(
                                                color: Theme.of(context).indicatorColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      right: 20,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          backPage();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Icon(
                                            Icons.photo_camera,
                                            color: Colors.white,
                                          ),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          padding: EdgeInsets.all(15),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SettingsMenu(
                            position: selectedMenuItem,
                            parentObject: this,
                          ),
                          if (selectedMenuItem == 0)
                            Center(
                              child: FadeIn(
                                parentObject: this,
                                child: Container(
                                  width: maxSize(size.width, 1440),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Theme.of(context).backgroundColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 20,
                                            spreadRadius: 0,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppLocalizations.getTranslate("0021"),
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          RoundedInputField(
                                            controller: TextEditingController(text: Provider.of<Notifier>(context).user.firstName),
                                            labelText: AppLocalizations.getTranslate("0022"),
                                            hintText: AppLocalizations.getTranslate("0022"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RoundedInputField(
                                            controller: TextEditingController(text: Provider.of<Notifier>(context).user.userName),
                                            labelText: AppLocalizations.getTranslate("0002"),
                                            hintText: AppLocalizations.getTranslate("0002"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RoundedInputField(
                                            controller: TextEditingController(text: Provider.of<Notifier>(context).user.email),
                                            labelText: AppLocalizations.getTranslate("0023"),
                                            hintText: AppLocalizations.getTranslate("0023"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              RoundedButton(text: AppLocalizations.getTranslate("0024")),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 0,
                          ),
                          if (selectedMenuItem == 1)
                            Center(
                              child: FadeIn(
                                parentObject: this,
                                child: Container(
                                  width: maxSize(size.width, 1440),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Theme.of(context).backgroundColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 20,
                                            spreadRadius: 0,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppLocalizations.getTranslate("0025"),
                                            style: Theme.of(context).textTheme.headline6,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          RoundedPasswordField(
                                            labelText: AppLocalizations.getTranslate("0026"),
                                            hintText: AppLocalizations.getTranslate("0026"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RoundedPasswordField(
                                            labelText: AppLocalizations.getTranslate("0027"),
                                            hintText: AppLocalizations.getTranslate("0027"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              RoundedButton(text: AppLocalizations.getTranslate("0024")),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 0,
                          ),
                          if (selectedMenuItem == 2)
                            Center(
                              child: FadeIn(
                                parentObject: this,
                                child: Container(
                                  width: maxSize(size.width, 1440),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Theme.of(context).backgroundColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 20,
                                            spreadRadius: 0,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            AppLocalizations.getTranslate("0050"),
                                            style: Theme.of(context).textTheme.headline6,
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          RoundedInputField(
                                            labelText: AppLocalizations.getTranslate("0047"),
                                            hintText: AppLocalizations.getTranslate("0047"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RoundedInputField(
                                            labelText: AppLocalizations.getTranslate("0048"),
                                            hintText: AppLocalizations.getTranslate("0048"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          RoundedInputField(
                                            labelText: AppLocalizations.getTranslate("0049"),
                                            hintText: AppLocalizations.getTranslate("0049"),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 10),
                                            child: Container(
                                              padding: EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(30),
                                                color: Theme.of(context).hoverColor,
                                              ),
                                              child: Row(
                                                children: [
                                                  ConstrainedBox(
                                                    constraints: BoxConstraints(
                                                      minWidth: 60,
                                                    ),
                                                    child: Center(
                                                      child: Container(
                                                        padding: EdgeInsets.all(10),
                                                        decoration: BoxDecoration(
                                                          color: Theme.of(context).backgroundColor,
                                                          borderRadius: BorderRadius.circular(30),
                                                        ),
                                                        child: Icon(
                                                          Icons.accessibility,
                                                          color: Theme.of(context).primaryColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      child: Text(
                                                        AppLocalizations.getTranslate("0028"),
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5),
                                                    child: CupertinoSwitch(
                                                      activeColor: Theme.of(context).primaryColorDark,
                                                      value: genderStatus,
                                                      onChanged: (x) {
                                                        genderStatus = x;
                                                        refreshState();
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Spacer(),
                                              RoundedButton(text: AppLocalizations.getTranslate("0024")),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 0,
                          ),
                          if (selectedMenuItem == 3)
                            Center(
                              child: FadeIn(
                                parentObject: this,
                                child: Container(
                                  width: maxSize(size.width, 1440),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Theme.of(context).backgroundColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 20,
                                            spreadRadius: 0,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        height: 400,
                                        padding: const EdgeInsets.all(30),
                                        child: PlutoGrid(
                                            columns: columns,
                                            rows: rows,
                                            onChanged: (PlutoGridOnChangedEvent event) {
                                              print(event);
                                            },
                                            onLoaded: (PlutoGridOnLoadedEvent event) {
                                              print(event);
                                            }),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 0,
                          ),
                          if (selectedMenuItem == 5)
                            Center(
                              child: FadeIn(
                                parentObject: this,
                                child: Container(
                                  width: maxSize(size.width, 1440),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        color: Theme.of(context).backgroundColor,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.2),
                                            blurRadius: 20,
                                            spreadRadius: 0,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          for (int x = 0; x < notifications.length; x++)
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 10),
                                              child: Container(
                                                padding: EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(30),
                                                  color: Theme.of(context).hoverColor,
                                                ),
                                                child: Row(
                                                  children: [
                                                    ConstrainedBox(
                                                      constraints: BoxConstraints(
                                                        minWidth: 60,
                                                      ),
                                                      child: Center(
                                                        child: Container(
                                                          padding: EdgeInsets.all(10),
                                                          decoration: BoxDecoration(
                                                            color: Theme.of(context).backgroundColor,
                                                            borderRadius: BorderRadius.circular(30),
                                                          ),
                                                          child: Icon(
                                                            notifications[x]["icon"],
                                                            color: Theme.of(context).primaryColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        child: Text(
                                                          AppLocalizations.getTranslate(notifications[x]["title"]),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(5),
                                                      child: CupertinoSwitch(
                                                        activeColor: Theme.of(context).primaryColorDark,
                                                        value: notifications[x]["status"],
                                                        onChanged: (v) {
                                                          notifications[x]["status"] = v;
                                                          refreshState();
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: 50,
                          ),
/*                          Container(
                            width: maxSize(size.width, 576),
                            padding: const EdgeInsets.all(20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(30),
                                    child: Material(
                                      color:
                                          Theme.of(context).primaryColorLight,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Icon(
                                                Icons.notifications_none,
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: Text(
                                                  "Bildirim Ayarları",
                                                  style: Library.textStyle
                                                      .copyWith(
                                                          color: Theme.of(
                                                                  context)
                                                              .indicatorColor),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Theme.of(context)
                                                    .indicatorColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: 30,
                child: SafeArea(
                  bottom: false,
                  child: Center(
                    child: FadeInUp(
                      parentObject: this,
                      startDuration: Duration(milliseconds: 700),
                      child: ClayContainer(
                        borderRadius: 30,
                        color: Theme.of(context).buttonColor,
                        depth: 20,
                        spread: 0,
                        curveType: CurveType.convex,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                backPage();
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Icon(
                                  Icons.arrow_back,
                                  color: Theme.of(context).indicatorColor,
                                  size: 32,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  /// Animasyonları geri döndürme bölümü
  /// The section for reverting animations
  Future<void> reverseAnimation() async {
    try {
      Library.globalData["widgetList"][screenCount]["animations"].forEach((k, v) async {
        switch (v["animationController"].status) {
          case AnimationStatus.completed:
            var s = v["startDuration"].toString().split('.')[0];
            var m = v["startDuration"].toString().split('.')[1];
            var x = int.parse(s.substring(s.length - 1) + "" + m) - 500000;
            x = x > 0 ? x : 0;
            Timer(Duration(microseconds: x), () async {
              await v["animationController"].reverse();
            });
            break;
          default:
        }
      });
    } catch (e) {
      Library.debugPrint(e);
    }
  }

  /// Animasyonları ileri döndürme bölümü
  /// The section for forwarding animations
  Future<void> forwardAnimation() async {
    try {
      Library.globalData["widgetList"][screenCount]["animations"].forEach((k, v) async {
        switch (v["animationController"].status) {
          case AnimationStatus.dismissed:
          case AnimationStatus.reverse:
            Timer(v["startDuration"], () async {
              await v["animationController"].forward().orCancel;
            });
            break;
          default:
        }
      });
    } catch (e) {
      Library.debugPrint(e);
    }
  }

  void backPage() {
    try {
      /**
       * Set screen count
       */
      var x = parentObject.screenCount;

      /**
       * Reverse all animations
       */
      reverseAnimation();

      /**
       * Then back to previous page
       */
      Timer(Duration(milliseconds: 500), () {
        /**
         * Close this page first
         */
        Navigator.of(context).pop(this);

        /**
         * Print this page name
         */
        print("Back to " + Library.globalData["widgetList"][x]["name"]);

        /**
         * Run to forwardAnimation function in previous page
         */
        Library.globalData["widgetList"][x]["class"].forwardAnimation();
      });
    } catch (e) {
      Library.debugPrint(e);
    }
  }
}