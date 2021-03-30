// Copyright 2019 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import '../controllers/Auth.dart';
import '../CentralState.dart';
import 'package:provider/provider.dart';

class Intro extends StatefulWidget {
  @override
  State createState() => IntroState();
}

class IntroState extends State<Intro> {
  Widget _buildBody(BuildContext context) {
    Function saveLocalStorage = context.watch<CentralState>().saveLocalStorage;
    Function update = context.watch<CentralState>().update;

    return ElevatedButton(
      child: const Text('SIGN IN'),
      onPressed: () async {
        try {
          String? cookie = await Auth.signIn();
          if (cookie != null) saveLocalStorage("cookie", cookie);
        } catch (enError) {
          update("error", enError);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ConstrainedBox(
      constraints: const BoxConstraints.expand(),
      child: _buildBody(context),
    ));
  }
}
