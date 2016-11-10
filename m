From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 1/5] ceph: fix minor typo in unsafe_request_wait
Date: Thu, 10 Nov 2016 07:52:10 -0500
Message-ID: <1478782334-20667-2-git-send-email-jlayton@redhat.com>
References: <1478782334-20667-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932225AbcKJMwR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 10 Nov 2016 07:52:17 -0500
In-Reply-To: <1478782334-20667-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com
Cc: ceph-devel@vger.kernel.org

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 16e6ded0b7f2..d37a04b87d2c 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1996,7 +1996,7 @@ static int unsafe_request_wait(struct inode *inode)
 	}
 	spin_unlock(&ci->i_unsafe_lock);
 
-	dout("unsafe_requeset_wait %p wait on tid %llu %llu\n",
+	dout("unsafe_request_wait %p wait on tid %llu %llu\n",
 	     inode, req1 ? req1->r_tid : 0ULL, req2 ? req2->r_tid : 0ULL);
 	if (req1) {
 		ret = !wait_for_completion_timeout(&req1->r_safe_completion,
-- 
2.7.4

