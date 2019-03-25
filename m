From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] [v2] ceph: fix clang warning for CEPH_DEFINE_OID_ONSTACK
Date: Mon, 25 Mar 2019 13:51:43 +0100
Message-ID: <20190325125147.1436083-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Alex Elder <elder@linaro.org>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

clang complains about assigning a variable to itself during the
declaration:

fs/ceph/ioctl.c:187:26: error: variable 'oid' is uninitialized when used within its own initialization [-Werror,-Wuninitialized]
        CEPH_DEFINE_OID_ONSTACK(oid);
                                ^~~
include/linux/ceph/osdmap.h:122:52: note: expanded from macro 'CEPH_DEFINE_OID_ONSTACK'
        struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
                              ~~~                         ^~~
include/linux/ceph/osdmap.h:120:29: note: expanded from macro 'CEPH_OID_INIT_ONSTACK'
    ({ ceph_oid_init(&oid); oid; })
                            ^~~

We use this trick in other places, but it is completely unnecessary
here, as we can just use a regular struct initializer.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: rearrange to only have one instance of the initializer
---
 include/linux/ceph/osdmap.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 5675b1f09bc5..8794cf0f0b39 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -110,17 +110,16 @@ struct ceph_object_id {
 	int name_len;
 };
 
+#define CEPH_OID_INITIALIZER(oid) { .name = (oid).inline_name }
+
+#define CEPH_DEFINE_OID_ONSTACK(oid)				\
+	struct ceph_object_id oid = CEPH_OID_INITIALIZER(oid)
+
 static inline void ceph_oid_init(struct ceph_object_id *oid)
 {
-	oid->name = oid->inline_name;
-	oid->name_len = 0;
+	*oid = (struct ceph_object_id)CEPH_OID_INITIALIZER(*oid);
 }
 
-#define CEPH_OID_INIT_ONSTACK(oid)					\
-    ({ ceph_oid_init(&oid); oid; })
-#define CEPH_DEFINE_OID_ONSTACK(oid)					\
-	struct ceph_object_id oid = CEPH_OID_INIT_ONSTACK(oid)
-
 static inline bool ceph_oid_empty(const struct ceph_object_id *oid)
 {
 	return oid->name == oid->inline_name && !oid->name_len;
-- 
2.20.0
