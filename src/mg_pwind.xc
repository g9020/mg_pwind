/usr/local/lib/yottadb/r130/mg_pwind.so
version: ydb_status_t mg_version(O:ydb_string_t *[64])
cryptlibrary: ydb_status_t mg_crypt_library(I:ydb_string_t *)
sslversion: ydb_status_t mg_ssl_version(O:ydb_string_t *[64], O:ydb_string_t *[512])
sha1: ydb_status_t mg_sha1(I:ydb_string_t *, I:ydb_int_t, O:ydb_string_t *[64], O:ydb_string_t *[512])
sha256: ydb_status_t mg_sha256(I:ydb_string_t *, I:ydb_int_t, O:ydb_string_t *[128], O:ydb_string_t *[512])
sha512: ydb_status_t mg_sha512(I:ydb_string_t *, I:ydb_int_t, O:ydb_string_t *[256], O:ydb_string_t *[512])
md5: ydb_status_t mg_md5(I:ydb_string_t *, I:ydb_int_t, O:ydb_string_t *[64], O:ydb_string_t *[512])
hmacsha1: ydb_status_t mg_hmac_sha1(I:ydb_string_t *, I:ydb_string_t *, I:ydb_int_t, O:ydb_string_t *[64], O:ydb_string_t *[512])
hmacsha256: ydb_status_t mg_hmac_sha256(I:ydb_string_t *, I:ydb_string_t *, I:ydb_int_t, O:ydb_string_t *[128], O:ydb_string_t *[512])
hmacsha512: ydb_status_t mg_hmac_sha512(I:ydb_string_t *, I:ydb_string_t *, I:ydb_int_t, O:ydb_string_t *[256], O:ydb_string_t *[512])
hmacmd5: ydb_status_t mg_hmac_md5(I:ydb_string_t *, I:ydb_string_t *, I:ydb_int_t, O:ydb_string_t *[64], O:ydb_string_t *[512])
encodeb64: ydb_status_t mg_encode_b64(I:ydb_string_t *, O:ydb_string_t *[32768])
decodeb64: ydb_status_t mg_decode_b64(I:ydb_string_t *, O:ydb_string_t *[32768])
crc32: ydb_status_t mg_crc32(I:ydb_string_t *, O:ydb_uint_t *)
tcpoptions: ydb_status_t mg_tcp_options(I:ydb_string_t *, O:ydb_string_t *[512])
tcpservinit: ydb_status_t mg_tcpserver_init(I:ydb_int_t, I:ydb_string_t *, O:ydb_string_t *[512])
tcpservaccept: ydb_status_t mg_tcpserver_accept(O:ydb_string_t *[512], O:ydb_string_t *[512])
tcpservclose: ydb_status_t mg_tcpserver_close(I:ydb_string_t *)
tcpchldinit: ydb_status_t mg_tcpchild_init(I:ydb_string_t *, I:ydb_string_t *, O:ydb_string_t *[512])
tcpwrite: ydb_status_t mg_tcpchild_send(I:ydb_string_t *, I:ydb_int_t, O:ydb_string_t *[512])
tcpread: ydb_status_t mg_tcpchild_recv(O:ydb_string_t *[32768], I:ydb_int_t, I:ydb_int_t, O:ydb_string_t *[512])
tcpreadascii: ydb_status_t mg_tcpchild_recv_ascii(O:ydb_int_t *, I:ydb_int_t, O:ydb_string_t *[512])
tcpreadmessage: ydb_status_t mg_tcpchild_recv_message(O:ydb_string_t *[32768], O:ydb_int_t *, O:ydb_int_t *, I:ydb_int_t, O:ydb_string_t *[512])
tcpclose: ydb_status_t mg_tcpchild_close()

