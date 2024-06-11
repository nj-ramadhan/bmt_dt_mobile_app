String globalAppVersion = '1.24.7';

String apiLoginRolePendidikan = 'Role Pendidikan';
String apiLoginRoleKoperasi = 'Role Koperasi';
String apiLoginNoUser = 'Nomor User';
String apiLoginToken = 'apiLoginToken';
String apiLoginRefreshToken = 'apiLoginRefreshToken';

String apiDetailsNoKoperasi = 'Nomor Koperasi';
String apiDetailsNoAnggota = 'Nomor Anggota';

String apiDataUserNIK = 'NIK';
String apiDataUserNamaLengkap = 'null';
String apiDataUserNamaPanggilan = 'null';
String apiDataUserTempatLahir = 'null';
String apiDataUserTanggalLahir = 'null';
String apiDataUserJenisKelamin = 'null';
String apiDataUserAlamatLengkap = 'null';
String apiDataUserProvinsi = 'null';
String apiDataUserKabupatenKota = 'null';
String apiDataUserKecamatan = 'null';
String apiDataUserKelurahan = 'null';
String apiDataUserRw = 'null';
String apiDataUserRt = 'null';
String apiDataUserAgama = 'null';
String apiDataUserPekerjaan = 'null';
String apiDataUserKewarganegaraan = 'null';
String apiDataUserHpOrtu = 'null';
String apiDataUserAlamatOrtu = 'null';
String apiDataUserKelas = 'null';
String apiDataUserTahunMasuk = 'null';
String apiDataUserFoto = 'null';
String apiDataUserPasFoto = 'null';
String apiDataUserKtaFoto = 'null';
String apiDataUserKtpFoto = 'null';
String apiDataUserKtpOrtu = 'null';
String apiDataUserKkFoto = 'null';
String apiDataUserAktaFoto = 'null';
String apiDataUserIjazahFoto = 'null';
String apiDataUserSkhunFoto = 'null';

String apiDataAccountNoUser = 'null';
String apiDataAccountEmail = 'null';
String apiDataAccountTelepon = 'null';
String apiDataAccountBlokir = 'null';
String apiDataAccountStatusUser = 'null';
String apiDataAccountNoAnggota = 'null';
String apiDataAccountDkuCard = 'null';
String apiDataAccountDkuQr = 'null';
String apiDataAccountNiK = 'null';
String apiDataAccountESaldoRp = 'null';
String apiDataAccountESaldoPoint = 'null';
String apiDataAccountESaldoTabungan = 'null';
String apiDataAccountIpAddress = 'null';

String apiDataAppId = 'null';
String apiDataAppName = 'null';
String apiDataAppIp = 'null';
String apiDataAppVerify = 'null';
String apiDataAppDomain = 'null';
String apiDataAppAccessFrom = 'null';
String apiDataAppLembagaId = 'null';
String apiDataAppBlocked = 'null';
String apiDataAppStatus = 'null';
String apiDataAppNameString = 'null';
String apiDataAppLogo = 'null';
String apiDataAppLogoBar = 'null';


String apiDataProductKeyword = 'null';
String apiDataProductShoppingType = 'null';
String apiDataProductProviderCode = 'null';
String apiDataProductTransactionType = 'null';
String apiDataProductClientNumber = 'null';
String apiDataProductName = 'null';
String apiDataProductCode = 'null';
String apiDataProductPrice = 'null';
String apiDataProductPin = 'null';

String apiDataOwnSirelaId = 'null';
String apiDataOwnSirelaAmount = 'null';
String apiDataDestinationSirelaId = 'null';
String apiDataDestinationSirelaName = 'null';
String apiDataSendaAmount = "null";
String apiDataSendaComment = "null";

String apiDataKodeTrx = "null";

String apiDataMetodeTransfer = "null";
String apiDataKodeBank = "null";
String apiDataBank = "null";

void updateLoginVariables(
  String newApiRolePendidikan,
  String newApiRoleKoperasi,
  String newApiUserNumber,
  String newApiToken,
  String newApiRefreshToken,
) {
  apiLoginRolePendidikan = newApiRolePendidikan;
  apiLoginRoleKoperasi = newApiRoleKoperasi;
  apiLoginNoUser = newApiUserNumber;
  apiLoginToken = newApiToken;
  apiLoginRefreshToken = newApiRefreshToken;
}

void updateDetails(
  String newApiDetailsNoKoperasi,
  String newApiDetailsNoAnggota,
) {
  apiDetailsNoKoperasi = newApiDetailsNoKoperasi;
  apiDetailsNoAnggota = newApiDetailsNoAnggota;
}

void updateDetailsUser(
  String newApiDataUserNIK,
  String newApiDataUserNamaLengkap,
  // String newApiDataUserNamaPanggilan,
  String newApiDataUserTempatLahir,
  // String newApiDataUserTanggalLahir,
  String newApiDataUserJenisKelamin,
  String newApiDataUserAlamatLengkap,
  // String newApiDataUserProvinsi,
  // String newApiDataUserKabupatenKota,
  // String newApiDataUserKecamatan,
  // String newApiDataUserKelurahan,
  // String newApiDataUserRw,
  // String newApiDataUserRt,
  // String newApiDataUserAgama,
  // String newApiDataUserPekerjaan,
  // String newApiDataUserKewarganegaraan,
  // String newApiDataUserHpOrtu,
  // String newApiDataUserAlamatOrtu,
  // String newApiDataUserKelas,
  // String newApiDataUserTahunMasuk,
  // String newApiDataUserFoto,
  // String newApiDataUserPasFoto,
  // String newApiDataUserKtaFoto,
  // String newApiDataUserKtpFoto,
  // String newApiDataUserKtpOrtu,
  // String newApiDataUserKkFoto,
  // String newApiDataUserAktaFoto,
  // String newApiDataUserIjazahFoto,
  // String newApiDataUserSkhunFoto,
) {
  apiDataUserNIK = newApiDataUserNIK;
  apiDataUserNamaLengkap = newApiDataUserNamaLengkap;
  // apiDataUserNamaPanggilan = newApiDataUserNamaPanggilan;
  apiDataUserTempatLahir = newApiDataUserTempatLahir;
  // apiDataUserTanggalLahir = newApiDataUserTanggalLahir;
  apiDataUserJenisKelamin = newApiDataUserJenisKelamin;
  apiDataUserAlamatLengkap = newApiDataUserAlamatLengkap;
  // apiDataUserProvinsi = newApiDataUserProvinsi;
  // apiDataUserKabupatenKota = newApiDataUserKabupatenKota;
  // apiDataUserKecamatan = newApiDataUserKecamatan;
  // apiDataUserKelurahan = newApiDataUserKelurahan;
  // apiDataUserRw = newApiDataUserRw;
  // apiDataUserRt = newApiDataUserRt;
  // apiDataUserAgama = newApiDataUserAgama;
  // apiDataUserPekerjaan = newApiDataUserPekerjaan;
  // apiDataUserKewarganegaraan = newApiDataUserKewarganegaraan;
  // apiDataUserHpOrtu = newApiDataUserHpOrtu;
  // apiDataUserAlamatOrtu = newApiDataUserAlamatOrtu;
  // apiDataUserKelas = newApiDataUserKelas;
  // apiDataUserTahunMasuk = newApiDataUserTahunMasuk;
  // apiDataUserFoto = newApiDataUserFoto;
  // apiDataUserPasFoto = newApiDataUserPasFoto;
  // apiDataUserKtaFoto = newApiDataUserKtaFoto;
  // apiDataUserKtpFoto = newApiDataUserKtpFoto;
  // apiDataUserKtpOrtu = newApiDataUserKtpOrtu;
  // apiDataUserKkFoto = newApiDataUserKkFoto;
  // apiDataUserAktaFoto = newApiDataUserAktaFoto;
  // apiDataUserIjazahFoto = newApiDataUserIjazahFoto;
  // apiDataUserSkhunFoto = newApiDataUserSkhunFoto;
}

void updateDetailsAccount(
  String newApiDataAccountNoUser,
  String newApiDataAccountEmail,
  String newApiDataAccountTelepon,
  // String newApiDataAccountBlokir,
  // String newApiDataAccountStatusUser,
  // String newApiDataAccountNoAnggota,
  // String newApiDataAccountDkuCard,
  // String newApiDataAccountDkuQr,
  // String newApiDataAccountNiK,
  // String newApiDataAccountESaldoRp,
  // String newApiDataAccountESaldoPoint,
  // String newApiDataAccountESaldoTabungan,
  // String newApiDataAccountIpAddress,
) {
  apiDataAccountNoUser = newApiDataAccountNoUser;
  apiDataAccountEmail = newApiDataAccountEmail;
  apiDataAccountTelepon = newApiDataAccountTelepon;
  // apiDataAccountBlokir = newApiDataAccountBlokir;
  // apiDataAccountStatusUser = newApiDataAccountStatusUser;
  // apiDataAccountNoAnggota = newApiDataAccountNoAnggota;
  // apiDataAccountDkuCard = newApiDataAccountDkuCard;
  // apiDataAccountDkuQr = newApiDataAccountDkuQr;
  // apiDataAccountNiK = newApiDataAccountNiK;
  // apiDataAccountESaldoRp = newApiDataAccountESaldoRp;
  // apiDataAccountESaldoPoint = newApiDataAccountESaldoPoint;
  // apiDataAccountESaldoTabungan = newApiDataAccountESaldoTabungan;
  // apiDataAccountIpAddress = newApiDataAccountIpAddress;
}

void updateDetailsApp(
  // String newApiDataAppId,
  // String newApiDataAppName,
  // String newApiDataAppIp,
  // String newApiDataAppVerify,
  // String newApiDataAppDomain,
  // String newApiDataAppAccessFrom,
  // String newApiDataAppLembagaId,
  // String newApiDataAppBlocked,
  // String newApiDataAppStatus,

  String newApiDataAppNameString,
  String newApiDataAppLogo,
  String newApiDataAppLogoBar,
) {
  // apiDataAppId = newApiDataAppId;
  // apiDataAppName = newApiDataAppName;
  // apiDataAppIp = newApiDataAppIp;
  // apiDataAppVerify = newApiDataAppVerify;
  // apiDataAppDomain = newApiDataAppDomain;
  // apiDataAppAccessFrom = newApiDataAppAccessFrom;
  // apiDataAppLembagaId = newApiDataAppLembagaId;
  // apiDataAppBlocked = newApiDataAppBlocked;
  // apiDataAppStatus = newApiDataAppStatus;

  apiDataAppNameString = newApiDataAppNameString;
  apiDataAppLogo = newApiDataAppLogo;
  apiDataAppLogoBar = newApiDataAppLogoBar;
}

void updateDetailProducts(
  String newApiDataProductKeyword,
  String newApiDataProductShoppingType,
  String newApiDataProductProviderCode,
  String newApiDataProductTransactionType,
  String newApiDataProductClientNumber,
  String newApiDataProductName,
  String newApiDataProductCode,
  String newApiDataProductPrice,
  String newApiDataProductPin,
) {
  // apiDataAppId = newApiDataAppId;
  // apiDataAppName = newApiDataAppName;
  // apiDataAppIp = newApiDataAppIp;
  // apiDataAppVerify = newApiDataAppVerify;
  // apiDataAppDomain = newApiDataAppDomain;
  // apiDataAppAccessFrom = newApiDataAppAccessFrom;
  // apiDataAppLembagaId = newApiDataAppLembagaId;
  // apiDataAppBlocked = newApiDataAppBlocked;
  // apiDataAppStatus = newApiDataAppStatus;

  apiDataProductKeyword = newApiDataProductKeyword;
  apiDataProductShoppingType = newApiDataProductShoppingType;
  apiDataProductProviderCode = newApiDataProductProviderCode;
  apiDataProductTransactionType = newApiDataProductTransactionType;
  apiDataProductClientNumber = newApiDataProductClientNumber;
  apiDataProductName = newApiDataProductName;
  apiDataProductCode = newApiDataProductCode;
  apiDataProductPrice = newApiDataProductPrice;
  apiDataProductPin = newApiDataProductPin;
}

void updateDetailsRek(
  String newapiDataOwnSirelaId,
  String newapiDataOwnSirelaAmount,
  String newapiDataDestinationSirelaId,
  String newapiDataDestinationSirelaName,
  String newapiDataSendaAmount,
  String newapiDataSendaComment,
  String newapiDataKodeTrx,
  String newapiDataMetodeTransfer,
) {
  apiDataOwnSirelaId = newapiDataOwnSirelaId;
  apiDataOwnSirelaAmount = newapiDataOwnSirelaAmount;
  apiDataDestinationSirelaId = newapiDataDestinationSirelaId;
  apiDataDestinationSirelaName = newapiDataDestinationSirelaName;
  apiDataSendaAmount = newapiDataSendaAmount;
  apiDataSendaComment = newapiDataSendaComment;
  apiDataKodeTrx = newapiDataKodeTrx;
  apiDataMetodeTransfer = newapiDataMetodeTransfer;
}

void updateDifBank(String newapiDataMetodeTransfer, String newapiDataKodeBank,
    String newapiDataBank) {
  apiDataMetodeTransfer = newapiDataMetodeTransfer;
  apiDataKodeBank = newapiDataKodeBank;
  apiDataBank = newapiDataBank;
}
