From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] libceph: fix old style declaration warnings
Date: Mon, 10 Jul 2017 13:17:26 +0200
Message-ID: <20170710111734.856154-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The new macros don't follow the usual style for declarations,
which we get a warning for with 'make W=1':

In file included from fs/ceph/mds_client.c:16:0:
include/linux/ceph/ceph_features.h:74:1: error: 'static' is not at beginning of declaration [-Werror=old-style-declaration]

This moves the 'static' keyword to the front of the
declaration.

Fixes: f179d3ba8cb9 ("libceph: new features macros")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/ceph/ceph_features.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index f0f6c537b64c..040dd105c3e7 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -10,14 +10,14 @@
 #define CEPH_FEATURE_INCARNATION_2 (1ull<<57) // CEPH_FEATURE_SERVER_JEWEL
 
 #define DEFINE_CEPH_FEATURE(bit, incarnation, name)			\
-	const static uint64_t CEPH_FEATURE_##name = (1ULL<<bit);		\
-	const static uint64_t CEPH_FEATUREMASK_##name =			\
+	static const uint64_t CEPH_FEATURE_##name = (1ULL<<bit);		\
+	static const uint64_t CEPH_FEATUREMASK_##name =			\
 		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
 
 /* this bit is ignored but still advertised by release *when* */
 #define DEFINE_CEPH_FEATURE_DEPRECATED(bit, incarnation, name, when) \
-	const static uint64_t DEPRECATED_CEPH_FEATURE_##name = (1ULL<<bit); \
-	const static uint64_t DEPRECATED_CEPH_FEATUREMASK_##name =		\
+	static const uint64_t DEPRECATED_CEPH_FEATURE_##name = (1ULL<<bit); \
+	static const uint64_t DEPRECATED_CEPH_FEATUREMASK_##name =		\
 		(1ULL<<bit | CEPH_FEATURE_INCARNATION_##incarnation);
 
 /*
-- 
2.9.0
