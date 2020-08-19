/*
 * Generated by util/mkerr.pl DO NOT EDIT
 * Copyright 1995-2020 The OpenSSL Project Authors. All Rights Reserved.
 *
 * Licensed under the Apache License 2.0 (the "License").  You may not use
 * this file except in compliance with the License.  You can obtain a copy
 * in the file LICENSE in the source distribution or at
 * https://www.openssl.org/source/license.html
 */

#include <openssl/err.h>
#include <openssl/evperr.h>

#ifndef OPENSSL_NO_ERR

static const ERR_STRING_DATA EVP_str_reasons[] = {
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_AES_KEY_SETUP_FAILED),
    "aes key setup failed"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_ARIA_KEY_SETUP_FAILED),
    "aria key setup failed"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_BAD_ALGORITHM_NAME), "bad algorithm name"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_BAD_DECRYPT), "bad decrypt"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_BAD_KEY_LENGTH), "bad key length"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_BUFFER_TOO_SMALL), "buffer too small"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_CAMELLIA_KEY_SETUP_FAILED),
    "camellia key setup failed"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_CANNOT_GET_PARAMETERS),
    "cannot get parameters"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_CANNOT_SET_PARAMETERS),
    "cannot set parameters"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_CIPHER_NOT_GCM_MODE),
    "cipher not gcm mode"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_CIPHER_PARAMETER_ERROR),
    "cipher parameter error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_COMMAND_NOT_SUPPORTED),
    "command not supported"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_CONFLICTING_ALGORITHM_NAME),
    "conflicting algorithm name"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_COPY_ERROR), "copy error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_CTRL_NOT_IMPLEMENTED),
    "ctrl not implemented"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_CTRL_OPERATION_NOT_IMPLEMENTED),
    "ctrl operation not implemented"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_DATA_NOT_MULTIPLE_OF_BLOCK_LENGTH),
    "data not multiple of block length"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_DECODE_ERROR), "decode error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_DEFAULT_QUERY_PARSE_ERROR),
    "default query parse error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_DIFFERENT_KEY_TYPES),
    "different key types"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_DIFFERENT_PARAMETERS),
    "different parameters"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_ERROR_LOADING_SECTION),
    "error loading section"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_ERROR_SETTING_FIPS_MODE),
    "error setting fips mode"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_EXPECTING_AN_HMAC_KEY),
    "expecting an hmac key"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_EXPECTING_AN_RSA_KEY),
    "expecting an rsa key"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_EXPECTING_A_DH_KEY), "expecting a dh key"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_EXPECTING_A_DSA_KEY),
    "expecting a dsa key"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_EXPECTING_A_EC_KEY), "expecting a ec key"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_EXPECTING_A_POLY1305_KEY),
    "expecting a poly1305 key"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_EXPECTING_A_SIPHASH_KEY),
    "expecting a siphash key"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_FETCH_FAILED), "fetch failed"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_FINAL_ERROR), "final error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_FIPS_MODE_NOT_SUPPORTED),
    "fips mode not supported"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_GENERATE_ERROR), "generate error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_GET_RAW_KEY_FAILED), "get raw key failed"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_ILLEGAL_SCRYPT_PARAMETERS),
    "illegal scrypt parameters"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INACCESSIBLE_DOMAIN_PARAMETERS),
    "inaccessible domain parameters"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INACCESSIBLE_KEY), "inaccessible key"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INITIALIZATION_ERROR),
    "initialization error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INPUT_NOT_INITIALIZED),
    "input not initialized"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_CUSTOM_LENGTH),
    "invalid custom length"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_DIGEST), "invalid digest"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_FIPS_MODE), "invalid fips mode"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_IV_LENGTH), "invalid iv length"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_KEY), "invalid key"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_KEY_LENGTH), "invalid key length"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_NULL_ALGORITHM),
    "invalid null algorithm"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_OPERATION), "invalid operation"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_PROVIDER_FUNCTIONS),
    "invalid provider functions"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_INVALID_SALT_LENGTH),
    "invalid salt length"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_KEYGEN_FAILURE), "keygen failure"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_KEYMGMT_EXPORT_FAILURE),
    "keymgmt export failure"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_KEY_SETUP_FAILED), "key setup failed"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_LOCKING_NOT_SUPPORTED),
    "locking not supported"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_MEMORY_LIMIT_EXCEEDED),
    "memory limit exceeded"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_MESSAGE_DIGEST_IS_NULL),
    "message digest is null"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_METHOD_NOT_SUPPORTED),
    "method not supported"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_MISSING_PARAMETERS), "missing parameters"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NOT_ABLE_TO_COPY_CTX),
    "not able to copy ctx"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NOT_XOF_OR_INVALID_LENGTH),
    "not XOF or invalid length"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NO_CIPHER_SET), "no cipher set"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NO_DEFAULT_DIGEST), "no default digest"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NO_DIGEST_SET), "no digest set"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NO_IMPORT_FUNCTION), "no import function"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NO_KEYMGMT_AVAILABLE),
    "no keymgmt available"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NO_KEYMGMT_PRESENT), "no keymgmt present"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NO_KEY_SET), "no key set"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NO_OPERATION_SET), "no operation set"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_NULL_MAC_PKEY_CTX), "null mac pkey ctx"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_ONLY_ONESHOT_SUPPORTED),
    "only oneshot supported"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_OPERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE),
    "operation not supported for this keytype"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_OPERATON_NOT_INITIALIZED),
    "operation not initialized"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_PARAMETER_TOO_LARGE),
    "parameter too large"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_PARTIALLY_OVERLAPPING),
    "partially overlapping buffers"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_PBKDF2_ERROR), "pbkdf2 error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_PKEY_APPLICATION_ASN1_METHOD_ALREADY_REGISTERED),
    "pkey application asn1 method already registered"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_PRIVATE_KEY_DECODE_ERROR),
    "private key decode error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_PRIVATE_KEY_ENCODE_ERROR),
    "private key encode error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_PUBLIC_KEY_NOT_RSA), "public key not rsa"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_SET_DEFAULT_PROPERTY_FAILURE),
    "set default property failure"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_TOO_MANY_RECORDS), "too many records"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNABLE_TO_ENABLE_PARENT_LOCKING),
    "unable to enable parent locking"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNABLE_TO_GET_MAXIMUM_REQUEST_SIZE),
    "unable to get maximum request size"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNABLE_TO_GET_RANDOM_STRENGTH),
    "unable to get random strength"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNABLE_TO_LOCK_CONTEXT),
    "unable to lock context"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNABLE_TO_SET_CALLBACKS),
    "unable to set callbacks"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNKNOWN_CIPHER), "unknown cipher"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNKNOWN_DIGEST), "unknown digest"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNKNOWN_KEY_TYPE), "unknown key type"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNKNOWN_OPTION), "unknown option"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNKNOWN_PBE_ALGORITHM),
    "unknown pbe algorithm"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNSUPPORTED_ALGORITHM),
    "unsupported algorithm"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNSUPPORTED_CIPHER), "unsupported cipher"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNSUPPORTED_KEYLENGTH),
    "unsupported keylength"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNSUPPORTED_KEY_DERIVATION_FUNCTION),
    "unsupported key derivation function"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNSUPPORTED_KEY_SIZE),
    "unsupported key size"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNSUPPORTED_NUMBER_OF_ROUNDS),
    "unsupported number of rounds"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNSUPPORTED_PRF), "unsupported prf"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNSUPPORTED_PRIVATE_KEY_ALGORITHM),
    "unsupported private key algorithm"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UNSUPPORTED_SALT_TYPE),
    "unsupported salt type"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_UPDATE_ERROR), "update error"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_WRAP_MODE_NOT_ALLOWED),
    "wrap mode not allowed"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_WRONG_FINAL_BLOCK_LENGTH),
    "wrong final block length"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_XTS_DATA_UNIT_IS_TOO_LARGE),
    "xts data unit is too large"},
    {ERR_PACK(ERR_LIB_EVP, 0, EVP_R_XTS_DUPLICATED_KEYS),
    "xts duplicated keys"},
    {0, NULL}
};

#endif

int ERR_load_EVP_strings(void)
{
#ifndef OPENSSL_NO_ERR
    if (ERR_reason_error_string(EVP_str_reasons[0].error) == NULL)
        ERR_load_strings_const(EVP_str_reasons);
#endif
    return 1;
}