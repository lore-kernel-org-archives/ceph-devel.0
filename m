From: Christian Brunner <chb@muc.de>
Subject: [PATCH 1/2] extended crypto classes
Date: Thu, 25 Aug 2011 13:02:31 +0200
Message-ID: <20110825110231.GA6517@sir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45277 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab1HYLD7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Aug 2011 07:03:59 -0400
Received: by bke11 with SMTP id 11so1624173bke.19
        for <ceph-devel@vger.kernel.org>; Thu, 25 Aug 2011 04:03:58 -0700 (PDT)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch extends the ceph crypto classes:

- map CryptoPP::HashTransformation to ceph::crypto::Digest (for cryptopp)
- add DigestSize() to ceph::crypto::Digest (for libnss)

Thanks,
Christian
---
 src/common/ceph_crypto.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/common/ceph_crypto.h b/src/common/ceph_crypto.h
index 23a0589..7082317 100644
--- a/src/common/ceph_crypto.h
+++ b/src/common/ceph_crypto.h
@@ -11,6 +11,7 @@
 #ifdef USE_CRYPTOPP
 # define CRYPTOPP_ENABLE_NAMESPACE_WEAK 1
 #include <string.h>
+# include <cryptopp/cryptlib.h>
 # include <cryptopp/md5.h>
 # include <cryptopp/sha.h>
 # include <cryptopp/hmac.h>
@@ -32,6 +33,8 @@ namespace ceph {
 	}
       ~HMACSHA1();
     };
+
+    class Digest : public CryptoPP::HashTransformation { };
   }
 }
 #elif USE_NSS
@@ -86,6 +89,9 @@ namespace ceph {
 	assert(dummy == digest_size);
 	Restart();
       }
+      size_t DigestSize() {
+        return digest_size;
+      }
     };
     class MD5 : public Digest {
     public:
-- 
1.7.1


