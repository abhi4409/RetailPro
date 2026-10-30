import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'Supabase/Supabaseini.dart';
import 'Viewmodels/addpro_viewmodel.dart';
import 'Viewmodels/addtobill_viewmodel.dart';
import 'Viewmodels/changepass_viewmodel.dart';
import 'Viewmodels/dashboard_viewmodel.dart';
import 'Viewmodels/instock_viewmodel.dart';
import 'Viewmodels/inventory_viewmodel.dart';
import 'Viewmodels/login_viewmodel.dart';
import 'Viewmodels/lowstock_viewmodel.dart';
import 'Viewmodels/profile_viewmodel.dart';
import 'Viewmodels/purchase_viewmodel.dart';
import 'Viewmodels/purchaselist_viewmodel.dart';
import 'Viewmodels/staffapproval_viewmodel.dart';
import 'Viewmodels/viewbill_viewmodel.dart';
import 'firebase_options.dart';
import 'View/inventory/Editpro.dart';
import 'View/login/Splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (SupabaseConfig.url.isNotEmpty && SupabaseConfig.anonKey.isNotEmpty) {
    try {
      await Supabase.initialize(
        url: SupabaseConfig.url,
        anonKey: SupabaseConfig.anonKey,
      );
    } catch (_) {}
  }

  runApp(
    Proclass(),
  );
}

class Proclass extends StatefulWidget {
  Proclass({
    super.key,
  });

  @override
  State<Proclass> createState() => _ProclassState();
}

class _ProclassState extends State<Proclass> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => DashboardViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddtobillViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ViewbillViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PurchaseViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => PurchaseListViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => AddproViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => InventoryViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => InstockViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LowstockViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => StaffApprovalViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProfileViewmodel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChangePasswordViewmodel(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          "edit": (context) => Editp(),
        },
        home: Spla(),
      ),
    );
  }
}