From: Sage Weil <sage@inktank.com>
Subject: [PATCH 2/2] libceph: remove unused monc->have_fsid
Date: Fri, 17 Aug 2012 09:50:04 -0700
Message-ID: <1345222204-9583-2-git-send-email-sage@inktank.com>
References: <1345222204-9583-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47000 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758450Ab2HQQiS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Aug 2012 12:38:18 -0400
In-Reply-To: <1345222204-9583-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zheng.z.yan@intel.com, Sage Weil <sage@inktank.com>

This is unused; use monc->client->have_fsid.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 include/linux/ceph/mon_client.h |    1 -
 net/ceph/mon_client.c           |    1 -
 2 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/linux/ceph/mon_client.h b/include/linux/ceph/mon_client.h
index 2113e38..1dc508a 100644
--- a/include/linux/ceph/mon_client.h
+++ b/include/linux/ceph/mon_client.h
@@ -71,7 +71,6 @@ struct ceph_mon_client {
 	int cur_mon;                       /* last monitor i contacted */
 	unsigned long sub_sent, sub_renew_after;
 	struct ceph_connection con;
-	bool have_fsid;
 
 	/* pending generic requests */
 	struct rb_root generic_request_tree;
diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index b9f412d..5072ccc 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -768,7 +768,6 @@ static int build_initial_monmap(struct ceph_mon_client *monc)
 		monc->monmap->mon_inst[i].name.num = cpu_to_le64(i);
 	}
 	monc->monmap->num_mon = num_mon;
-	monc->have_fsid = false;
 	return 0;
 }
 
-- 
1.7.9

