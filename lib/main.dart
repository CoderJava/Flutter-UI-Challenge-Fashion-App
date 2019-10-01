import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductScreen(),
    );
  }
}

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          WidgetPageViewHeader(),
          Align(
            alignment: Alignment.bottomCenter,
            child: WidgetDescription(),
          ),
          SafeArea(
            minimum: EdgeInsets.only(
              left: 16.0,
              right: 16.0,
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Icon(
                    Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 24.0,
                    height: 24.0,
                    child: Stack(
                      children: <Widget>[
                        Icon(
                          Icons.shopping_basket,
                          color: Colors.white,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            width: 8.0,
                            height: 8.0,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class WidgetPageViewHeader extends StatefulWidget {
  @override
  _WidgetPageViewHeaderState createState() => _WidgetPageViewHeaderState();
}

class _WidgetPageViewHeaderState extends State<WidgetPageViewHeader> {
  final listImageHeader = [
    'assets/images/header_1.jpg',
    'assets/images/header_2.jpg',
    'assets/images/header_3.jpg',
    'assets/images/header_4.jpg',
  ];
  int _indexHeader = 0;

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var heightImage = mediaQuery.size.height / 1.5;
    return Container(
      height: heightImage,
      child: Stack(
        children: <Widget>[
          PageView.builder(
            itemBuilder: (context, index) {
              return Image.asset(
                listImageHeader[index],
                fit: BoxFit.cover,
              );
            },
            itemCount: listImageHeader.length,
            onPageChanged: (index) {
              setState(() {
                _indexHeader = index;
              });
            },
          ),
          Padding(
            padding: EdgeInsets.only(
              top: mediaQuery.size.height / 1.9,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                for (int i = 0; i < listImageHeader.length; i++)
                  if (i == _indexHeader) circleBar(true) else circleBar(false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget circleBar(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 250),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 16 : 12,
      width: isActive ? 16 : 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        border: isActive ? Border.all(color: Colors.white) : null,
      ),
      padding: EdgeInsets.all(isActive ? 4.0 : 0.0),
      child: Container(
        width: isActive ? 8 : 16,
        height: isActive ? 8 : 16,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white,
        ),
      ),
    );
  }
}

class WidgetDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: mediaQuery.size.height / 2.3,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFE0E0E0),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(48.0),
          topRight: Radius.circular(48.0),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 40.0, right: 24.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ListView(
                  padding: EdgeInsets.only(
                      bottom: mediaQuery.size.height -
                          mediaQuery.size.height / 1.1 +
                          16.0),
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildWidgetProductName(context),
                        _buildWidgetProductPrice(context),
                        Padding(
                          padding:
                              const EdgeInsets.only(top: 16.0, bottom: 16.0),
                          child: Divider(
                            height: 2.0,
                            color: Colors.black,
                          ),
                        ),
                        WidgetChooseColor(),
                        SizedBox(height: 16.0),
                        WidgetChooseSize(),
                        _buildWidgetProductInfo(context),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: WidgetAddToBag(),
          ),
        ],
      ),
    );
  }

  Widget _buildWidgetProductPrice(BuildContext context) {
    return Text(
      'Rp 159.000',
      style: Theme.of(context).textTheme.body1.merge(TextStyle(fontSize: 16.0)),
    );
  }

  Widget _buildWidgetProductName(BuildContext context) {
    return Wrap(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                'Y&F Samhita Plain Bodycon\nMini Dress',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Wrap(
              direction: Axis.vertical,
              children: <Widget>[
                Icon(Icons.share),
                SizedBox(height: 16.0),
                Icon(Icons.favorite_border),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWidgetProductInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'This is a beautiful women Mini Dress for your daily look, '
                  'it is elegance meets... ',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .merge(TextStyle(fontSize: 16.0)),
            ),
            TextSpan(
                text: 'More',
                style: Theme.of(context).textTheme.body1.merge(
                      TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
          ],
        ),
      ),
    );
  }
}

class WidgetChooseColor extends StatefulWidget {
  final List<String> colorsName = [
    'Navy',
    'Milo',
    'Maroon',
    'Grey',
  ];
  final List<Color> colors = [
    Color(0xFF221D33),
    Color(0xFFD7BA97),
    Color(0xFF9C606C),
    Color(0xFFA8BCBD),
  ];

  @override
  _WidgetChooseColorState createState() => _WidgetChooseColorState();
}

class _WidgetChooseColorState extends State<WidgetChooseColor> {
  int _indexSelected;

  @override
  void initState() {
    _indexSelected = widget.colors.length - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Color: ',
                style: TextStyle(color: Colors.black87),
              ),
              TextSpan(
                text: widget.colorsName[_indexSelected],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 24.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: widget.colors.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _indexSelected = index;
                      });
                    },
                    child: Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: widget.colors[index],
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: _indexSelected == index ? 4.0 : 0.0,
                        ),
                        boxShadow: [
                          _indexSelected == index
                              ? BoxShadow(
                                  color: Color(0xFF757575),
                                  blurRadius: 5.0,
                                  offset: Offset(0.0, 4.0),
                                )
                              : BoxShadow(),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class WidgetChooseSize extends StatefulWidget {
  final List<String> listSize = [
    'XL',
    'S',
    'M',
    'L',
  ];

  @override
  _WidgetChooseSizeState createState() => _WidgetChooseSizeState();
}

class _WidgetChooseSizeState extends State<WidgetChooseSize> {
  int _indexSelected;

  @override
  void initState() {
    _indexSelected = widget.listSize.length - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Size: ',
                style: TextStyle(color: Colors.black87),
              ),
              TextSpan(
                text: widget.listSize[_indexSelected],
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            height: 24.0,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: NeverScrollableScrollPhysics(),
              reverse: true,
              itemCount: widget.listSize.length,
              itemBuilder: (context, index) {
                return Row(
                  children: <Widget>[
                    Text(widget.listSize[index]),
                    Radio(
                      value: index,
                      groupValue: _indexSelected,
                      activeColor: Color(0xFF32312D),
                      onChanged: (index) {
                        setState(() {
                          _indexSelected = index;
                        });
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class WidgetAddToBag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    return Container(
      height: (mediaQuery.size.height - mediaQuery.size.height / 1.1),
      child: Material(
        type: MaterialType.canvas,
        color: Color(0xFF32312D),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(36.0),
          topRight: Radius.circular(36.0),
        ),
        child: InkWell(
          onTap: () {
            showBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return WidgetMyCart();
              },
            );
          },
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'Add to bag +',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
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
}

class WidgetMyCart extends StatefulWidget {
  @override
  _WidgetMyCartState createState() => _WidgetMyCartState();
}

class _WidgetMyCartState extends State<WidgetMyCart> {
  List<Cart> listMyCart = [];

  @override
  void initState() {
    listMyCart
      ..add(Cart(
          productName: 'Haicila Two Tone V-neck Blouse',
          price: 89000,
          size: 'M',
          quantity: 1,
          color: 'Black',
          image: 'assets/images/img_item_cart_1.jpeg'))
      ..add(Cart(
          productName: 'Y&F Samhita Plain Bodycon',
          price: 159000,
          size: 'L',
          quantity: 1,
          color: 'Maroon',
          image: 'assets/images/header_1.jpg'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: Container(
        height: mediaQuery.height / 2.0,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(48.0),
            topRight: Radius.circular(48.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            top: 40.0,
            right: 24.0,
            bottom: 20.0,
          ),
          child: Column(
            children: <Widget>[
              _buildWidgetHeaderMyCart(context),
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Divider(
                  height: 2.0,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: listMyCart.length,
                  itemBuilder: (context, index) {
                    Cart cart = listMyCart[index];
                    String rupiahPrice =
                        NumberFormat('#,##0', 'id_ID').format(cart.price);
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.asset(
                            cart.image,
                            width: 48.0,
                            height: 48.0,
                          ),
                          SizedBox(width: 8.0),
                          Expanded(
                            child: Wrap(
                              direction: Axis.vertical,
                              children: <Widget>[
                                Text(
                                  cart.productName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .merge(TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                                Text(
                                  'Rp $rupiahPrice',
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .merge(TextStyle(fontSize: 12.0)),
                                ),
                                Text(
                                  'Size: ${cart.size}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .body1
                                      .merge(TextStyle(
                                        fontSize: 12.0,
                                        color: Colors.grey,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          WidgetControllerQuantity(cart.quantity),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      height: 2.0,
                      color: Colors.grey,
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Divider(
                  thickness: 2.0,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Total amount',
                      style: Theme.of(context).textTheme.body1.merge(
                            TextStyle(color: Colors.grey),
                          )),
                  Text('Rp 248.000',
                      style: Theme.of(context).textTheme.body1.merge(
                            TextStyle(fontWeight: FontWeight.w600),
                          )),
                ],
              ),
              SizedBox(height: 8.0),
              SizedBox(
                width: mediaQuery.width,
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'Check out',
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  color: Color(0xFF32312D),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWidgetHeaderMyCart(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          'My Cart',
          style: Theme.of(context).textTheme.body1.merge(TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
              )),
        ),
        Text('2 items', style: Theme.of(context).textTheme.caption),
      ],
    );
  }
}

class WidgetControllerQuantity extends StatefulWidget {
  final int qty;

  WidgetControllerQuantity(this.qty);

  @override
  _WidgetControllerQuantityState createState() =>
      _WidgetControllerQuantityState();
}

class _WidgetControllerQuantityState extends State<WidgetControllerQuantity> {
  int qty;

  @override
  void initState() {
    qty = widget.qty;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            if (qty == 1) return;
            setState(() {
              qty -= 1;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.remove,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
        ),
        Text('$qty'),
        GestureDetector(
          onTap: () {
            if (qty == 10) return;
            setState(() {
              qty += 1;
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.add,
              size: 20.0,
              color: Colors.black54,
            ),
          ),
        ),
      ],
    );
  }
}

class Cart {
  String productName;
  int price;
  String size;
  int quantity;
  String color;
  String image;

  Cart(
      {this.productName,
      this.price,
      this.size,
      this.quantity,
      this.color,
      this.image});
}
