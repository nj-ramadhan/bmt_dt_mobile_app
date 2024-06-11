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
    required String loginToken,
  }) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Authorization': 'Bearer $loginToken',
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

  static Future<String> getAccountHolderSirela({
    required String idSirela,
    required String loginToken,
  }) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'application/json',
    };

    final String url =
        "https://dkuapi.dkuindonesia.id/api/dku_bank/inquiry_account/$idSirela";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );

      // Print the raw response for debugging
      print('Response body: ${response.body}');
      final data = json.decode(response.body);

      // Validate the JSON format
      if (data is! Map<String, dynamic> || !data.containsKey('status')) {
        throw FormatException('Invalid JSON format');
      }

      if (data['status'].toString() == "200") {
        final listdata = data['data'];
        if (listdata is List && listdata.isNotEmpty) {
          return listdata[0]['nama_lengkap'].toString();
        }
        return "error";
      } else {
        return "error";
      }
    } catch (e) {
      debugPrint('Error: $e');
      return "error";
    }
  }

  static Future<String> getAccountHolderDifBank(String token,
      String idDestination, String codeBank, String metodeTransfer) async {
    const String url =
        'https://dkuapi.dkuindonesia.id/api/Dku_bank/cek_rekening_tujuan';
    print("+" + metodeTransfer + "+" + idDestination + "+" + codeBank);
    try {
      var response = await http.post(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'jenis_transfer': metodeTransfer,
          'kode_bank_tujuan': codeBank,
          'rek_tujuan': idDestination,
          'bifast_nominal': '500.00',
          'bifast_tujuan_transaksi': '99',
        },
      );
      final data = json.decode(response.body);
      print('Response data: ${response.body}');
      // final data = json.decode(response.body);
      if (response.statusCode == 200) {
        // Request was successful
        print('Response data: ${response.body}');
        return data['beneficiaryAccountName'].toString();
      } else {
        // Request failed
        print('Request failed with status: ${response.statusCode}');
        return 'errorr';
      }
    } catch (e) {
      // Handle any errors
      print('Error: $e');
      return 'error';
    }
  }

  static Future<Map<String, dynamic>> getTransferSirela(
      String token,
      String idSirela,
      String nominalTopUp,
      String notes,
      String pin,
      String idSirelaDestination) async {
    final url = Uri.https('dkuapi.dkuindonesia.id',
        '/api/dku_bank/credit_transfer/$idSirelaDestination');
// https://dkuapi.dkuindonesia.id/api/dku_bank/credit_transfer/36055
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/x-www-form-urlencoded',
    };
    print("ID Sirela $idSirela");
    final body = {
      'm_bayar': "sk-$idSirela",
      'nominal_top_up': nominalTopUp,
      'notes': notes,
      'pin': pin,
    };

    final response = await http.post(url, headers: headers, body: body);
    print(json.decode(response.body));
    final data = json.decode(response.body);
    if (response.statusCode == 200) {
      print('Transfer successful');
      return data;
    } else {
      print('Failed to transfer: ${response.body}');
      return {"error": "data error"};
    }
  }

  static Future<List<DropdownItemsStringIdModel>> getListBankTO({
    required String loginToken,
  }) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> isi = {};
    final String url =
        "https://dkuapi.dkuindonesia.id/api/dku_bank/kode_bank_to?return=TRUE";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(isi),
      );
      final body = json.decode(response.body)['data'] as List;
      print("isi body");
      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsStringIdModel(
              // userId: map["userId"], id: map['id'], title: map["title"]);
              id: map['kode_bank'],
              title: map["nama_bank"]);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  static Future<List<DropdownItemsStringIdModel>> getListBankBIFAST({
    required String loginToken,
  }) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> isi = {};
    final String url =
        "https://dkuapi.dkuindonesia.id/api/dku_bank/kode_bank_bifast?return=TRUE";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(isi),
      );
      final body = json.decode(response.body)['data'] as List;
      print("isi body");
      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsStringIdModel(
              // userId: map["userId"], id: map['id'], title: map["title"]);
              id: map['kode_bank'],
              title: map["nama_bank"]);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  static Future<List<DropdownItemsStringIdModel>> getListBankRTGS({
    required String loginToken,
  }) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> isi = {};
    final String url =
        "https://dkuapi.dkuindonesia.id/api/dku_bank/kode_bank_rtgs?return=TRUE";
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: json.encode(isi),
      );
      final body = json.decode(response.body)['data'] as List;
      print("isi body");
      if (response.statusCode == 200) {
        return body.map((e) {
          final map = e as Map<String, dynamic>;
          return DropdownItemsStringIdModel(
              // userId: map["userId"], id: map['id'], title: map["title"]);
              id: map['kode_bank'],
              title: map["nama_bank"]);
        }).toList();
      }
    } on SocketException {
      throw Exception("Network Connectivity Error");
    }
    throw Exception("Fetch Data Error");
  }

  static Future<Map<int, Map<String, String>>> getListProvider(
      {required String loginToken, String? frontCode}) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'application/json',
    };

    final String url =
        "https://dkuapi.dkuindonesia.id/api/table_wizard/crud_table_serverside_globaltable?act=list-dkui_mitra.t_provider_kode&category_name=a.kode_depan_nomor&category_value=$frontCode";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      final body = json.decode(response.body)['data'] as List;

      if (response.statusCode == 200) {
        Map<int, Map<String, String>> dataMap = {};
        for (int i = 0; i < body.length; i++) {
          var item = body[i];
          dataMap[i + 1] = {
            'no_kode_provider': item['no_kode_provider'] ?? '',
            'no_provider': item['no_provider'] ?? '',
            'produk_provider': item['produk_provider'] ?? '',
            'logo_kartu': item['logo_kartu'] ?? '',
            'keyword_kode_depan_nomor': item['keyword_kode_depan_nomor'] ?? '',
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

  static Future<Map<int, Map<String, String>>> getListProduct(
      {required String loginToken,
      required String providerCode,
      required String transactionType}) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'application/json',
    };

    final String url =
        "https://dkuapi.dkuindonesia.id/api/pulsa/get_produk_by_provider_code?provider_code=$providerCode&jenis_transaksi=$transactionType";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      final body = json.decode(response.body)['data'] as List;

      if (response.statusCode == 200) {
        Map<int, Map<String, String>> dataMap = {};
        for (int i = 0; i < body.length; i++) {
          var item = body[i];
          dataMap[i + 1] = {
            'kode_bayar_ppob': item['kode_bayar_ppob'] ?? '',
            'kode_dku': item['kode_dku'] ?? '',
            'jenis_transaksi_ppob': item['jenis_transaksi_ppob'] ?? '',
            'sub_jenis_transaksi_ppob': item['sub_jenis_transaksi_ppob'] ?? '',
            'provider': item['provider'] ?? '',
            'nama_produk': item['nama_produk'] ?? '',
            'status_ketersediaan': item['status_ketersediaan'] ?? '',
            'harga_jual_eceran': item['harga_jual_eceran'] ?? '',
            'harga_jual_agen': item['harga_jual_agen'] ?? '',
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

  static Future<Map<String, String>> postBuyProduct({
    required String loginToken,
    required String pin,
    required String codeProduct,
    required String clientNumber,
    required String methodPayment,
  }) async {
    final String url = "https://dkuapi.dkuindonesia.id/api/Pulsa/beli_pulsa";

    final headers = {
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'multipart/form-data',
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields['pin'] = pin
        ..fields['kode_p'] = codeProduct
        ..fields['m_bayar'] = methodPayment
        ..fields['no_tujuan'] = clientNumber;

      final response = await request.send();
      print(response);

      if (response.statusCode == 200 || response.statusCode == 402) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody) as Map;
        Map<String, String> dataMap = {};
        dataMap = {
          'status_trx': data['status_trx'] ?? '',
          'kd_trx': data['kd_trx'] ?? '',
          'customerRefCode': data['customerRefCode'] ?? '',
          'message': data['message'] ?? '',
        };
        return dataMap;
      } else {
        throw Exception(
            "Failed to complete transaction: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Network Connectivity Error");
    }
  }

  static Future<Map<String, String>> postProfileUpdate({
    required String loginToken,
    required String password,
    required String idNumber,
    required String fullName,
    required String gender,
    required String birthPlace,
    File? photoProfile,
  }) async {
    final String url =
        "https://dkuapi.dkuindonesia.id/api/Authorization/update_profile";

    final headers = {
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'multipart/form-data',
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields['current_password'] = password
        ..fields['nik'] = idNumber
        ..fields['nama_lengkap'] = fullName
        ..fields['jenis_kelamin'] = gender
        ..fields['tempat_lahir'] = birthPlace;

      final response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 402) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody) as Map;
        print(data);
        Map<String, String> dataMap = {};
        dataMap = {
          'message': data['message1'] ?? data['message'],
        };
        return dataMap;
      } else {
        throw Exception(
            "Failed to complete transaction: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Network Connectivity Error");
    }
  }

  static Future<Map<String, String>> postPasswordUpdate({
    required String loginToken,
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final String url =
        "https://dkuapi.dkuindonesia.id/api/Authorization/update_password";

    final headers = {
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'multipart/form-data',
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields['old_password'] = oldPassword
        ..fields['new_password'] = newPassword
        ..fields['confirm_password'] = confirmPassword;

      final response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 400) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody) as Map;
        print(data);
        Map<String, String> dataMap = {};
        dataMap = {
          'message': data['message'],
        };
        return dataMap;
      } else {
        throw Exception(
            "Failed to complete transaction: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Network Connectivity Error");
    }
  }

  static Future<Map<String, String>> postEmailUpdate({
    required String loginToken,
    required String newEmail,
    required String pin,
  }) async {
    final String url =
        "https://dkuapi.dkuindonesia.id/api/Authorization/verify_update_email";

    final headers = {
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'multipart/form-data',
    };

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers)
        ..fields['new_email'] = newEmail
        ..fields['pin'] = pin;

      final response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 400) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody) as Map;
        print(data);
        Map<String, String> dataMap = {};
        dataMap = {
          'message': data['message'],
        };
        return dataMap;
      } else {
        throw Exception(
            "Failed to complete transaction: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Network Connectivity Error");
    }
  }

  static Future<Map<int, Map<String, String>>> getListTransaction(
      {required String loginToken,
      required String dateBegin,
      required String dateFinish}) async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Authorization': 'Bearer $loginToken',
      'Content-Type': 'application/json',
    };

    final String url =
        "https://dkuapi.dkuindonesia.id/api/Pulsa/get_trectrans?from_date=$dateBegin&to_date=$dateFinish&start=0&length=10";

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: headers,
      );
      final body = json.decode(response.body)['data'] as List;

      if (response.statusCode == 200) {
        Map<int, Map<String, String>> dataMap = {};
        for (int i = 0; i < body.length; i++) {
          var item = body[i];
          dataMap[i + 1] = {
            'id': item['id'] ?? '',
            'kd_trx': item['kd_trx'] ?? '',
            'refund_kd_trx': item['refund_kd_trx'] ?? '',
            'customerRefCode': item['customerRefCode'] ?? '',
            'trx_title': item['trx_title'] ?? '',
            'kd_tujuan1': item['kd_tujuan1'] ?? '',
            'kd_bank_tujuan1': item['kd_bank_tujuan1'] ?? '',
            'metode_tujuan': item['metode_tujuan'] ?? '',
            'no_user_tujuan1': item['no_user_tujuan1'] ?? '',
            'kd_bayar1': item['kd_bayar1'] ?? '',
            'kd_bank_bayar1': item['kd_bank_bayar1'] ?? '',
            'metode_bayar': item['metode_bayar'] ?? '',
            'no_user_bayar1': item['no_user_bayar1'] ?? '',
            'adm_bayar': item['adm_bayar'] ?? '',
            'nominal_bayar': item['nominal_bayar'] ?? '',
            'nominal_modal': item['nominal_modal'] ?? '',
            'detail_bayar': item['detail_bayar'] ?? '',
            'status': item['status'] ?? '',
            'keterangan': item['keterangan'] ?? '',
            'upload_bukti_tf': item['upload_bukti_tf'] ?? '',
            'no_user_maker1': item['no_user_maker1'] ?? '',
            'waktu_order': item['waktu_order'] ?? '',
            'waktu_bayar': item['waktu_bayar'] ?? '',
            'waktu_berhasil_terkirim': item['waktu_berhasil_terkirim'] ?? '',
            'who_update': item['who_update'] ?? '',
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

  static Future<Map<String, String>> postDetailLembaga() async {
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs/WzXeZ9pQGOkHyX6IK/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M/fXTrjkHB/v+1VFKgkGRFz0eIhDXZ3yp7e/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3/gKIXwL6NGFqzdeEy3xC/Qr6',
      'Content-Type': 'application/json',
    };
    final String url =
        "https://dkuapi.dkuindonesia.id/api/Credential/koperasi_details";

    try {
      var request = http.MultipartRequest('POST', Uri.parse(url))
        ..headers.addAll(headers);

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody)['data_app'] as Map;

        Map<String, String> dataMap = {};
        dataMap = {
          'app_name_string': data['app_name_string'] ?? '',
          'app_logo': data['app_logo'] ?? '',
          'app_logo_bar': data['app_logo_bar'] ?? '',
        };
        return dataMap;
      } else {
        throw Exception(
            "Failed to complete transaction: ${response.statusCode}");
      }
    } catch (e) {
      print('Error: $e');
      throw Exception("Network Connectivity Error");
    }
  }
}
