import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

Future<void> main() async {
  // Pastikan Flutter binding diinisialisasi sebelum menjalankan kode async.
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Supabase dengan URL dan kunci anon.
  await Supabase.initialize(
    url: 'https://erubfcbwapiusrkntekz.supabase.co', // Ganti dengan URL Supabase Anda.
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVydWJmY2J3YXBpdXNya250ZWt6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3MjY4NDgsImV4cCI6MjA0NzMwMjg0OH0.oq_jnOd3KVeV_ICFnp_80jJgghqIuCP21zpD1y1LS0s',
  );

  // Jalankan aplikasi Flutter.
  runApp(const MyApp());
}

// Kelas utama aplikasi.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Digital Library', // Judul aplikasi.
      home: BookListPage(), // Halaman utama.
      debugShowCheckedModeBanner: false, // Menonaktifkan banner debug.
    );
  }
}