From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/6] libceph: fallback for when there isn't a pool-specific choose_arg
Date: Fri, 28 Jul 2017 14:41:27 +0200
Message-ID: <1501245690-2362-4-git-send-email-idryomov@gmail.com>
References: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37469 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751740AbdG1Mlm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 28 Jul 2017 08:41:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id t138so8433372wmt.4
        for <ceph-devel@vger.kernel.org>; Fri, 28 Jul 2017 05:41:42 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c13sm8263773wrc.7.2017.07.28.05.41.40
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 05:41:40 -0700 (PDT)
In-Reply-To: <1501245690-2362-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There is now a fallback to a choose_arg index of -1 if there isn't
a pool-specific choose_arg set.  If you create a per-pool weight-set,
that works for that pool.  Otherwise we try the compat/default one.  If
that doesn't exist either, then we use the normal CRUSH weights.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 include/linux/crush/crush.h |  2 +-
 net/ceph/osdmap.c           | 12 +++++++++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 92e165d417a6..07eed95e10c7 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -193,7 +193,7 @@ struct crush_choose_arg {
 struct crush_choose_arg_map {
 #ifdef __KERNEL__
 	struct rb_node node;
-	u64 choose_args_index;
+	s64 choose_args_index;
 #endif
 	struct crush_choose_arg *args; /*!< replacement for each bucket
                                             in the crushmap */
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 64ae9f89773a..eb57a06373ca 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -2301,10 +2301,17 @@ static u32 raw_pg_to_pps(struct ceph_pg_pool_info *pi,
 	}
 }
 
+/*
+ * Magic value used for a "default" fallback choose_args, used if the
+ * crush_choose_arg_map passed to do_crush() does not exist.  If this
+ * also doesn't exist, fall back to canonical weights.
+ */
+#define CEPH_DEFAULT_CHOOSE_ARGS	-1
+
 static int do_crush(struct ceph_osdmap *map, int ruleno, int x,
 		    int *result, int result_max,
 		    const __u32 *weight, int weight_max,
-		    u64 choose_args_index)
+		    s64 choose_args_index)
 {
 	struct crush_choose_arg_map *arg_map;
 	int r;
@@ -2313,6 +2320,9 @@ static int do_crush(struct ceph_osdmap *map, int ruleno, int x,
 
 	arg_map = lookup_choose_arg_map(&map->crush->choose_args,
 					choose_args_index);
+	if (!arg_map)
+		arg_map = lookup_choose_arg_map(&map->crush->choose_args,
+						CEPH_DEFAULT_CHOOSE_ARGS);
 
 	mutex_lock(&map->crush_workspace_mutex);
 	r = crush_do_rule(map->crush, ruleno, x, result, result_max,
-- 
2.4.3

