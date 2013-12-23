From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 02/19] crush: factor out (trivial) crush_destroy_rule()
Date: Mon, 23 Dec 2013 19:09:33 +0200
Message-ID: <1387818590-30483-3-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f179.google.com ([209.85.215.179]:46513 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3LWRKo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:44 -0500
Received: by mail-ea0-f179.google.com with SMTP id r15so2490941ead.10
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:43 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Reflects ceph.git commit 43a01c9973c4b83f2eaa98be87429941a227ddde.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/crush.h |    1 +
 net/ceph/crush/crush.c      |    7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 6a1101f24cfb..09561a04c127 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -174,6 +174,7 @@ extern void crush_destroy_bucket_list(struct crush_bucket_list *b);
 extern void crush_destroy_bucket_tree(struct crush_bucket_tree *b);
 extern void crush_destroy_bucket_straw(struct crush_bucket_straw *b);
 extern void crush_destroy_bucket(struct crush_bucket *b);
+extern void crush_destroy_rule(struct crush_rule *r);
 extern void crush_destroy(struct crush_map *map);
 
 static inline int crush_calc_tree_node(int i)
diff --git a/net/ceph/crush/crush.c b/net/ceph/crush/crush.c
index 089613234f03..16bc199d9a62 100644
--- a/net/ceph/crush/crush.c
+++ b/net/ceph/crush/crush.c
@@ -116,11 +116,14 @@ void crush_destroy(struct crush_map *map)
 	if (map->rules) {
 		__u32 b;
 		for (b = 0; b < map->max_rules; b++)
-			kfree(map->rules[b]);
+			crush_destroy_rule(map->rules[b]);
 		kfree(map->rules);
 	}
 
 	kfree(map);
 }
 
-
+void crush_destroy_rule(struct crush_rule *rule)
+{
+	kfree(rule);
+}
-- 
1.7.10.4

