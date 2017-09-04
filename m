From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 01/13] ceph: fix null pointer dereference in ceph_flush_snaps()
Date: Mon,  4 Sep 2017 17:38:56 +0800
Message-ID: <20170904093908.57316-2-zyan@redhat.com>
References: <20170904093908.57316-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41328 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753364AbdIDJj1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 4 Sep 2017 05:39:27 -0400
In-Reply-To: <20170904093908.57316-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, jlayton@redhat.com, idryomov@gmail.com
Cc: "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 662ada467c32..5daf86621871 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1469,7 +1469,7 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 
 	if (psession) {
 		*psession = session;
-	} else {
+	} else if (session) {
 		mutex_unlock(&session->s_mutex);
 		ceph_put_mds_session(session);
 	}
-- 
2.13.5

