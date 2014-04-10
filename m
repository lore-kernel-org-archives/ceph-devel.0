From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: fix non-default values check in apply_primary_affinity()
Date: Thu, 10 Apr 2014 18:13:05 +0400
Message-ID: <1397139185-5492-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f47.google.com ([74.125.83.47]:35746 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934712AbaDJONJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Apr 2014 10:13:09 -0400
Received: by mail-ee0-f47.google.com with SMTP id b15so3072338eek.20
        for <ceph-devel@vger.kernel.org>; Thu, 10 Apr 2014 07:13:08 -0700 (PDT)
Received: from localhost ([109.110.67.38])
        by mx.google.com with ESMTPSA id x45sm10236779eef.15.2014.04.10.07.13.07
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 10 Apr 2014 07:13:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

osd_primary_affinity array is indexed into incorrectly when checking
for non-default primary-affinity values.  This nullifies the impact of
the rest of the apply_primary_affinity() and results in misdirected
requests.

                if (osds[i] != CRUSH_ITEM_NONE &&
                    osdmap->osd_primary_affinity[i] !=
                                                ^^^
                                        CEPH_OSD_DEFAULT_PRIMARY_AFFINITY) {

For a pool with size 2, this always ends up checking osd0 and osd1
primary_affinity values, instead of the values that correspond to the
osds in question.  E.g., given a [2,3] up set and a [max,max,0,max]
primary affinity vector, requests are still sent to osd2, because both
osd0 and osd1 happen to have max primary_affinity values and therefore
we return from apply_primary_affinity() early on the premise that all
osds in the given set have max (default) values.  Fix it.

Fixes: http://tracker.ceph.com/issues/7954

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index e632b5a52f5b..8b8a5a24b223 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -1548,8 +1548,10 @@ static void apply_primary_affinity(struct ceph_osdmap *osdmap, u32 pps,
 		return;
 
 	for (i = 0; i < len; i++) {
-		if (osds[i] != CRUSH_ITEM_NONE &&
-		    osdmap->osd_primary_affinity[i] !=
+		int osd = osds[i];
+
+		if (osd != CRUSH_ITEM_NONE &&
+		    osdmap->osd_primary_affinity[osd] !=
 					CEPH_OSD_DEFAULT_PRIMARY_AFFINITY) {
 			break;
 		}
@@ -1563,10 +1565,9 @@ static void apply_primary_affinity(struct ceph_osdmap *osdmap, u32 pps,
 	 * osd's pgs get rejected as primary.
 	 */
 	for (i = 0; i < len; i++) {
-		int osd;
+		int osd = osds[i];
 		u32 aff;
 
-		osd = osds[i];
 		if (osd == CRUSH_ITEM_NONE)
 			continue;
 
-- 
1.7.10.4

