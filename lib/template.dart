import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dispenser_mobile_app/sidebar.dart';

class Template extends StatefulWidget {
  const Template({
    Key? key,
    required this.user,
    required this.child,
    required this.title,
    this.isDrawer = false,
    this.warning = false,
    this.profile = true,
  }) : super(key: key);
  final Map<String, dynamic> user;
  final Widget child;
  final String title;
  final bool isDrawer;
  final bool warning;
  final bool profile;

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  TextEditingController editingController = TextEditingController();

  void _alertCancel(BuildContext context, VoidCallback pop) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: const Text("Warning!"),
            content:
                const Text('If you go back, you will lose all your changes.'),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  pop();
                  Navigator.pop(context);
                },
                child: const Text('Yes'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('No'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Center(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
        leading: widget.isDrawer
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.menu_rounded,
                    color: Colors.black,
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : Builder(
                builder: (context) => IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: widget.warning
                      ? () =>
                          _alertCancel(context, () => Navigator.pop(context))
                      : () => Navigator.pop(context),
                ),
              ),
        actions: <Widget>[
          IconButton(
            icon: Image.asset('images/avt.png'),
            onPressed: widget.profile
                ? () {
                    Navigator.pushNamed(context, '/profile');
                  }
                : () {},
          )
        ],
        backgroundColor: Theme.of(context).backgroundColor,
        elevation: 0,
      ),
      drawer: SideBar(
        user: widget.user,
      ),
      body: widget.child,
      drawerEnableOpenDragGesture: false,
    );
  }
}
