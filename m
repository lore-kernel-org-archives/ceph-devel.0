From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 24/33] libceph: ceph_osd_{exists,is_up,is_down}(osd) definitions
Date: Thu, 27 Mar 2014 20:18:10 +0200
Message-ID: <1395944299-21970-25-git-send-email-ilya.dryomov@inktank.com>
References: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f44.google.com ([74.125.83.44]:62943 "EHLO
	mail-ee0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757144AbaC0STU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Mar 2014 14:19:20 -0400
Received: by mail-ee0-f44.google.com with SMTP id e49so3216173eek.31
        for <ceph-devel@vger.kernel.org>; Thu, 27 Mar 2014 11:19:19 -0700 (PDT)
Received: from localhost ([109.110.66.7])
        by mx.google.com with ESMTPSA id m8sm5982600eeg.11.2014.03.27.11.19.18
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 27 Mar 2014 11:19:18 -0700 (PDT)
In-Reply-To: <1395944299-21970-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sync up with ceph.git definitions.  Bring in ceph_osd_is_down().

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 6e030cb3c9ca..0895797b9e28 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -125,9 +125,21 @@ static inline void ceph_oid_copy(struct ceph_object_id *dest,
 	dest->name_len = src->name_len;
 }
 
+static inline int ceph_osd_exists(struct ceph_osdmap *map, int osd)
+{
+	return osd >= 0 && osd < map->max_osd &&
+	       (map->osd_state[osd] & CEPH_OSD_EXISTS);
+}
+
 static inline int ceph_osd_is_up(struct ceph_osdmap *map, int osd)
 {
-	return (osd < map->max_osd) && (map->osd_state[osd] & CEPH_OSD_UP);
+	return ceph_osd_exists(map, osd) &&
+	       (map->osd_state[osd] & CEPH_OSD_UP);
+}
+
+static inline int ceph_osd_is_down(struct ceph_osdmap *map, int osd)
+{
+	return !ceph_osd_is_up(map, osd);
 }
 
 static inline bool ceph_osdmap_flag(struct ceph_osdmap *map, int flag)
-- 
1.7.10.4

