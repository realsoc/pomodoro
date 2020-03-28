import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pomodoro/components/dialogs.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';


class InfosScreen extends StatefulWidget {
  @override
  _InfosScreenState createState() => _InfosScreenState();
}

class _InfosScreenState extends State<InfosScreen>
    with TickerProviderStateMixin{

  AnimationController linkedinController;
  AnimationController instagramController;
  AnimationController emailController;

  @override
  void initState() {
    super.initState();
    linkedinController = AnimationController(
        vsync: this,
    );
    instagramController = AnimationController(
        vsync: this
    );
    emailController = AnimationController(
        vsync: this
    );
  }

  _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text("Qui suis-je ?", style: TextStyle(fontSize: 30),),
            Column(
              children: <Widget>[
                Text("Hugo", style: TextStyle(fontSize: 24),),
                Text("27ans", style: TextStyle(fontSize: 24),),
                Text("Développeur", style: TextStyle(fontSize: 24),),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () => emailController.forward(),
                  child: Lottie.asset('assets/anims/email.json',
                      controller: emailController,
                      onLoaded: (composition) {
                        emailController
                          ..duration = composition.duration
                          ..addStatusListener((status) {
                            if (status == AnimationStatus.completed) {
                              emailController.reset();
                              _launchUrl("mailto:hugo.djemaa@gmail.com?subject=Salut toi&body=");
                            }
                          });
                      },
                      width: 60,
                      height: 60
                  ),
                ),
                SizedBox(width: 32,),
                GestureDetector(
                  onTap: () => instagramController.forward(),
                  child: Lottie.asset('assets/anims/instagram.json',
                      controller: instagramController,
                      onLoaded: (composition) {
                        instagramController
                          ..duration = composition.duration
                          ..addStatusListener((status) {
                            if (status == AnimationStatus.completed) {
                              instagramController.reset();
                              _launchUrl("https://www.instagram.com/hugomadje/");
                            }
                          });
                      },
                      width: 80,
                      height: 80),
                ),
                SizedBox(width: 16,),
                GestureDetector(
                  onTap: () => linkedinController.forward(),
                  child: Lottie.asset('assets/anims/linkedin.json',
                      onLoaded: (composition) {
                        linkedinController
                          ..duration = composition.duration
                          ..addStatusListener((status) {
                            if (status == AnimationStatus.completed) {
                              linkedinController.reset();
                              _launchUrl("https://www.linkedin.com/in/hugo-djemaa-131545a6/");
                            }
                          });
                      },
                      controller: linkedinController,
                      width: 80,
                      height: 80),
                ),
              ],
            ),
            Text("La méthode pomodoro", style: TextStyle(fontSize: 32),),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text("La technique Pomodoro est une technique de gestion du temps développée par Francesco Cirillo à la fin des années 1980",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            FlatButton(
              child: Text("En savoir plus", style: TextStyle(fontSize: 22),),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  side: BorderSide()
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    child: TextDialog(
                      title: null,
                      confirmLabel: "Close",
                      text: "La technique Pomodoro est une technique de gestion du temps développée par Francesco Cirillo à la fin des années 1980. Cette méthode se base sur l'usage d'un minuteur permettant de respecter des périodes de 25 minutes appelées pomodori (qui signifie en italien « tomates »). Ces différentes périodes de travail sont séparées par de courtes pauses. Proches des concepts de cycles itératifs et des méthodes de développement agiles, utilisées dans le développement de logiciel, la méthode est utilisée pour la programmation en binôme. La méthode a pour principale prétention que des pauses régulières favorisent l'agilité intellectuelle. Certains bénéfices des temps de repos sur la consolidation de la mémoire peuvent être observés expérimentalement.",
                    )
                );
              },
            ),
          ],
        )
    );
  }
}
