From: Casey Bodley <cbodley@redhat.com>
Subject: c++17: compilation failures with cryptopp (when cmake -DWITH_NSS=OFF)
Date: Wed, 17 Jan 2018 13:36:19 -0500
Message-ID: <0e6e3365-714d-0752-db17-6b823185451a@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:38942 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752268AbeAQSgW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jan 2018 13:36:22 -0500
Received: by mail-oi0-f41.google.com with SMTP id t8so13835770oie.6
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jan 2018 10:36:22 -0800 (PST)
Received: from [10.17.151.126] ([12.118.3.106])
        by smtp.gmail.com with ESMTPSA id r12sm2367872ota.54.2018.01.17.10.36.20
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jan 2018 10:36:20 -0800 (PST)
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

I'm trying to pick up Adam's crypto rework branch 
(https://github.com/ceph/ceph/pull/14498), and found that our cryptopp 
implementation was broken with the switch to c++17. Cryptopp adds a 
'typedef unsigned char byte' to the global namespace that conflicts with 
std::byte whenever 'using namespace std' is present (which is almost 
everywhere in ceph).

I've been able to fix some parts of the codebase by shuffling around the 
#include order for ceph_crypto.h to get it above any other ceph headers. 
For radosgw, though, it's included by rgw_common.h and pulled into every 
source file. I worry that if I go through and fix everything so it 
builds, it will just break again without regular testing.

Do we know of anyone that still relies on this cryptopp implementation? 
It doesn't look like we use it in any of our packaging.


Example compilation failure:

In file included from /usr/include/cryptopp/iterhash.h:4:0,
                  from /usr/include/cryptopp/md5.h:4,
                  from /home/cbodley/ceph/src/common/ceph_crypto.h:15,
                  from /home/cbodley/ceph/src/common/ceph_context.cc:27:
/usr/include/cryptopp/cryptlib.h:523:28: error: reference to ‘byte’ is 
ambiguous
   virtual void SetKey(const byte *key, size_t length, const 
NameValuePairs &params = g_nullNameValuePairs);
^~~~
In file included from /usr/include/cryptopp/cryptlib.h:86:0,
                  from /usr/include/cryptopp/iterhash.h:4,
                  from /usr/include/cryptopp/md5.h:4,
                  from /home/cbodley/ceph/src/common/ceph_crypto.h:15,
                  from /home/cbodley/ceph/src/common/ceph_context.cc:27:
/usr/include/cryptopp/config.h:172:23: note: candidates are: typedef 
unsigned char byte
  typedef unsigned char byte;  // put in global namespace to avoid 
ambiguity with other byte typedefs
^~~~
In file included from 
/home/cbodley/ceph/build/boost/include/boost/config/compiler/gcc.hpp:165:0,
                  from 
/home/cbodley/ceph/build/boost/include/boost/config.hpp:39,
                  from 
/home/cbodley/ceph/build/boost/include/boost/algorithm/string/std_containers_traits.hpp:18, 

                  from 
/home/cbodley/ceph/build/boost/include/boost/algorithm/string.hpp:18,
                  from /home/cbodley/ceph/src/common/ceph_context.cc:21:
/usr/include/c++/7/cstddef:64:14: note:                 enum class 
std::byte
    enum class byte : unsigned char {};

