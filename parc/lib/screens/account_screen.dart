import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parc/blocs/authentication_bloc/bloc.dart';
import 'package:parc/blocs/balance_bloc/balance_bloc.dart';
import 'package:parc/util/theme.dart';
import 'package:parc/widgets/balance_dialog.dart';

import '../blocs/balance_bloc/balance_event.dart';
import '../models/user.dart';

import '../widgets/modal_sheet.dart';

class AccountScreen extends StatefulWidget {
  final User _user;

  AccountScreen(this._user);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  TextEditingController _amountController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: appThemeData[AppTheme.Gredient].primaryColorDark,
                  size: 96,
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    " ${widget._user.name}",
                    style: TextStyle(
                      color: appThemeData[AppTheme.Gredient].primaryColorDark,
                      fontSize: 32.0,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "${widget._user.email}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(
                    " ${widget._user.license}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                SizedBox(height: 88),
                Container(
                  child: Text(
                    "${widget._user.balance} ¤",
                    style: TextStyle(
                      color: appThemeData[AppTheme.Gredient].primaryColorDark,
                      fontSize: 64.0,
                      fontFamily: 'Almarai',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).bottomAppBarColor,
        shape: CircularNotchedRectangle(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).iconTheme.color,
                    size: 28,
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => ModalSheet(),
                    );
                  }),
              IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Theme.of(context).iconTheme.color,
                    size: 28,
                  ),
                  onPressed: () {
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(SignedOut());
                  })
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,
          color: Theme.of(context).primaryIconTheme.color,
          size: 28,
        ),
        onPressed: () {
          showDialog<void>(
            context: context,
            builder: (BuildContext context) {
              return BalanceDialog(
                amountController: _amountController,
                onPressed: () {
                  BlocProvider.of<BalanceBloc>(context).add(Recharge(
                      double.parse(_amountController.text) +
                          widget._user.balance));
                  _amountController.clear();
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
