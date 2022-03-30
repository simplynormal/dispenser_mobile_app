import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SideBar extends StatelessWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget item(String title, IconData icon, Function onTap) {
      return ListTile(
        leading: Icon(
          icon,
          size: 30,
          color: Colors.black,
        ),
        title: Text(
          title,
          style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.headline3),
        ),
        onTap: () => onTap(),
      );
    }

    return Drawer(
      child: Container(
        margin: const EdgeInsets.only(left: 40, right: 40, top: 20, bottom: 50),
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: <Widget>[
                SizedBox(
                  height: 200,
                  child: DrawerHeader(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'images/avt.png',
                          width: 71,
                          height: 71,
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Welcome User!',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Staff ID: 5128654',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
                item('My Profile', Icons.account_circle_outlined, () {
                  Navigator.pop(context);
                }),
                item('Statistics', Icons.add_chart_sharp, () {
                  Navigator.pop(context);
                }),
                item('Order', Icons.assignment_outlined, () {
                  Navigator.pop(context);
                }),
                item('Settings', Icons.settings_outlined, () {
                  Navigator.pop(context);
                }),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton.icon(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(color: Theme.of(context).primaryColor),
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  onPressed: () => {Navigator.pop(context)},
                  icon: const Icon(
                    Icons.logout_rounded,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Log Out',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
    );
  }
}