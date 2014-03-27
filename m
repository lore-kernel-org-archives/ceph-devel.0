From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 07/33] libceph: safely decode max_osd value in osdmap_decode()
Date: Thu, 27 Mar 2014 20:17:53 +0200
Message-ID: <1395944299-21970-8-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f49.google.com ([74.125.83.49]:60080 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754922AbaC0SSl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:18:41 -0400
Received: by mail-ee0-f49.google.com with SMTP id c41so3166010eek.22
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:18:40 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id o5sm5983562eeg.8.2014.03.27.11.18.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:18:39 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

max_osd value is not covered by any ceph_decode_need().  Use a safe
version of ceph_decode_* macro to decode it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 298d076eee89..ec06010657b3 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -687,9 +687,10 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
 static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 {
 	u16 version;
-	u32 len, max, i;
 	u32 epoch = 0;
 	void *start = *p;
+	u32 max;
+	u32 len, i;
 	int err;
 	struct ceph_pg_pool_info *pi;
 
@@ -736,7 +737,8 @@ static int osdmap_decode(void **p, void *end, struct ceph_osdmap *map)
 
 	ceph_decode_32_safe(p, end, map->flags, e_inval);
 
-	max = ceph_decode_32(p);
+	/* max_osd */
+	ceph_decode_32_safe(p, end, max, e_inval);
 
 	/* (re)alloc osd arrays */
 	err = osdmap_set_max_osd(map, max);
-- 
1.7.10.4

