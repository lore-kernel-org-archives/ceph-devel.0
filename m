From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] libceph: add a compatibility check interface
Date: Wed, 30 Jan 2013 14:49:04 -0600
Message-ID: <51098740.2000200@inktank.com>
References: <510986E4.7050901@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f169.google.com ([209.85.210.169]:63042 "EHLO
	mail-ia0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169Ab3A3UtC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 15:49:02 -0500
Received: by mail-ia0-f169.google.com with SMTP id j5so3000377iaf.28
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jan 2013 12:49:01 -0800 (PST)
In-Reply-To: <510986E4.7050901@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

An upcoming change implements semantic change that could lead to
a crash if an old version of the libceph kernel module is used with
a new version of the rbd kernel module.

In order to preclude that possibility, this adds a compatibilty
check interface.  If this interface doesn't exist, the modules are
obviously not compatible.  But if it does exist, this provides a way
of letting the caller know whether it will operate properly with
this libceph module.

Perhaps confusingly, it returns false right now.  The semantic
change mentioned above will make it return true.

This resolves:
    http://tracker.ceph.com/issues/3800

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/libceph.h |    2 ++
 net/ceph/ceph_common.c       |   16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 084d3c6..c44275a 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -193,6 +193,8 @@ static inline int calc_pages_for(u64 off, u64 len)
 }

 /* ceph_common.c */
+extern bool libceph_compatible(void *data);
+
 extern const char *ceph_msg_type_name(int type);
 extern int ceph_check_fsid(struct ceph_client *client, struct ceph_fsid
*fsid);
 extern struct kmem_cache *ceph_inode_cachep;
diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index ee71ea2..a98c03f 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -26,6 +26,22 @@
 #include "crypto.h"


+/*
+ * Module compatibility interface.  For now it doesn't do anything,
+ * but its existence signals a certain level of functionality.
+ *
+ * The data buffer is used to pass information both to and from
+ * libceph.  The return value indicates whether libceph determines
+ * it is compatible with the caller (from another kernel module),
+ * given the provided data.
+ *
+ * The data pointer can be null.
+ */
+bool libceph_compatible(void *data)
+{
+	return false;
+}
+EXPORT_SYMBOL(libceph_compatible);

 /*
  * find filename portion of a path (/foo/bar/baz -> baz)
-- 
1.7.9.5

