From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: avoid crashes from faulty crushmap
Date: Fri, 03 Feb 2012 07:30:29 -0200
Message-ID: <orpqdwnu16.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:59317 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755437Ab2BCJaf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2012 04:30:35 -0500
Received: from freie (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q139UV2j026919
	for <ceph-devel@vger.kernel.org>; Fri, 3 Feb 2012 07:30:32 -0200
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie (8.14.5/8.14.5) with ESMTP id q139UU2b011012
	for <ceph-devel@vger.kernel.org>; Fri, 3 Feb 2012 07:30:30 -0200
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=

I messed up a crush map the other day, mixing components of different
types in a single rule.  The crushmap compiler didn't complain, but mons
and osds would crash when applying those rules.  I had to use this patch
to recover the cluster.  Only the second hunk was relevant, but I
figured a BUG_ON that stops you from fixing the problem is best avoided
;-)


--=-=-=
Content-Type: message/rfc822
Content-Disposition: inline;
 filename=0002-crush-don-t-BUG_ON-within-crush_choose.patch

From: Alexandre Oliva <lxoliva@fsfla.org>
Date: Sun, 29 Jan 2012 05:15:18 -0200
Subject: [PATCH 2/2] [crush] don't BUG_ON within crush_choose

It's very hard to recover from an invalid crushmap if mons fail
assertions while processing the map, and osds crash while advancing
past an already-fixed map.  Skip such broken rules instead of
aborting.

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/crush/mapper.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/crush/mapper.c b/src/crush/mapper.c
index 1e475b40..6ce4c97 100644
--- a/src/crush/mapper.c
+++ b/src/crush/mapper.c
@@ -354,7 +354,11 @@ static int crush_choose(const struct crush_map *map,
 					item = bucket_perm_choose(in, x, r);
 				else
 					item = crush_bucket_choose(in, x, r);
-				BUG_ON(item >= map->max_devices);
+				if (item >= map->max_devices) {
+					dprintk("  bad item %d\n", item);
+					skip_rep = 1;
+					break;
+				}
 
 				/* desired type? */
 				if (item < 0)
@@ -365,8 +369,12 @@ static int crush_choose(const struct crush_map *map,
 
 				/* keep going? */
 				if (itemtype != type) {
-					BUG_ON(item >= 0 ||
-					       (-1-item) >= map->max_buckets);
+					if (item >= 0 ||
+					    (-1-item) >= map->max_buckets) {
+						dprintk("  bad item type %d\n", type)
+						skip_rep = 1;
+						break;
+					}
 					in = map->buckets[-1-item];
 					retry_bucket = 1;
 					continue;
-- 
1.7.7.6


--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
