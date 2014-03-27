From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 17/33] libceph: introduce get_osdmap_client_data_v()
Date: Thu, 27 Mar 2014 20:18:03 +0200
Message-ID: <1395944299-21970-18-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:45763 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757121AbaC0STD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:03 -0400
Received: by mail-ee0-f53.google.com with SMTP id b57so3199182eek.40
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:02 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id s46sm5991109ees.3.2014.03.27.11.19.01
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:02 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Full and incremental osdmaps are structured identically and have
identical headers.  Add a helper to decode both "old" (16-bit version,
v6) and "new" (8-bit struct_v+struct_compat+struct_len, v7) osdmap
enconding headers and switch to it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |   81 ++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 65 insertions(+), 16 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 0134df3639d2..ae96c73aff71 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -683,6 +683,63 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
 	return 0;
 }
 
+#define OSDMAP_WRAPPER_COMPAT_VER	7
+#define OSDMAP_CLIENT_DATA_COMPAT_VER	1
+
+/*
+ * Return 0 or error.  On success, *v is set to 0 for old (v6) osdmaps,
+ * to struct_v of the client_data section for new (v7 and above)
+ * osdmaps.
+ */
+static int get_osdmap_client_data_v(void **p, void *end,
+				    const char *s, u8 *v)
+{
+	u8 struct_v;
+
+	ceph_decode_8_safe(p, end, struct_v, e_inval);
+	if (struct_v >= 7) {
+		u8 struct_compat;
+
+		ceph_decode_8_safe(p, end, struct_compat, e_inval);
+		if (struct_compat > OSDMAP_WRAPPER_COMPAT_VER) {
+			pr_warning("got v %d cv %d > %d of %s ceph_osdmap\n",
+				   struct_v, struct_compat,
+				   OSDMAP_WRAPPER_COMPAT_VER, s);
+			return -EINVAL;
+		}
+		*p += 4; /* ignore wrapper struct_len */
+
+		ceph_decode_8_safe(p, end, struct_v, e_inval);
+		ceph_decode_8_safe(p, end, struct_compat, e_inval);
+		if (struct_compat > OSDMAP_CLIENT_DATA_COMPAT_VER) {
+			pr_warning("got v %d cv %d > %d of %s ceph_osdmap client data\n",
+				   struct_v, struct_compat,
+				   OSDMAP_CLIENT_DATA_COMPAT_VER, s);
+			return -EINVAL;
+		}
+		*p += 4; /* ignore client data struct_len */
+	} else {
+		u16 version;
+
+		*p -= 1;
+		ceph_decode_16_safe(p, end, version, e_inval);
+		if (version < 6) {
+			pr_warning("got v %d < 6 of %s ceph_osdmap\n", version,
+				   s);
+			return -EINVAL;
+		}
+
+		/* old osdmap enconding */
+		struct_v = 0;
+	}
+
+	*v = struct_v;
+	return 0;
+
+e_inval:
+	return -EINVAL;
+}
+
 static int __decode_pools(void **p, void *end, struct ceph_osdmap *map,
 			  bool incremental)
 {
@@ -798,7 +855,7 @@ static int decode_new_pg_temp(void **p, void *end, struct ceph_osdmap *map)
  */
 static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 {
-	u16 version;
+	u8 struct_v;
 	u32 epoch = 0;
 	void *start = *p;
 	u32 max;
@@ -807,15 +864,9 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 
 	dout("%s %p to %p len %d\n", __func__, *p, end, (int)(end - *p));
 
-	ceph_decode_16_safe(p, end, version, e_inval);
-	if (version > 6) {
-		pr_warning("got unknown v %d > 6 of osdmap\n", version);
-		goto e_inval;
-	}
-	if (version < 6) {
-		pr_warning("got old v %d < 6 of osdmap\n", version);
-		goto e_inval;
-	}
+	err = get_osdmap_client_data_v(p, end, "full", &struct_v);
+	if (err)
+		goto bad;
 
 	/* fsid, epoch, created, modified */
 	ceph_decode_need(p, end, sizeof(map->fsid) + sizeof(u32) +
@@ -937,15 +988,13 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 	__s32 new_flags, max;
 	void *start = *p;
 	int err;
-	u16 version;
+	u8 struct_v;
 
 	dout("%s %p to %p len %d\n", __func__, *p, end, (int)(end - *p));
 
-	ceph_decode_16_safe(p, end, version, e_inval);
-	if (version != 6) {
-		pr_warning("got unknown v %d != 6 of inc osdmap\n", version);
-		goto e_inval;
-	}
+	err = get_osdmap_client_data_v(p, end, "inc", &struct_v);
+	if (err)
+		goto bad;
 
 	/* fsid, epoch, modified, new_pool_max, new_flags */
 	ceph_decode_need(p, end, sizeof(fsid) + sizeof(u32) + sizeof(modified) +
-- 
1.7.10.4

