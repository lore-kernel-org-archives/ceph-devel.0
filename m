From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 08/11] libceph: follow {read,write}_tier fields on osd request submission
Date: Mon, 27 Jan 2014 17:58:50 +0200
Message-ID: <1390838333-32266-9-git-send-email-ilya.dryomov@inktank.com>
References: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:62779 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753799AbaA0QAJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Jan 2014 11:00:09 -0500
Received: by mail-lb0-f177.google.com with SMTP id z5so4519176lbh.22
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jan 2014 08:00:08 -0800 (PST)
In-Reply-To: <1390838333-32266-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: ilya.dryomov@inktank.com

Overwrite ceph_osd_request::r_oloc.pool with read_tier for read ops and
write_tier for write and read+write ops (aka basic tiering support).
{read,write}_tier are part of pg_pool_t since v9.  This commit bumps
our pg_pool_t decode compat version from v7 to v9, all new fields
except for {read,write}_tier are ignored.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/ceph/osdmap.h |    2 ++
 net/ceph/osd_client.c       |   30 ++++++++++++++++++++++++++++--
 net/ceph/osdmap.c           |   28 +++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 7f894a64c6c7..49ff69f0746b 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -35,6 +35,8 @@ struct ceph_pg_pool_info {
 	u8 object_hash;
 	u32 pg_num, pgp_num;
 	int pg_num_mask, pgp_num_mask;
+	s64 read_tier;
+	s64 write_tier; /* wins for read+write ops */
 	u64 flags;
 	char *name;
 };
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 10360dedcdad..0eb009eaf4ff 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1250,6 +1250,32 @@ static bool __req_should_be_paused(struct ceph_osd_client *osdc,
 }
 
 /*
+ * Calculate mapping of a request to a PG.  Takes tiering into account.
+ */
+static int __calc_request_pg(struct ceph_osdmap *osdmap,
+			     struct ceph_osd_request *req,
+			     struct ceph_pg *pg_out)
+{
+	if ((req->r_flags & CEPH_OSD_FLAG_IGNORE_OVERLAY) == 0) {
+		struct ceph_pg_pool_info *pi;
+
+		pi = ceph_pg_pool_by_id(osdmap, req->r_oloc.pool);
+		if (pi) {
+			if ((req->r_flags & CEPH_OSD_FLAG_READ) &&
+			    pi->read_tier >= 0)
+				req->r_oloc.pool = pi->read_tier;
+			if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
+			    pi->write_tier >= 0)
+				req->r_oloc.pool = pi->write_tier;
+		}
+		/* !pi is caught in ceph_oloc_oid_to_pg() */
+	}
+
+	return ceph_oloc_oid_to_pg(osdmap, &req->r_oloc,
+				   &req->r_oid, pg_out);
+}
+
+/*
  * Pick an osd (the first 'up' osd in the pg), allocate the osd struct
  * (as needed), and set the request r_osd appropriately.  If there is
  * no up osd, set r_osd to NULL.  Move the request to the appropriate list
@@ -1269,8 +1295,8 @@ static int __map_request(struct ceph_osd_client *osdc,
 	bool was_paused;
 
 	dout("map_request %p tid %lld\n", req, req->r_tid);
-	err = ceph_oloc_oid_to_pg(osdc->osdmap, &req->r_oloc, &req->r_oid,
-				  &pgid);
+
+	err = __calc_request_pg(osdc->osdmap, req, &pgid);
 	if (err) {
 		list_move(&req->r_req_lru_item, &osdc->req_notarget);
 		return err;
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index d69d23556f0c..aade4a5c1c07 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -519,8 +519,8 @@ static int __decode_pool(void **p, void *end, struct ceph_pg_pool_info *pi)
 		pr_warning("got v %d < 5 cv %d of ceph_pg_pool\n", ev, cv);
 		return -EINVAL;
 	}
-	if (cv > 7) {
-		pr_warning("got v %d cv %d > 7 of ceph_pg_pool\n", ev, cv);
+	if (cv > 9) {
+		pr_warning("got v %d cv %d > 9 of ceph_pg_pool\n", ev, cv);
 		return -EINVAL;
 	}
 	len = ceph_decode_32(p);
@@ -548,12 +548,34 @@ static int __decode_pool(void **p, void *end, struct ceph_pg_pool_info *pi)
 		*p += len;
 	}
 
-	/* skip removed snaps */
+	/* skip removed_snaps */
 	num = ceph_decode_32(p);
 	*p += num * (8 + 8);
 
 	*p += 8;  /* skip auid */
 	pi->flags = ceph_decode_64(p);
+	*p += 4;  /* skip crash_replay_interval */
+
+	if (ev >= 7)
+		*p += 1;  /* skip min_size */
+
+	if (ev >= 8)
+		*p += 8 + 8;  /* skip quota_max_* */
+
+	if (ev >= 9) {
+		/* skip tiers */
+		num = ceph_decode_32(p);
+		*p += num * 8;
+
+		*p += 8;  /* skip tier_of */
+		*p += 1;  /* skip cache_mode */
+
+		pi->read_tier = ceph_decode_64(p);
+		pi->write_tier = ceph_decode_64(p);
+	} else {
+		pi->read_tier = -1;
+		pi->write_tier = -1;
+	}
 
 	/* ignore the rest */
 
-- 
1.7.10.4

