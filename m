From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: properly wake up cap waiter after releasing revoked caps
Date: Mon, 11 May 2020 16:25:12 +0800
Message-ID: <20200511082512.4375-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44780 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728556AbgEKIZW (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 11 May 2020 04:25:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

arg->wake can never be true. the bug was introduced by commit
0c4b255369bcf "ceph: reorganize __send_cap for less spinlock abuse"

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index b3e65c89ba6e..a2a2cda117e0 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1376,6 +1376,12 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 	ci->i_ceph_flags &= ~CEPH_I_FLUSH;
 
 	cap->issued &= retain;  /* drop bits we don't want */
+	/*
+	 * Wake up any waiters on wanted -> needed transition. This is due to
+	 * the weird transition from buffered to sync IO... we need to flush
+	 * dirty pages _before_ allowing sync writes to avoid reordering.
+	 */
+	arg->wake = cap->implemented & ~cap->issued;
 	cap->implemented &= cap->issued | used;
 	cap->mds_wanted = want;
 
@@ -1439,13 +1445,6 @@ static void __prep_cap(struct cap_msg_args *arg, struct ceph_cap *cap,
 		}
 	}
 	arg->flags = flags;
-
-	/*
-	 * Wake up any waiters on wanted -> needed transition. This is due to
-	 * the weird transition from buffered to sync IO... we need to flush
-	 * dirty pages _before_ allowing sync writes to avoid reordering.
-	 */
-	arg->wake = cap->implemented & ~cap->issued;
 }
 
 /*
-- 
2.21.3
