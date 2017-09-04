From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 02/13] ceph: fix message order check in handle_cap_export()
Date: Mon,  4 Sep 2017 17:38:57 +0800
Message-ID: <20170904093908.57316-3-zyan@redhat.com>
References: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41482 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753390AbdIDJje (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:39:34 -0400
In-Reply-To: <20170904093908.57316-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

If caps for importer mds exists, but cap id mismatch, client should
have received corresponding import message. Because cap ID does not
change as long as client holds the caps.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 5daf86621871..7a7945032802 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3427,7 +3427,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 	tcap = __get_cap_for_mds(ci, target);
 	if (tcap) {
 		/* already have caps from the target */
-		if (tcap->cap_id != t_cap_id ||
+		if (tcap->cap_id == t_cap_id &&
 		    ceph_seq_cmp(tcap->seq, t_seq) < 0) {
 			dout(" updating import cap %p mds%d\n", tcap, target);
 			tcap->cap_id = t_cap_id;
-- 
2.13.5

