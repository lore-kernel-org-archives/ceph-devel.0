From: Sam Lang <samlang@gmail.com>
Subject: [PATCH] ceph: Use pseudo-random numbers to choose mds
Date: Wed, 10 Apr 2013 10:05:38 -0500
Message-ID: <1365606338-12278-1-git-send-email-sam.lang@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:46351 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935753Ab3DJPGC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Apr 2013 11:06:02 -0400
Received: by mail-ie0-f173.google.com with SMTP id 10so559929ied.4
        for <ceph-devel@vger.kernel.org>; Wed, 10 Apr 2013 08:06:02 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sam Lang <sam.lang@inktank.com>

We don't need to use up entropy to choose an mds,
so use prandom_u32() to get a pseudo-random number.

Also, we don't need to choose a random mds if only
one mds is available, so add special casing for the
common case.

Fixes http://tracker.ceph.com/issues/3579

Signed-off-by: Sam Lang <sam.lang@inktank.com>
---
 fs/ceph/mdsmap.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index 0d3c924..9278dec 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -20,7 +20,10 @@ int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m)
 {
 	int n = 0;
 	int i;
-	char r;
+
+	/* special case for one mds */
+	if (1 == m->m_max_mds && m->m_info[0].state > 0)
+		return 0;
 
 	/* count */
 	for (i = 0; i < m->m_max_mds; i++)
@@ -30,8 +33,7 @@ int ceph_mdsmap_get_random_mds(struct ceph_mdsmap *m)
 		return -1;
 
 	/* pick */
-	get_random_bytes(&r, 1);
-	n = r % n;
+	n = prandom_u32() % n;
 	i = 0;
 	for (i = 0; n > 0; i++, n--)
 		while (m->m_info[i].state <= 0)
-- 
1.7.10.4

