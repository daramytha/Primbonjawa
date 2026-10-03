import 'package:flutter/material.dart';

class MimpiScreen extends StatefulWidget {
  const MimpiScreen({super.key});

  @override
  State<MimpiScreen> createState() => _MimpiScreenState();
}

class _MimpiScreenState extends State<MimpiScreen> {
  final TextEditingController _searchController = TextEditingController();

  // Data awal tafsir mimpi
  final List<Map<String, String>> _allMimpi = [
    {
      'judul': 'Ular',
      'deskripsi': 'Mimpi melihat ular melambangkan adanya rintangan, atau penanda akan datangnya jodoh jika bermimpi digigit ular.'
    },
    {
      'judul': 'Air Jernih',
      'deskripsi': 'Pertanda keberkahan, ketenangan pikiran, dan rezeki yang lancar serta halal.'
    },
    {
      'judul': 'Terbang',
      'deskripsi': 'Pertanda keinginan untuk bebas, peningkatan derajat, atau kesuksesan karir.'
    },
    {
      'judul': 'Pernikahan',
      'deskripsi': 'Pertanda adanya komitmen baru atau fase kehidupan baru yang memerlukan tanggung jawab.'
    },
    {
      'judul': 'Gigi Copot',
      'deskripsi': 'Peringatan untuk lebih memperhatikan kesehatan diri sendiri atau anggota keluarga.'
    },
    {
      'judul': 'Jatuh dari Ketinggian',
      'deskripsi': 'Pertanda adanya rasa cemas, kehilangan kendali, atau kekhawatiran terhadap suatu keputusan.'
    },
    {
      'judul': 'Mengejar Bus / Kereta',
      'deskripsi': 'Menandakan adanya kesempatan yang terlewat atau ketakutan tertinggal dalam persaingan.'
    },
    {
      'judul': 'Melihat Api',
      'deskripsi': 'Melambangkan amarah, transformasi besar, atau semangat yang menyala-nyala.'
    },
  ];

  List<Map<String, String>> _filteredMimpi = [];

  @override
  void initState() {
    super.initState();
    _filteredMimpi = List.from(_allMimpi);
    _searchController.addListener(_filterMimpi);
  }

  void _filterMimpi() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredMimpi = List.from(_allMimpi);
      } else {
        _filteredMimpi = _allMimpi.where((mimpi) {
          final judul = mimpi['judul']!.toLowerCase();
          final deskripsi = mimpi['deskripsi']!.toLowerCase();
          return judul.contains(query) || deskripsi.contains(query);
        }).toList();
      }
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Tafsir Mimpi'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- KOLOM PENCARIAN ---
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Cari kata kunci (Ular, Air)...',
                prefixIcon: const Icon(Icons.search, color: Color(0xFF3E2723)),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF3E2723), width: 2),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // --- DAFTAR TAFSIR MIMPI ---
            Expanded(
              child: _filteredMimpi.isEmpty
                  ? const Center(
                      child: Text(
                        'Kata kunci tafsir mimpi tidak ditemukan.',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _filteredMimpi.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final item = _filteredMimpi[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['judul']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF3E2723),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              item['deskripsi']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                                height: 1.4,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
