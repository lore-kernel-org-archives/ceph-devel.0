From: Sage Weil <sage@newdream.net>
Subject: [PATCH 10/11] crush: fix memory leak when destroying tree buckets
Date: Fri,  4 May 2012 15:54:07 -0700
Message-ID: <1336172048-6848-11-git-send-email-sage@newdream.net>
References: <1336172048-6848-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:37660 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760575Ab2EDWyX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 May 2012 18:54:23 -0400
In-Reply-To: <1336172048-6848-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Reflects ceph.git commit 46d63d98434b3bc9dad2fc9ab23cbaedc3bcb0e4.

Reported-by: Alexander Lyakas <alex.bolshoy@gmail.com>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/crush/crush.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/ceph/crush/crush.c b/net/ceph/crush/crush.c
index 568adac..c17e007 100644
--- a/net/ceph/crush/crush.c
+++ b/net/ceph/crush/crush.c
@@ -62,6 +62,8 @@ void crush_destroy_bucket_list(struct crush_bucket_list *b)
 
 void crush_destroy_bucket_tree(struct crush_bucket_tree *b)
 {
+	kfree(b->h.perm);
+	kfree(b->h.items);
 	kfree(b->node_weights);
 	kfree(b);
 }
-- 
1.7.9

