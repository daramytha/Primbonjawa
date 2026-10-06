import 'package:flutter/material.dart';

class SukertaScreen extends StatelessWidget {
  const SukertaScreen({super.key});

  final List<Map<String, String>> dataSukerta = const [
    {
      'nama': 'Sendang Kapit Pancuran',
      'urutan': 'Perempuan ➔ Laki-laki ➔ Perempuan',
      'deskripsi':
          'Anak laki-laki tunggal yang diapit oleh dua orang saudara perempuan (kakak dan adik).',
      'keterangan':
          'Filosofinya seperti sumber air (sendang) yang mengapit aliran air (pancuran). Menurut tradisi, anak laki-laki ini memikul beban sebagai pelindung dua saudara perempuannya. Disarankan untuk diruwat agar terhindar dari kesulitan finansial dan marabahaya.',
    },
    {
      'nama': 'Pancuran Kapit Sendang',
      'urutan': 'Laki-laki ➔ Perempuan ➔ Laki-laki',
      'deskripsi':
          'Anak perempuan tunggal yang diapit oleh dua orang saudara laki-laki (kakak dan adik).',
      'keterangan':
          'Filosofi aliran air yang mengapit mata air. Anak perempuan ini menjadi tumpuan kasih sayang sekaligus sosok yang dijaga ketat oleh saudara laki-lakinya. Diruwat agar membawa keberkahan dan ketenangan bagi keluarga.',
    },
    {
      'nama': 'Ontang-Anting',
      'urutan': '1 Anak Laki-laki (Tunggal)',
      'deskripsi': 'Satu-satunya anak dalam keluarga dan berjenis kelamin laki-laki.',
      'keterangan':
          'Menjadi tumpuan utama penerus garis keturunan keluarga. Dikeyakinan Jawa klasik, anak tunggal sangat rentan menjadi incaran Batara Kala sehingga wajib diruwat agar selamat dan mandiri.',
    },
    {
      'nama': 'Unting-Unting',
      'urutan': '1 Anak Perempuan (Tunggal)',
      'deskripsi': 'Satu-satunya anak dalam keluarga dan berjenis kelamin perempuan.',
      'keterangan':
          'Merupakan perhiasan tunggal dalam keluarga. Sangat disayangi namun rentan terhadap godaan hidup, sehingga diruwat untuk memohon perlindungan dari mara bahaya.',
    },
    {
      'nama': 'Uger-Uger Lawang',
      'urutan': 'Laki-laki ➔ Laki-laki',
      'deskripsi': 'Dua bersaudara kandung yang keduanya berjenis kelamin laki-laki.',
      'keterangan':
          'Diibaratkan sebagai tiang pintu rumah (uger-uger). Melambangkan kekuatan dan benteng keluarga. Diruwat agar tidak sering berselisih paham dan saling mendukung keberhasilan satu sama lain.',
    },
    {
      'nama': 'Kembang Sepasang',
      'urutan': 'Perempuan ➔ Perempuan',
      'deskripsi': 'Dua bersaudara kandung yang keduanya berjenis kelamin perempuan.',
      'keterangan':
          'Diibaratkan sepasang bunga yang indah. Diharapkan memberikan keharuman bagi nama keluarga, namun perlu diruwat untuk menjaga keharmonisan dan mempermudah urusan jodoh.',
    },
    {
      'nama': 'Kedhana Kedhini',
      'urutan': 'Laki-laki ➔ Perempuan',
      'deskripsi': 'Dua bersaudara kandung terdiri dari satu laki-laki dan satu perempuan.',
      'keterangan':
          'Pasangan saudara yang seimbang (pria dan wanita). Diruwat agar tercipta keselarasan rezeki, saling melengkapi, dan terhindar dari penyakit berat.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      appBar: AppBar(
        title: const Text('Anak Sukerta & Katuranggan'),
        backgroundColor: const Color(0xFF3E2723),
        foregroundColor: const Color(0xFFFFD700),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: dataSukerta.length,
        itemBuilder: (context, index) {
          final item = dataSukerta[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['nama']!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF3E2723),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFD700).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'Urutan: ${item['urutan']}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF3E2723),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    item['deskripsi']!,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const Divider(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline,
                          size: 18, color: Color(0xFF3E2723)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          item['keterangan']!,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[800],
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
