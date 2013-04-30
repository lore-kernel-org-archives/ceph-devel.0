From: Alex Elder <elder@inktank.com>
Subject: [PATCH 1/2] libceph: create source file "net/ceph/snapshot.c"
Date: Tue, 30 Apr 2013 07:19:15 -0500
Message-ID: <517FB6C3.30107@inktank.com>
References: <517FB65D.5040309@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:52521 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759488Ab3D3MTR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Apr 2013 08:19:17 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so480638iee.34
        for <ceph-devel@vger.kernel.org>; Tue, 30 Apr 2013 05:19:16 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id b6sm24348236igv.5.2013.04.30.05.19.15
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 30 Apr 2013 05:19:16 -0700 (PDT)
In-Reply-To: <517FB65D.5040309@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This creates a new source file "net/ceph/snapshot.c" to contain
utility routines related to ceph snapshot contexts.  The main
motivation was to define ceph_create_snap_context() as a common way
to create these structures, but I've moved the definitions of
ceph_get_snap_context() and ceph_put_snap_context() there too.
(The benefit of inlining those is very small, and I'd rather
keep this collection of functions together.)

Signed-off-by: Alex Elder <elder@inktank.com>
---
 include/linux/ceph/libceph.h |   30 +++-------------
 net/ceph/Makefile            |    2 +-
 net/ceph/snapshot.c          |   78
++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 26 deletions(-)
 create mode 100644 net/ceph/snapshot.c

diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
index 5493d7b..2e30248 100644
--- a/include/linux/ceph/libceph.h
+++ b/include/linux/ceph/libceph.h
@@ -157,31 +157,11 @@ struct ceph_snap_context {
 	u64 snaps[];
 };

-static inline struct ceph_snap_context *
-ceph_get_snap_context(struct ceph_snap_context *sc)
-{
-	/*
-	printk("get_snap_context %p %d -> %d\n", sc, atomic_read(&sc->nref),
-	       atomic_read(&sc->nref)+1);
-	*/
-	if (sc)
-		atomic_inc(&sc->nref);
-	return sc;
-}
-
-static inline void ceph_put_snap_context(struct ceph_snap_context *sc)
-{
-	if (!sc)
-		return;
-	/*
-	printk("put_snap_context %p %d -> %d\n", sc, atomic_read(&sc->nref),
-	       atomic_read(&sc->nref)-1);
-	*/
-	if (atomic_dec_and_test(&sc->nref)) {
-		/*printk(" deleting snap_context %p\n", sc);*/
-		kfree(sc);
-	}
-}
+extern struct ceph_snap_context *ceph_create_snap_context(u32 snap_count,
+					gfp_t gfp_flags);
+extern struct ceph_snap_context *ceph_get_snap_context(
+					struct ceph_snap_context *sc);
+extern void ceph_put_snap_context(struct ceph_snap_context *sc);

 /*
  * calculate the number of pages a given length and offset map onto,
diff --git a/net/ceph/Makefile b/net/ceph/Makefile
index e87ef43..958d9856 100644
--- a/net/ceph/Makefile
+++ b/net/ceph/Makefile
@@ -11,5 +11,5 @@ libceph-y := ceph_common.o messenger.o msgpool.o
buffer.o pagelist.o \
 	crypto.o armor.o \
 	auth_x.o \
 	ceph_fs.o ceph_strings.o ceph_hash.o \
-	pagevec.o
+	pagevec.o snapshot.o

diff --git a/net/ceph/snapshot.c b/net/ceph/snapshot.c
new file mode 100644
index 0000000..154683f
--- /dev/null
+++ b/net/ceph/snapshot.c
@@ -0,0 +1,78 @@
+/*
+ * snapshot.c    Ceph snapshot context utility routines (part of libceph)
+ *
+ * Copyright (C) 2013 Inktank Storage, Inc.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+#include <stddef.h>
+
+#include <linux/types.h>
+#include <linux/export.h>
+#include <linux/ceph/libceph.h>
+
+/*
+ * Ceph snapshot contexts are reference counted objects, and the
+ * returned structure holds a single reference.  Acquire additional
+ * references with ceph_get_snap_context(), and release them with
+ * ceph_put_snap_context().  When the reference count reaches zero
+ * the entire structure is freed.
+ */
+
+/*
+ * Create a new ceph snapshot context large enough to hold the
+ * indicated number of snapshot ids (which can be 0).  Caller has
+ * to fill in snapc->seq and snapc->snaps[0..snap_count-1].
+ *
+ * Returns a null pointer if an error occurs.
+ */
+struct ceph_snap_context *ceph_create_snap_context(u32 snap_count,
+						gfp_t gfp_flags)
+{
+	struct ceph_snap_context *snapc;
+	size_t size;
+
+	size = sizeof (struct ceph_snap_context);
+	size += snap_count * sizeof (snapc->snaps[0]);
+	snapc = kzalloc(size, gfp_flags);
+	if (!snapc)
+		return NULL;
+
+	atomic_set(&snapc->nref, 1);
+	snapc->num_snaps = snap_count;
+
+	return snapc;
+}
+EXPORT_SYMBOL(ceph_create_snap_context);
+
+struct ceph_snap_context *ceph_get_snap_context(struct
ceph_snap_context *sc)
+{
+	if (sc)
+		atomic_inc(&sc->nref);
+	return sc;
+}
+EXPORT_SYMBOL(ceph_get_snap_context);
+
+void ceph_put_snap_context(struct ceph_snap_context *sc)
+{
+	if (!sc)
+		return;
+	if (atomic_dec_and_test(&sc->nref)) {
+		/*printk(" deleting snap_context %p\n", sc);*/
+		kfree(sc);
+	}
+}
+EXPORT_SYMBOL(ceph_put_snap_context);
-- 
1.7.9.5

