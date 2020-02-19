From: Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v5 06/12] ceph: don't take refs to want mask unless we have all bits
Date: Wed, 19 Feb 2020 08:25:20 -0500
Message-ID: <20200219132526.17590-7-jlayton@kernel.org>
References: <20200219132526.17590-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726725AbgBSNZd (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 08:25:33 -0500
In-Reply-To: <20200219132526.17590-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, xiubli@redhat.com

From: "Yan, Zheng" <ukernel@gmail.com>

If we don't have all of the cap bits for the want mask in
try_get_cap_refs, then just take refs on the need bits.

Signed-off-by: "Yan, Zheng" <ukernel@gmail.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/caps.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

Zheng,

I broke this patch out on its own as I wasn't sure it was still
needed with the latest iteration of the code. We can fold it into
the previous one if we do want it, or just drop it.

Thanks,
Jeff

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d6c5ee33f30f..c96b18407aef 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2667,7 +2667,10 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 				}
 				snap_rwsem_locked = true;
 			}
-			*got = need | (have & want);
+			if ((have & want) == want)
+				*got = need | want;
+			else
+				*got = need;
 			if (S_ISREG(inode->i_mode) &&
 			    (need & CEPH_CAP_FILE_RD) &&
 			    !(*got & CEPH_CAP_FILE_CACHE))
-- 
2.24.1
