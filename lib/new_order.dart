import 'package:dispenser_mobile_app/API.dart';
import 'package:dispenser_mobile_app/food_item.dart';
import 'package:dispenser_mobile_app/template.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewOrder extends StatefulWidget {
  const NewOrder({Key? key, required this.token, required this.user})
      : super(key: key);
  final String token;
  final Map<String, dynamic> user;

  @override
  State<NewOrder> createState() => _NewOrderState();
}

class _NewOrderState extends State<NewOrder> {
  List<Map<String, dynamic>> item = [];
  String name = 'Enter a name';

  void editItem(int index, int quantity) {
    if (quantity > 0) {
      setState(() {
        item[index]['quantity'] = quantity;
      });
    } else if (quantity == -1) {
      setState(() {
        item.removeAt(index);
      });
    }
  }

  void addItem(Map<String, dynamic> i) {
    setState(() {
      item.add(i);
    });
  }

  void submit() async {
    final curItem = [...item];

    var itemUUID = '', quantity = '';
    for (var e in curItem) {
      itemUUID += '${e['item']['uuid']},';
      quantity += '${e['quantity']},';
    }
    if (itemUUID.isNotEmpty) {
      itemUUID = itemUUID.substring(0, itemUUID.length - 1);
    }
    if (quantity.isNotEmpty) {
      quantity = quantity.substring(0, quantity.length - 1);
    }
    await request(
      RequestType.putRequest,
      apiURL + '/order/edit_order',
      widget.token,
      body: {
        'name': name,
        'item_uuid': itemUUID,
        'quantity': quantity,
      },
    ).then((value) {
      showMyDialog(context, 'Success', 'Order has successfully been created',
          () {
        Navigator.pushReplacementNamed(context, '/home');
      }, false);
    }).catchError((e) =>
        showMyDialog(context, 'Error', 'Error detail: ${e.toString()}', () {}));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var textFocusNode = FocusNode();
    List<Widget> children = [
      ...item
          .asMap()
          .entries
          .map((e) => FoodItem(
                key: Key(e.key.toString()),
                name: e.value['item']['name'],
                image: e.value['item']['image'],
                price: e.value['item']['price'],
                quantity: e.value['quantity'],
                editQuantity: (quantity) => editItem(e.key, quantity),
              ))
          .toList()
    ];
    children.add(AddMore(
      token: widget.token,
      addAction: (i) => addItem(i),
    ));

    return Template(
      user: widget.user,
      warning: item.isNotEmpty,
      child: Container(
        margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 200,
                  child: TextField(
                    focusNode: textFocusNode,
                    controller: TextEditingController(text: name),
                    onSubmitted: (value) => setState(() {
                      name = value;
                    }),
                    style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.headline2),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.edit, color: Colors.black),
                          onPressed: () => textFocusNode.requestFocus(),
                        )),
                    enabled: true,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      child: Text(
                        'DONE',
                        style: GoogleFonts.poppins(
                            textStyle: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.2,
                        )),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: item.isNotEmpty
                            ? Theme.of(context).primaryColor
                            : Colors.grey,
                        padding: const EdgeInsets.all(5),
                        minimumSize: const Size(50, 25),
                        alignment: Alignment.center,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      onPressed: item.isNotEmpty
                          ? () {
                              submit();
                            }
                          : () {},
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: children,
            ))),
          ],
        ),
      ),
      title: 'Create New Order',
    );
  }
}
