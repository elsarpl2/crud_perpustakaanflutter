import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:crud_perpustakaan/home_page.dart';

// Widget untuk halaman menambah buku
class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  // GlobalKey digunakan untuk validasi form
  final _formKey = GlobalKey<FormState>();

  // Controller untuk masing-masing input form
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Fungsi untuk menambah buku ke database Supabase
  Future<void> _addBook() async {
    // Memastikan form sudah valid sebelum data dikirim
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text; // Mendapatkan judul buku
      final author = _authorController.text; // Mendapatkan penulis buku
      final description = _descriptionController.text; // Mendapatkan deskripsi buku

      try {
        // Mengirim data ke Supabase dengan kolom yang sesuai dengan nama tabel 'buku'
        final response = await Supabase.instance.client
            .from('buku') // Nama tabel di Supabase
            .insert({
              'judul': title, // Nama kolom sesuai dengan tabel di Supabase
              'penulis': author, // Nama kolom sesuai dengan tabel di Supabase
              'deskripsi': description, // Nama kolom sesuai dengan tabel di Supabase
            })
            .select(); // Memastikan data dikirim

        // Jika berhasil, tampilkan pesan sukses
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Buku berhasil ditambahkan')),
        );

        // Kosongkan input field setelah data berhasil dikirim
        _titleController.clear();
        _authorController.clear();
        _descriptionController.clear();

        // Navigasi kembali ke halaman utama (HomePage)
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const BookListPage()), // Navigasi ke halaman daftar buku
        );
      } catch (e) {
        // Jika terjadi error, tampilkan pesan error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error occurred: $e'), // Menampilkan error jika terjadi masalah
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Book'), // Judul halaman
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Padding di sekitar form
        child: Form(
          key: _formKey, // GlobalKey untuk form validation
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, // Menjaga lebar form full
            children: [
              // Input field untuk judul buku
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'), // Label untuk input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Book title cannot be blank'; // Validasi jika judul kosong
                  }
                  return null;
                },
              ),
              // Input field untuk penulis buku
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Author'), // Label untuk input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The author of the book must not be empty'; // Validasi jika penulis kosong
                  }
                  return null;
                },
              ),
              // Input field untuk deskripsi buku
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'), // Label untuk input
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Book description must not be empty'; // Validasi jika deskripsi kosong
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20), // Jarak antara input dan tombol
              // Tombol untuk menyimpan buku
              ElevatedButton(
                onPressed: _addBook, // Fungsi yang dipanggil ketika tombol ditekan
                child: const Text('Tambah Data'), // Teks tombol
              ),
            ],
          ),
        ),
      ),
    );
  }
}
