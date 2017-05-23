From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/5] libceph: use kbasename() and kill ceph_file_part()
Date: Tue, 23 May 2017 18:33:54 +0200
Message-ID: <1495557238-1077-2-git-send-email-idryomov@gmail.com>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35424 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935721AbdEWQeM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 12:34:12 -0400
Received: by mail-qk0-f196.google.com with SMTP id k74so23495326qke.2
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 09:34:12 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15sm784055qki.47.2017.05.23.09.34.10
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 09:34:11 -0700 (PDT)
In-Reply-To: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/ceph_debug.h |  6 +++---
 net/ceph/ceph_common.c          | 13 -------------
 2 files changed, 3 insertions(+), 16 deletions(-)

diff --git a/include/linux/ceph/ceph_debug.h b/include/linux/ceph/ceph_debug.h
index aa2e19182d99..51c5bd64bd00 100644
--- a/include/linux/ceph/ceph_debug.h
+++ b/include/linux/ceph/ceph_debug.h
@@ -3,6 +3,8 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/string.h>
+
 #ifdef CONFIG_CEPH_LIB_PRETTYDEBUG
 
 /*
@@ -12,12 +14,10 @@
  */
 
 # if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
-extern const char *ceph_file_part(const char *s, int len);
 #  define dout(fmt, ...)						\
 	pr_debug("%.*s %12.12s:%-4d : " fmt,				\
 		 8 - (int)sizeof(KBUILD_MODNAME), "    ",		\
-		 ceph_file_part(__FILE__, sizeof(__FILE__)),		\
-		 __LINE__, ##__VA_ARGS__)
+		 kbasename(__FILE__), __LINE__, ##__VA_ARGS__)
 # else
 /* faux printk call just to see any compiler warnings. */
 #  define dout(fmt, ...)	do {				\
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 4fd02831beed..47e94b560ba0 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -56,19 +56,6 @@ static const struct kernel_param_ops param_ops_supported_features = {
 module_param_cb(supported_features, &param_ops_supported_features, NULL,
 		S_IRUGO);
 
-/*
- * find filename portion of a path (/foo/bar/baz -> baz)
- */
-const char *ceph_file_part(const char *s, int len)
-{
-	const char *e = s + len;
-
-	while (e != s && *(e-1) != '/')
-		e--;
-	return e;
-}
-EXPORT_SYMBOL(ceph_file_part);
-
 const char *ceph_msg_type_name(int type)
 {
 	switch (type) {
-- 
2.4.3

