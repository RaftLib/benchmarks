#! /usr/bin/env perl
# Copyright 2007-2020 The OpenSSL Project Authors. All Rights Reserved.
# Copyright Nokia 2007-2019
# Copyright Siemens AG 2015-2019
#
# Licensed under the Apache License 2.0 (the "License").  You may not use
# this file except in compliance with the License.  You can obtain a copy
# in the file LICENSE in the source distribution or at
# https://www.openssl.org/source/license.html

use strict;
use OpenSSL::Test qw/:DEFAULT data_file/;
use OpenSSL::Test::Utils;

setup("test_cmp_client");

plan skip_all => "This test is not supported in a no-cmp or no-ec build"
    if disabled("cmp") || disabled("ec");

plan tests => 1;

ok(run(test(["cmp_client_test",
             data_file("server.key"),
             data_file("server.crt"),
             data_file("client.key"),
             data_file("client.crt"),
             data_file("client.csr")])));
