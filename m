From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6/6] libceph: make RECOVERY_DELETES feature create a new interval
Date: Fri, 28 Jul 2017 14:41:30 +0200
Message-ID: <1501245690-2362-7-git-send-email-idryomov@gmail.com>
References: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34448 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751949AbdG1Mlo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 08:41:44 -0400
Received: by mail-wr0-f196.google.com with SMTP id o33so18991762wrb.1
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 05:41:44 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c13sm8263773wrc.7.2017.07.28.05.41.42
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 05:41:43 -0700 (PDT)
In-Reply-To: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is needed so that the OSDs can regenerate the missing set at the
start of a new interval where support for recovery deletes changed.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/ceph/osd_client.h | 1 +
 include/linux/ceph/osdmap.h     | 2 ++
 include/linux/ceph/rados.h      | 4 ++++
 net/ceph/osd_client.c           | 5 +++++
 net/ceph/osdmap.c               | 5 ++++-
 5 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
index c6d96a5f46fd..adf670ecaf94 100644
--- a/include/linux/ceph/osd_client.h
+++ b/include/linux/ceph/osd_client.h
@@ -148,6 +148,7 @@ struct ceph_osd_request_target {
 	int size;
 	int min_size;
 	bool sort_bitwise;
+	bool recovery_deletes;
 
 	unsigned int flags;                /* CEPH_OSD_FLAG_* */
 	bool paused;
diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index a0996cb9faed..af3444a5bfdd 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -272,6 +272,8 @@ bool ceph_is_new_interval(const struct ceph_osds *old_acting,
 			  u32 new_pg_num,
 			  bool old_sort_bitwise,
 			  bool new_sort_bitwise,
+			  bool old_recovery_deletes,
+			  bool new_recovery_deletes,
 			  const struct ceph_pg *pgid);
 bool ceph_osds_changed(const struct ceph_osds *old_acting,
 		       const struct ceph_osds *new_acting,
diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
index 385db08bb8b2..b8281feda9c7 100644
--- a/include/linux/ceph/rados.h
+++ b/include/linux/ceph/rados.h
@@ -158,6 +158,10 @@ extern const char *ceph_osd_state_name(int s);
 #define CEPH_OSDMAP_NOTIERAGENT (1<<13) /* disable tiering agent */
 #define CEPH_OSDMAP_NOREBALANCE (1<<14) /* block osd backfill unless pg is degraded */
 #define CEPH_OSDMAP_SORTBITWISE (1<<15) /* use bitwise hobject_t sort */
+#define CEPH_OSDMAP_REQUIRE_JEWEL    (1<<16) /* require jewel for booting osds */
+#define CEPH_OSDMAP_REQUIRE_KRAKEN   (1<<17) /* require kraken for booting osds */
+#define CEPH_OSDMAP_REQUIRE_LUMINOUS (1<<18) /* require l for booting osds */
+#define CEPH_OSDMAP_RECOVERY_DELETES (1<<19) /* deletes performed during recovery instead of peering */
 
 /*
  * The error code to return when an OSD can't handle a write
diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index b5f016cb9569..dcfbdd74dfd1 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1337,6 +1337,8 @@ static enum calc_target_result calc_target(struct ceph_osd_client *osdc,
 	bool legacy_change;
 	bool split = false;
 	bool sort_bitwise = ceph_osdmap_flag(osdc, CEPH_OSDMAP_SORTBITWISE);
+	bool recovery_deletes = ceph_osdmap_flag(osdc,
+						 CEPH_OSDMAP_RECOVERY_DELETES);
 	enum calc_target_result ct_res;
 	int ret;
 
@@ -1399,6 +1401,8 @@ static enum calc_target_result calc_target(struct ceph_osd_client *osdc,
 				 pi->pg_num,
 				 t->sort_bitwise,
 				 sort_bitwise,
+				 t->recovery_deletes,
+				 recovery_deletes,
 				 &last_pgid))
 		force_resend = true;
 
@@ -1421,6 +1425,7 @@ static enum calc_target_result calc_target(struct ceph_osd_client *osdc,
 		t->pg_num = pi->pg_num;
 		t->pg_num_mask = pi->pg_num_mask;
 		t->sort_bitwise = sort_bitwise;
+		t->recovery_deletes = recovery_deletes;
 
 		t->osd = acting.primary;
 	}
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 0bec71fa712e..f358d0bfa76b 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2082,6 +2082,8 @@ bool ceph_is_new_interval(const struct ceph_osds *old_acting,
 			  u32 new_pg_num,
 			  bool old_sort_bitwise,
 			  bool new_sort_bitwise,
+			  bool old_recovery_deletes,
+			  bool new_recovery_deletes,
 			  const struct ceph_pg *pgid)
 {
 	return !osds_equal(old_acting, new_acting) ||
@@ -2089,7 +2091,8 @@ bool ceph_is_new_interval(const struct ceph_osds *old_acting,
 	       old_size != new_size ||
 	       old_min_size != new_min_size ||
 	       ceph_pg_is_split(pgid, old_pg_num, new_pg_num) ||
-	       old_sort_bitwise != new_sort_bitwise;
+	       old_sort_bitwise != new_sort_bitwise ||
+	       old_recovery_deletes != new_recovery_deletes;
 }
 
 static int calc_pg_rank(int osd, const struct ceph_osds *acting)
-- 
2.4.3

