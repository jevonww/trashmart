import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final supabase = Supabase.instance.client;
  List<dynamic> users = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  // ===========================================
  // GET USER DARI TABEL profiles
  // ===========================================
  Future<void> fetchUsers() async {
    try {
      final data = await supabase.from('profiles').select();

      setState(() {
        users = data;
        loading = false;
      });
    } catch (e) {
      debugPrint("Error fetchUsers: $e");
    }
  }

  // ===========================================
  // ADMIN LOGOUT USER (paksa logout)
  // ===========================================
  Future<void> logoutUser(String uuid) async {
    try {
      await supabase.auth.admin.signOut(uuid);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User berhasil di-logout")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal logout user: $e")));
    }
  }

  // ===========================================
  // ADMIN DELETE USER MENGGUNAKAN EDGE FUNCTION
  // ===========================================
  Future<void> deleteUser(String uuid) async {
    try {
      final response = await supabase.functions.invoke(
        'delete_user',
        body: {'uuid': uuid},
      );

      if (response.data != null && response.data['success'] == true) {
        // Hapus dari tabel profiles
        await supabase.from('profiles').delete().eq('uuid', uuid);

        fetchUsers();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("User berhasil dihapus!")),
        );
      } else {
        throw response.data['error'] ?? "Tidak dapat menghapus user";
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Gagal hapus user: $e")));
    }
  }

  // ===========================================
  // UI
  // ===========================================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Panel"),
        centerTitle: true,
        elevation: 0,
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Data User Terdaftar",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 20),

                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final u = users[index];

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    child: Text(
                                      (u['username'] ?? '?')[0].toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      u['username'] ?? "Unknown User",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              Text("Email: ${u['email']}",
                                  style: const TextStyle(fontSize: 16)),
                              Text("Password: ${u['password']}",
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.red)),
                              Text("UUID: ${u['uuid']}",
                                  style: const TextStyle(fontSize: 14)),

                              const SizedBox(height: 12),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.orange,
                                    ),
                                    onPressed: () => logoutUser(u['uuid']),
                                    child: const Text("Logout"),
                                  ),
                                  const SizedBox(width: 12),

                                  // DELETE BUTTON
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red,
                                    ),
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (_) => AlertDialog(
                                          title: const Text("Hapus User?"),
                                          content: Text(
                                              "Yakin ingin menghapus ${u['email']}?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Batal"),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red),
                                              onPressed: () {
                                                Navigator.pop(context);
                                                deleteUser(u['uuid']);
                                              },
                                              child: const Text("Hapus"),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: const Text("Delete"),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
