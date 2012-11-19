From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 3/6] ceph: Fix infinite loop in __wake_requests
Date: Mon, 19 Nov 2012 10:49:06 +0800
Message-ID: <1353293349-15494-4-git-send-email-zheng.z.yan@intel.com>
References: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10829 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786Ab2KSCtQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 18 Nov 2012 21:49:16 -0500
In-Reply-To: <1353293349-15494-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

__wake_requests() will enter infinite loop if we use it to wake
requests in the session->s_waiting list. __wake_requests() deletes
requests from the list and __do_request() adds requests back to
the list.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/mds_client.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 1bcf712..0d9864f 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1876,9 +1876,14 @@ finish:
 static void __wake_requests(struct ceph_mds_client *mdsc,
 			    struct list_head *head)
 {
-	struct ceph_mds_request *req, *nreq;
+	struct ceph_mds_request *req;
+	LIST_HEAD(tmp_list);
+
+	list_splice_init(head, &tmp_list);
 
-	list_for_each_entry_safe(req, nreq, head, r_wait) {
+	while (!list_empty(&tmp_list)) {
+		req = list_entry(tmp_list.next,
+				 struct ceph_mds_request, r_wait);
 		list_del_init(&req->r_wait);
 		__do_request(mdsc, req);
 	}
-- 
1.7.11.7

