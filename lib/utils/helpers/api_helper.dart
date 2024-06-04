import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../components/dropdown_V2.dart';

class ApiHelper {
  static const String baseUrl = 'https://dkuapi.dkuindonesia.id';

  static Future<Map<String, dynamic>> sendAPI({
    required Map<String, String> headers,
    required Map<String, dynamic> body,
    required String address,
  }) async {
    final String url = baseUrl + address;

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body) as Map<String, dynamic>;
        // Return the response body
        // print(responseBody);
        return responseBody;
      } else {
        debugPrint('Request failed with status: ${response.statusCode}.');
        return {'error': 'Request failed with status: ${response.statusCode}'};
      }
    } catch (e) {
      debugPrint('Error: $e');
      return {'error': 'Error: $e'};
    }
  }

  // static Future<Map<String, dynamic>> provinsiAPI(
  //   // required String provinsi;

  // ) async {
  //   final headers = {
  //     'ClientID': 'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
  //     'Content-Type': 'application/json',
  //   };

  //   Map<String, dynamic> body = {};
  //   Map<String, dynamic> data = await sendAPI(
  //     headers: headers,
  //     body: body,
  //     address:'/api/table_wizard_public/crud_table_real?act=list-dkui_wilayah.provinces'
  //   );
  //   Map<String, dynamic> output = data['data'];
  //   // data = data['data'];
  //   return output;
  // }
/*API untuk meregister user*/
  static Future<Map<String, dynamic>> APIRegister({
    required String address,
    required String nik,
    required String nama_lengkap,
    required String email,
    required String password,
    required String telepon,
    required String jenis_kelamin,
    required String tanggal_lahir,
    required String tempat_lahir,
    required String provinsi,
    required String kabupaten_kota,
    required String kecamatan,
    required String kelurahan,
    required String rw,
    required String rt,
    required String agama,
    required String status_perkawinan,
    required String pekerjaan,
    required String kewarganegaraan,
    required String referral_id,
    // required String role_koperasi,
  }) async {
    final url = Uri.parse(
        'https://dkuapi.dkuindonesia.id/api/Authorization/register'); // Ganti dengan URL API yang benar
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6\/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ\/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A\/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs\/WzXeZ9pQGOkHyX6IK\/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M\/fXTrjkHB\/v+1VFKgkGRFz0eIhDXZ3yp7e\/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n\/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3\/gKIXwL6NGFqzdeEy3xC\/Qr6',
      'Content-Type': 'application/json',
    };
    // final body =  json.encode({
    //   "mode": "formdata",
    //   "formdata": [
    //     {"nik" :"321312321312321321",
    //     "nama_lengkap": "Riri Andiri Delia Sutarno",
    //     "email": "irmanapriana@gmail.com",
    //     "password" : "123456Aa@",
    //     "telepon" : "081212678943",
    //     "jenis_kelamin" : "P",
    //     "tanggal_lahir" : "1994-03-02",
    //     "tempat_lahir" : "Bandung",
    //     "provinsi" : "12",
    //     "kabupaten_kota":"1204",
    //     "kecamatan" : "1204010",
    //     "kelurahan" : "1204010003",
    //     "rw":"06",
    //     "rt":"07",
    //     "agama": "islam",
    //     "status_perkawinan":"KAWIN",
    //     "pekerjaan":"Ibu Rumah Tangga",
    //     "kewarganegaraan":"WNI",
    //     "role_koperasi" : "A1"
    //     }
    //   ]
    // });
    final body = {
      "mode": "formdata",
      "formdata": [
        {"key": "nik", "value": nik, "type": "text"},
        {
          "key": "nama_lengkap",
          "value": nama_lengkap,
          "contentType": "MANDATORY",
          "description": "VARCHAR(100) M",
          "type": "text"
        },
        {
          "key": "email",
          "value": email,
          "contentType": "MANDATORY",
          "description": "VARCHAR(100) M",
          "type": "text"
        },
        {
          "key": "password",
          "value": password,
          "contentType": "MANDATORY",
          "description": "VARCHAR(50) M",
          "type": "text"
        },
        {
          "key": "telepon",
          "value": telepon,
          "contentType": "MANDATORY",
          "description": "VARCHAR(25) M",
          "type": "text"
        },
        {
          "key": "jenis_kelamin",
          "value": jenis_kelamin,
          "contentType": "Mandatory",
          "description": "ENUM(\"L\",\"P\")",
          "type": "text"
        },
        {
          "key": "tanggal_lahir",
          "value": tanggal_lahir,
          "contentType": "Mandatory",
          "description": "YYYY-MM-DD",
          "type": "text"
        },
        {
          "key": "tempat_lahir",
          "value": tempat_lahir,
          "contentType": "Mandatory",
          "description": "varchar(50)",
          "type": "text"
        },
        {
          "key": "provinsi",
          "value": provinsi,
          "contentType": "Mandatory",
          "description": "int(4)",
          "type": "text"
        },
        {
          "key": "kabupaten_kota",
          "value": kabupaten_kota,
          "contentType": "Mandatory",
          "description": "int(6)",
          "type": "text"
        },
        {
          "key": "kecamatan",
          "value": kecamatan,
          "contentType": "Mandatory",
          "description": "int(9)",
          "type": "text"
        },
        {
          "key": "kelurahan",
          "value": kelurahan,
          "contentType": "Mandatory",
          "description": "int(12)",
          "type": "text"
        },
        {
          "key": "rw",
          "value": rw,
          "contentType": "Mandatory",
          "description": "int(4)",
          "type": "text"
        },
        {
          "key": "rt",
          "value": rt,
          "contentType": "Mandatory",
          "description": "int(5)",
          "type": "text"
        },
        {
          "key": "agama",
          "value": agama,
          "contentType": "Mandatory",
          "description": "VARCHAR(25)",
          "type": "text"
        },
        {
          "key": "status_perkawinan",
          "value": status_perkawinan,
          "contentType": "Mandatory",
          "description": "'BELUM KAWIN','KAWIN','CERAI HIDUP','CERAI MATI'",
          "type": "text"
        },
        {
          "key": "pekerjaan",
          "value": pekerjaan,
          "contentType": "Mandatory",
          "description": "VARCHAR(50)",
          "type": "text"
        },
        {
          "key": "kewarganegaraan",
          "value": kewarganegaraan,
          "contentType": "Mandatory",
          "description": "ENUM(\"WNI\",\"WNA\")",
          "type": "text"
        },
        {
          "key": "referral_id",
          "value": referral_id,
          "contentType": "Mandatory",
          "description": "masukan referral ID",
          "type": "text"
        },
        {
          "key": "role_koperasi",
          "value": "A1",
          "type": "text",
          "disabled": true
        }
      ]
    };

    try {
      final response = await http
          .post(
            url,
            headers: headers,
            body: json.encode(body),
          )
          .timeout(
              const Duration(seconds: 10)); // Timeout diatur menjadi 10 detik
      final data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        print(data);
        print('Data berhasil dikirim');
        return {"status": "berhasil"};
      } else {
        print('Gagal mengirim data: ${response.statusCode}');
        return {"error": "Gagal mengirim data: ${response.statusCode}"};
      }
    } on http.ClientException catch (e) {
      print('ClientException: $e');
      return {"error": "ClientException: $e"};
    } on Exception catch (e) {
      print('Terjadi kesalahan: $e');
      return {"error": "Terjadi kesalahan: $e"};
    }
  }

  static Future<List<DropdownItemsModel>> getProvince() async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> isi = {};
    final String url =
        "https://dkuapi.dkuindonesia.id/api/table_wizard_public/crud_table_real?act=list-dkui_wilayah.provinces";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(isi),
      );
      final body = json.decode(response.body)['data'] as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsModel(
              // userId: map["userId"], id: map['id'], title: map["title"]);
              id: int.parse(map['id']),
              title: map["name"]);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  static Future<List<DropdownItemsModel>> getCity({
    required String address,
  }) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> isi = {};
    final String url =
        "https://dkuapi.dkuindonesia.id/api/table_wizard_public/crud_table_real?act=list-dkui_wilayah.regencies&category_name=province_id&category_value=" +
            address;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(isi),
      );
      final body = json.decode(response.body)['data'] as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsModel(
              // userId: map["userId"], id: map['id'], title: map["title"]);
              id: int.parse(map['id']),
              title: map["name"]);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  static Future<List<DropdownItemsModel>> getDistrict({
    required String address,
  }) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> isi = {};
    final String url =
        "https://dkuapi.dkuindonesia.id/api/table_wizard_public/crud_table_real?act=list-dkui_wilayah.districts&category_name=regency_id&category_value=" +
            address;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(isi),
      );
      final body = json.decode(response.body)['data'] as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsModel(
              // userId: map["userId"], id: map['id'], title: map["title"]);
              id: int.parse(map['id']),
              title: map["name"]);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  static Future<List<DropdownItemsModel>> getSubDistrict({
    required String address,
  }) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> isi = {};
    final String url =
        "https://dkuapi.dkuindonesia.id/api/table_wizard_public/crud_table_real?act=list-dkui_wilayah.villages&category_name=district_id&category_value=" +
            address;
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(isi),
      );
      final body = json.decode(response.body)['data'] as List;

      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsModel(
              // userId: map["userId"], id: map['id'], title: map["title"]);
              id: int.parse(map['id']),
              title: map["name"]);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  static Future<Map<int, Map<String, String>>> getListRekening({
    required String LoginToken,
  }) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Authorization': 'Bearer $LoginToken',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> isi = {};
    final String url =
        "https://dkuapi.dkuindonesia.id/api/Authorization/get_my_list_rekening";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(isi),
      );
      final body = json.decode(response.body)['data'] as List;

      if (response.statusCode == 200) {
        Map<int, Map<String, String>> dataMap = {};
        for (int i = 0; i < body.length; i++) {
          var item = body[i];
          dataMap[i + 1] = {
            'name': item['nama_produk'] ?? '',
            'number': item['id_su'] ?? '',
            'amount': 'Rp. ${item['saldo_rp'] ?? '0'}',
          };
        }
        print(dataMap);
        return dataMap;
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }
}
