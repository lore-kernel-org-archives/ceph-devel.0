From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] libceph: using kfree_rcu() to simplify the code
Date: Sat, 30 Jul 2016 00:38:26 +0000
Message-ID: <1469839106-3692-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35104 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbcG3Aic (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 20:38:32 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so5922283pad.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 17:38:32 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, ceph-devel@vger.kernel.org

The callback function of call_rcu() just calls a kfree(), so we
can use kfree_rcu() instead of call_rcu() + callback function.

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 net/ceph/string_table.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ceph/string_table.c b/net/ceph/string_table.c
index ca53c83..22fb96e 100644
--- a/net/ceph/string_table.c
+++ b/net/ceph/string_table.c
@@ -84,12 +84,6 @@ retry:
 }
 EXPORT_SYMBOL(ceph_find_or_create_string);
 
-static void ceph_free_string(struct rcu_head *head)
-{
-	struct ceph_string *cs = container_of(head, struct ceph_string, rcu);
-	kfree(cs);
-}
-
 void ceph_release_string(struct kref *ref)
 {
 	struct ceph_string *cs = container_of(ref, struct ceph_string, kref);
@@ -101,7 +95,7 @@ void ceph_release_string(struct kref *ref)
 	}
 	spin_unlock(&string_tree_lock);
 
-	call_rcu(&cs->rcu, ceph_free_string);
+	kfree_rcu(cs, rcu);
 }
 EXPORT_SYMBOL(ceph_release_string);

