From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 12/33] libceph: fix and clarify ceph_decode_need() sizes
Date: Thu, 27 Mar 2014 20:17:58 +0200
Message-ID: <1395944299-21970-13-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f45.google.com ([74.125.83.45]:52685 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756966AbaC0SSw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:52 -0400
Received: by mail-ee0-f45.google.com with SMTP id d17so3246535eek.32
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:51 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id 48sm5992191eee.2.2014.03.27.11.18.50
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:50 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sum up sizeof(...) results instead of (incorrectly) hard-coding the
number of bytes, expressed in ints and longs.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 75e192e99173..6dd083906a1e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -706,7 +706,9 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 		goto e_inval;
 	}
 
-	ceph_decode_need(p, end, 2*sizeof(u64)+6*sizeof(u32), e_inval);
+	/* fsid, epoch, created, modified */
+	ceph_decode_need(p, end, sizeof(map->fsid) + sizeof(u32) +
+			 sizeof(map->created) + sizeof(map->modified), e_inval);
 	ceph_decode_copy(p, &map->fsid, sizeof(map->fsid));
 	epoch = map->epoch = ceph_decode_32(p);
 	ceph_decode_copy(p, &map->created, sizeof(map->created));
@@ -872,8 +874,9 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 		goto e_inval;
 	}
 
-	ceph_decode_need(p, end, sizeof(fsid)+sizeof(modified)+2*sizeof(u32),
-			 e_inval);
+	/* fsid, epoch, modified, new_pool_max, new_flags */
+	ceph_decode_need(p, end, sizeof(fsid) + sizeof(u32) + sizeof(modified) +
+			 sizeof(u64) + sizeof(u32), e_inval);
 	ceph_decode_copy(p, &fsid, sizeof(fsid));
 	epoch = ceph_decode_32(p);
 	BUG_ON(epoch != map->epoch+1);
@@ -907,10 +910,8 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 	if (new_pool_max >= 0)
 		map->pool_max = new_pool_max;
 
-	ceph_decode_need(p, end, 5*sizeof(u32), e_inval);
-
 	/* new max? */
-	max = ceph_decode_32(p);
+	ceph_decode_32_safe(p, end, max, e_inval);
 	if (max >= 0) {
 		err = osdmap_set_max_osd(map, max);
 		if (err)
-- 
1.7.10.4

