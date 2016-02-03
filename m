From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/5] crush: ensure bucket id is valid before indexing buckets array
Date: Wed,  3 Feb 2016 15:23:17 +0100
Message-ID: <1454509401-19734-2-git-send-email-idryomov@gmail.com>
References: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37255 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751952AbcBCOXa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 09:23:30 -0500
Received: by mail-wm0-f54.google.com with SMTP id l66so72740398wml.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 06:23:29 -0800 (PST)
In-Reply-To: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

We were indexing the buckets array without verifying the index was
within the [0,max_buckets) range.  This could happen because
a multistep rule does not have enough buckets and has CRUSH_ITEM_NONE
for an intermediate result, which would feed in CRUSH_ITEM_NONE and
make us crash.

Reflects ceph.git commit 976a24a326da8931e689ee22fce35feab5b67b76.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/crush/mapper.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 393bfb22d5bb..97ecf6f262aa 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -888,6 +888,7 @@ int crush_do_rule(const struct crush_map *map,
 			osize = 0;
 
 			for (i = 0; i < wsize; i++) {
+				int bno;
 				/*
 				 * see CRUSH_N, CRUSH_N_MINUS macros.
 				 * basically, numrep <= 0 means relative to
@@ -900,6 +901,13 @@ int crush_do_rule(const struct crush_map *map,
 						continue;
 				}
 				j = 0;
+				/* make sure bucket id is valid */
+				bno = -1 - w[i];
+				if (bno < 0 || bno >= map->max_buckets) {
+					/* w[i] is probably CRUSH_ITEM_NONE */
+					dprintk("  bad w[i] %d\n", w[i]);
+					continue;
+				}
 				if (firstn) {
 					int recurse_tries;
 					if (choose_leaf_tries)
@@ -911,7 +919,7 @@ int crush_do_rule(const struct crush_map *map,
 						recurse_tries = choose_tries;
 					osize += crush_choose_firstn(
 						map,
-						map->buckets[-1-w[i]],
+						map->buckets[bno],
 						weight, weight_max,
 						x, numrep,
 						curstep->arg2,
@@ -930,7 +938,7 @@ int crush_do_rule(const struct crush_map *map,
 						    numrep : (result_max-osize));
 					crush_choose_indep(
 						map,
-						map->buckets[-1-w[i]],
+						map->buckets[bno],
 						weight, weight_max,
 						x, out_size, numrep,
 						curstep->arg2,
-- 
2.4.3

