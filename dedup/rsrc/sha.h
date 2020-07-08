/* Proxy SHA1 header file for PARSEC Benchmark Suite
 * Written by Christian Bienia
 *
 * This file includes the OpenSSL headers and defines some macros so that
 * the extracted SHA1 code can be used without the rest of the OpenSSL
 * package.
 */
#ifndef _SHA_H_
#define _SHA_H_

#include "openssl/sha.h"

/* SHA1 length is 20 bytes(160 bites) */
#define SHA1_LEN  20

void SHA1_Digest(const void *data, size_t len, unsigned char *digest);

#define SHA_1
#include "openssl/sha_locl.h"

void SHA1_Digest(const void *data, size_t len, unsigned char *digest) {
  SHA_CTX sha;

  SHA1_Init(&sha);
  SHA1_Update(&sha, data, len);
  SHA1_Final(digest, &sha);
}


#endif //_SHA_H_

