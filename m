From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 22/33] libceph: primary_affinity decode bits
Date: Thu, 27 Mar 2014 20:18:08 +0200
Message-ID: <1395944299-21970-23-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:59405 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757142AbaC0STP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:15 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so3220544eek.38
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:14 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id 45sm5985670eeh.9.2014.03.27.11.19.13
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:13 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add two helpers to decode primary_affinity (full map, vector<u32>) and
new_primary_affinity (inc map, map<u32, u32>) and switch to them.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |   71 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 538b8dd341e8..3ac2098972ea 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -959,6 +959,59 @@ static int set_primary_affinity(struct ceph_osdmap *map, int osd, u32 aff)
 	return 0;
 }
 
+static int decode_primary_affinity(void **p, void *end,
+				   struct ceph_osdmap *map)
+{
+	u32 len, i;
+
+	ceph_decode_32_safe(p, end, len, e_inval);
+	if (len == 0) {
+		kfree(map->osd_primary_affinity);
+		map->osd_primary_affinity = NULL;
+		return 0;
+	}
+
+	ceph_decode_need(p, end, map->max_osd*sizeof(u32), e_inval);
+
+	BUG_ON(len != map->max_osd);
+	for (i = 0; i < map->max_osd; i++) {
+		int ret;
+
+		ret = set_primary_affinity(map, i, ceph_decode_32(p));
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+
+e_inval:
+	return -EINVAL;
+}
+
+static int decode_new_primary_affinity(void **p, void *end,
+				       struct ceph_osdmap *map)
+{
+	u32 n;
+
+	ceph_decode_32_safe(p, end, n, e_inval);
+	while (n--) {
+		u32 osd, aff;
+		int ret;
+
+		ceph_decode_32_safe(p, end, osd, e_inval);
+		ceph_decode_32_safe(p, end, aff, e_inval);
+
+		ret = set_primary_affinity(map, osd, aff);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+
+e_inval:
+	return -EINVAL;
+}
+
 /*
  * decode a full map.
  */
@@ -1036,6 +1089,17 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 			goto bad;
 	}
 
+	/* primary_affinity */
+	if (struct_v >= 2) {
+		err = decode_primary_affinity(p, end, map);
+		if (err)
+			goto bad;
+	} else {
+		/* XXX can this happen? */
+		kfree(map->osd_primary_affinity);
+		map->osd_primary_affinity = NULL;
+	}
+
 	/* crush */
 	ceph_decode_32_safe(p, end, len, e_inval);
 	map->crush = crush_decode(*p, min(*p + len, end));
@@ -1243,6 +1307,13 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 			goto bad;
 	}
 
+	/* new_primary_affinity */
+	if (struct_v >= 2) {
+		err = decode_new_primary_affinity(p, end, map);
+		if (err)
+			goto bad;
+	}
+
 	/* ignore the rest */
 	*p = end;
 
-- 
1.7.10.4

