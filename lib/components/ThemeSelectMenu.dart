/*
  بِسْــــــــــــــــــمِ اﷲِالرَّحْمَنِ اارَّحِيم

  Eûzubillâhimineşşeytânirracîym - Bismillâhirrahmânirrahîm

  Rahman ve Rahim olan "Allah" 'ın adıyla
*/

import 'package:spine/components/ShapeWidgetBorder.dart';
import 'package:spine/components/ThemeChangerButton.dart';
import 'package:spine/data/library.dart';
import 'package:spine/localizations.dart';
import 'package:spine/themes/default.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeSelectMenu extends StatelessWidget {
  ThemeSelectMenu({this.padding = 20});

  final double padding;

  @override
  Widget build(BuildContext context) {
    /**
     * Screen size information
     */
    Size size = MediaQuery.of(context).size;

    return Material(
      clipBehavior: Clip.antiAlias,
      shape: ShapedWidgetBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Container(
        padding: EdgeInsets.all(padding),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 250,
            maxHeight: size.height > 400 ? size.height - 200 : 250,
          ),
          child: Scrollbar(
            showTrackOnHover: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ...FlexScheme.values.where((e) => (FlexScheme.custom == e ? false : true)).map((e) {
                    var y = (e).toString().split(".")[1];
                    var x;

                    try {
                      y = FlexColor.schemes[e]!.name;
                      x = Library.darkTheme ? FlexColor.schemes[e]!.dark.primary : FlexColor.schemes[e]!.light.primary;
                    } catch (e) {
                      y = "Özel Tanımlanan";
                    }

                    return ThemChangerButton(text: y, color: x, flexScheme: e);
                  }).toList(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
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
                                Icons.add_to_queue,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Text(
                              AppLocalizations.getTranslate("0053") + " (" + (Library.darkTheme ? AppLocalizations.getTranslate("0055") : AppLocalizations.getTranslate("0054")) + ")",
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Consumer<Notifier>(
                          builder: (context, notifier, child) {
                            return Padding(
                              padding: const EdgeInsets.all(5),
                              child: CupertinoSwitch(
                                activeColor: Theme.of(context).primaryColorDark,
                                value: Library.darkTheme,
                                onChanged: (v) {
                                  !Library.darkTheme ? notifier.setDark() : notifier.setLight();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
