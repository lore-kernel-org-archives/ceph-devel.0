From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ceph: use an enum instead of 'static const' to define constants
Date: Fri,  5 Oct 2018 18:18:38 +0200
Message-ID: <20181005161845.959919-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Luis Henriques <lhenriques@suse.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Building with W=1 produces lots of warnings for files including
ceph_features.h:

include/linux/ceph/ceph_features.h:15:24: error: 'CEPH_FEATUREMASK_SERVER_M' defined but not used [-Werror=unused-const-variable=]

The normal way to define compile-time constants in the kernel is
to use either macros or enums, and gcc does not warn about those.

Converting to an enum is simple here and means we can still use
the names while debugging.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/ceph/ceph_features.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 6b92b3395fa9..676908eca060 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -11,15 +11,15 @@
 #define CEPH_FEATURE_INCARNATION_2 (1ull<<57) // CEPH_FEATURE_SERVER_JEWEL
 
 #define DEFINE_CEPH_FEATURE(bit, incarnation, name)			\
-	static const uint64_t CEPH_FEATURE_##name = (1ULL<<bit);		\
-	static const uint64_t CEPH_FEATUREMASK_##name =			\
-		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
+	CEPH_FEATURE_##name = (1ULL<<bit),				\
+	CEPH_FEATUREMASK_##name =					\
+		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation),
 
 /* this bit is ignored but still advertised by release *when* */
-#define DEFINE_CEPH_FEATURE_DEPRECATED(bit, incarnation, name, when) \
-	static const uint64_t DEPRECATED_CEPH_FEATURE_##name = (1ULL<<bit); \
-	static const uint64_t DEPRECATED_CEPH_FEATUREMASK_##name =		\
-		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
+#define DEFINE_CEPH_FEATURE_DEPRECATED(bit, incarnation, name, when)	\
+	DEPRECATED_CEPH_FEATURE_##name = (1ULL<<bit),			\
+	DEPRECATED_CEPH_FEATUREMASK_##name =				\
+		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation),
 
 /*
  * this bit is ignored by release *unused* and not advertised by
@@ -71,7 +71,7 @@
  * This ensures that no two versions who have different meanings for
  * the bit ever speak to each other.
  */
-
+enum ceph_features {
 DEFINE_CEPH_FEATURE( 0, 1, UID)
 DEFINE_CEPH_FEATURE( 1, 1, NOSRCADDR)
 DEFINE_CEPH_FEATURE_RETIRED( 2, 1, MONCLOCKCHECK, JEWEL, LUMINOUS)
@@ -170,13 +170,13 @@ DEFINE_CEPH_FEATURE(61, 1, CEPHX_V2)             // *do not share this bit*
 
 DEFINE_CEPH_FEATURE(62, 1, RESERVED)           // do not use; used as a sentinal
 DEFINE_CEPH_FEATURE_DEPRECATED(63, 1, RESERVED_BROKEN, LUMINOUS) // client-facing
-
+};
 
 /*
  * Features supported.
  */
 #define CEPH_FEATURES_SUPPORTED_DEFAULT		\
-	(CEPH_FEATURE_NOSRCADDR |		\
+	(u64)(CEPH_FEATURE_NOSRCADDR |		\
 	 CEPH_FEATURE_FLOCK |			\
 	 CEPH_FEATURE_SUBSCRIBE2 |		\
 	 CEPH_FEATURE_RECONNECT_SEQ |		\
-- 
2.18.0
