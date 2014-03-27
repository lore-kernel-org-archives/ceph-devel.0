From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 04/33] libceph: dump osdmap and enhance output on decode errors
Date: Thu, 27 Mar 2014 20:17:50 +0200
Message-ID: <1395944299-21970-5-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:48597 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaC0SSd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:33 -0400
Received: by mail-ee0-f50.google.com with SMTP id c13so3202675eek.37
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:32 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id z48sm5959272eel.27.2014.03.27.11.18.31
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:32 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Dump osdmap in hex on both full and incremental decode errors, to make
it easier to match the contents with error offset.  dout() map epoch
and max_osd value on success.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |   21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 9d1aaa24def6..4dd000d128fd 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -690,6 +690,7 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 	u16 version;
 	u32 len, max, i;
 	int err = -EINVAL;
+	u32 epoch = 0;
 	void *start = *p;
 	struct ceph_pg_pool_info *pi;
 
@@ -714,7 +715,7 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 
 	ceph_decode_need(p, end, 2*sizeof(u64)+6*sizeof(u32), bad);
 	ceph_decode_copy(p, &map->fsid, sizeof(map->fsid));
-	map->epoch = ceph_decode_32(p);
+	epoch = map->epoch = ceph_decode_32(p);
 	ceph_decode_copy(p, &map->created, sizeof(map->created));
 	ceph_decode_copy(p, &map->modified, sizeof(map->modified));
 
@@ -814,14 +815,18 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 		goto bad;
 	}
 
-	/* ignore the rest of the map */
+	/* ignore the rest */
 	*p = end;
 
-	dout("osdmap_decode done %p %p\n", *p, end);
+	dout("full osdmap epoch %d max_osd %d\n", map->epoch, map->max_osd);
 	return map;
 
 bad:
-	dout("osdmap_decode fail err %d\n", err);
+	pr_err("corrupt full osdmap (%d) epoch %d off %d (%p of %p-%p)\n",
+	       err, epoch, (int)(*p - start), *p, start, end);
+	print_hex_dump(KERN_DEBUG, "osdmap: ",
+		       DUMP_PREFIX_OFFSET, 16, 1,
+		       start, end - start, true);
 	ceph_osdmap_destroy(map);
 	return ERR_PTR(err);
 }
@@ -845,6 +850,8 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 	int err = -EINVAL;
 	u16 version;
 
+	dout("%s %p to %p len %d\n", __func__, *p, end, (int)(end - *p));
+
 	ceph_decode_16_safe(p, end, version, bad);
 	if (version != 6) {
 		pr_warning("got unknown v %d != 6 of inc osdmap\n", version);
@@ -1032,11 +1039,13 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 
 	/* ignore the rest */
 	*p = end;
+
+	dout("inc osdmap epoch %d max_osd %d\n", map->epoch, map->max_osd);
 	return map;
 
 bad:
-	pr_err("corrupt inc osdmap epoch %d off %d (%p of %p-%p)\n",
-	       epoch, (int)(*p - start), *p, start, end);
+	pr_err("corrupt inc osdmap (%d) epoch %d off %d (%p of %p-%p)\n",
+	       err, epoch, (int)(*p - start), *p, start, end);
 	print_hex_dump(KERN_DEBUG, "osdmap: ",
 		       DUMP_PREFIX_OFFSET, 16, 1,
 		       start, end - start, true);
-- 
1.7.10.4

