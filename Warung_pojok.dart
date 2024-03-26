import 'dart:io';

class belanja {
  String? _nama;
  int? _stok;
  double? _harga;

  String? get nama => _nama;
  int? get stok => _stok;
  double? get harga => _harga;

  set harga(double? value) {
    if (value != null && value > 0) {
      _harga = value;
    } else {
      print("Harga harus lebih besar dari 0");
    }
  }

  belanja(this._nama, this._stok, this._harga);
}

void tambahbelanja(List<belanja> MenuWarung) {
  print("Masukkan Nama makanan: ");
  String? _nama = stdin.readLineSync();
  if (_nama == null || _nama.isEmpty) {
    print("Nama tidak boleh kosong");
    return;
  }

  print("Masukkan Harga makanan: ");
  double? _harga = double.tryParse(stdin.readLineSync() ?? '');
  if (_harga == null || _harga <= 0) {
    print("Harga harus lebih besar dari 0");
    return;
  }

  print("Masukkan Jumlah Stok");
  int? _stok = int.tryParse(stdin.readLineSync() ?? '');
  if (_stok == null || _stok < 0) {
    print("Stok harus lebih besar atau sama dengan 0");
    return;
  }

  belanja gabung = belanja(_nama, _stok, _harga);
  MenuWarung.add(gabung);
  print("makanan Baru Berhasil di Tambahkan");
}

void lihatStok(List<belanja> MenuWarung) {
  if (MenuWarung.isEmpty) {
    print("maaf menu ini habis");
    return;
  }

  print("Stok makanan:");
  for (int i = 0; i < MenuWarung.length; i++) {
    print(
        "${i + 1}. ${MenuWarung[i].nama}, Stok: ${MenuWarung[i].stok}, Harga: ${MenuWarung[i].harga}");
  }
}

void printStruk(String nama, double harga, int jumlah, double total) {
  print("\n===== Struk Transaksi WARUNG POJOK =====");
  print("Nama: $nama");
  print("Harga 1 menu : Rp $harga");
  print("Jumlah yang dibeli: $jumlah");
  print("Total harga: Rp $total");
  print("<=======TERIMA KASIH ATAS BELANJANYA=======>");
}

void transaksi(List<belanja> MenuWarung) {
  if (MenuWarung.isEmpty) {
    print("menu warung kosong");
    return;
  }

  lihatStok(MenuWarung);
  print("Masukkan nomor menu yang ingin Anda beli:");
  int? pilihan = int.tryParse(stdin.readLineSync() ?? '');
  if (pilihan != null && pilihan > 0 && pilihan <= MenuWarung.length) {
    print("Masukkan jumlah makanan yang ingin Anda beli:");
    int? jumlah = int.tryParse(stdin.readLineSync() ?? '');
    if (jumlah != null && jumlah >= 0) {
      if (jumlah <= MenuWarung[pilihan - 1].stok!) {
        double totalHarga = MenuWarung[pilihan - 1].harga! * jumlah;
        printStruk(MenuWarung[pilihan - 1].nama!, MenuWarung[pilihan - 1].harga!,
            jumlah, totalHarga);
        MenuWarung[pilihan - 1]._stok = MenuWarung[pilihan - 1]._stok! - jumlah;
      } else {
        print("maaf stock telah habis");
      }
    } else {
      print("Masukkan jumlah yang valid");
    }
  } else {
    print("Pilihan tidak valid");
  }
}

void updateStok(List<belanja> MenuWarung) {
  if (MenuWarung.isEmpty) {
    print("menu warung kosong");
    return;
  }

  lihatStok(MenuWarung);
  print("Masukkan nomor menu yang stoknya ingin diupdate:");
  int? pilihan = int.tryParse(stdin.readLineSync() ?? '');
  if (pilihan != null && pilihan > 0 && pilihan <= MenuWarung.length) {
    print("Masukkan stok baru:");
    int? stokBaru = int.tryParse(stdin.readLineSync() ?? '');
    if (stokBaru != null && stokBaru >= 0) {
      MenuWarung[pilihan - 1]._stok = stokBaru;
      print("Stok berhasil diperbarui");
    } else {
      print("Masukkan stok yang valid");
    }
  } else {
    print("Pilihan tidak valid");
  }
}

void hapusbelanja(List<belanja> MenuWarung) {
  if (MenuWarung.isEmpty) {
    print("mohon maaf menunya telah habis ");
    return;
  }

  lihatStok(MenuWarung);
  print("Masukkan nomor menu yang ingin dihapus:");
  int? pilihan = int.tryParse(stdin.readLineSync() ?? '');
  if (pilihan != null && pilihan > 0 && pilihan <= MenuWarung.length) {
    MenuWarung.removeAt(pilihan - 1);
    print("makanan berhasil dihapus");
  } else {
    print("Pilihan tidak valid");
  }
}

void main() {
  List<belanja> MenuWarung = [];

  // Tambahkan Jajan default
  MenuWarung.add(belanja('nasi campur', 100, 10000));
  MenuWarung.add(belanja('kerupuk', 200, 1000));
  MenuWarung.add(belanja('es teh', 80, 2000));
  MenuWarung.add(belanja('es jeruk', 80, 2000));
  MenuWarung.add(belanja('kopi ABC', 80, 3000));
  MenuWarung.add(belanja('kopi White', 80, 3000));

  bool running = true;

  while (running) {
    print("<===========>WARUNG POJOK<===========>");
    print("1. Tambah belanja");
    print("2. Stok dagangan");
    print("3. Transaksi");
    print("4. Update Stok");
    print("5. Hapus");
    print("6. Keluar");
    print("pilih nomor 1-6");

    String? pilihan = stdin.readLineSync();

    switch (pilihan) {
      case '1':
        tambahbelanja(MenuWarung);
        break;
      case '2':
        lihatStok(MenuWarung);
        break;
      case '3':
        transaksi (MenuWarung);
        break;
      case '4':
        updateStok(MenuWarung);
        break;
      case '5':
        hapusbelanja(MenuWarung);
        break;
      case '6':
        running = false;
        break;
      default:
        print("Pilihan tidak valid");
        break;
    }
  }
}
