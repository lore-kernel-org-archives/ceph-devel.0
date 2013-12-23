From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 03/19] crush: reduce scope of some local variables
Date: Mon, 23 Dec 2013 19:09:34 +0200
Message-ID: <1387818590-30483-4-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:42745 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3LWRKr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:47 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so2446940eak.2
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:46 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Reflects ceph.git commit e7d47827f0333c96ad43d257607fb92ed4176550.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 18d2cf66f102..71192b1f8501 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -189,7 +189,7 @@ static int terminal(int x)
 static int bucket_tree_choose(struct crush_bucket_tree *bucket,
 			      int x, int r)
 {
-	int n, l;
+	int n;
 	__u32 w;
 	__u64 t;
 
@@ -197,6 +197,7 @@ static int bucket_tree_choose(struct crush_bucket_tree *bucket,
 	n = bucket->num_nodes >> 1;
 
 	while (!terminal(n)) {
+		int l;
 		/* pick point in [0, w) */
 		w = bucket->node_weights[n];
 		t = (__u64)crush_hash32_4(bucket->h.hash, x, n, r,
@@ -496,7 +497,6 @@ int crush_do_rule(const struct crush_map *map,
 	__u32 step;
 	int i, j;
 	int numrep;
-	int firstn;
 	const int descend_once = 0;
 
 	if ((__u32)ruleno >= map->max_rules) {
@@ -510,9 +510,9 @@ int crush_do_rule(const struct crush_map *map,
 	o = b;
 
 	for (step = 0; step < rule->len; step++) {
+		int firstn = 0;
 		struct crush_rule_step *curstep = &rule->steps[step];
 
-		firstn = 0;
 		switch (curstep->op) {
 		case CRUSH_RULE_TAKE:
 			w[0] = curstep->arg1;
-- 
1.7.10.4

