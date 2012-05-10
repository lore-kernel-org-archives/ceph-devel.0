From: "Jim Schutt" <jaschut@sandia.gov>
Subject: [RFC PATCH 1/2] ceph: retry CRUSH map descent before retrying
 bucket
Date: Thu, 10 May 2012 16:38:25 -0600
Message-ID: <1336689506-15029-2-git-send-email-jaschut@sandia.gov>
References: <1336689506-15029-1-git-send-email-jaschut@sandia.gov>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:33043 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761692Ab2EJWiy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 May 2012 18:38:54 -0400
In-Reply-To: <1336689506-15029-1-git-send-email-jaschut@sandia.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sage@newdream.net
Cc: sam.just@dreamhost.com, ceph-devel@vger.kernel.org, Jim Schutt <jaschut@sandia.gov>

For the first few rejections or collisions, we'll retry the descent to
keep objects spread across the cluster.  After that, we'll fall back
to exhaustive search of the bucket to avoid trying forever in the event
a bucket has only a few in items and the hash doesn't do a good job of
finding them.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 src/crush/mapper.c |   20 ++++++++++++++------
 1 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/src/crush/mapper.c b/src/crush/mapper.c
index 8857577..e5dc950 100644
--- a/src/crush/mapper.c
+++ b/src/crush/mapper.c
@@ -350,8 +350,7 @@ static int crush_choose(const struct crush_map *map,
 					reject = 1;
 					goto reject;
 				}
-				if (flocal >= (in->size>>1) &&
-				    flocal > orig_tries)
+				if (ftotal >= orig_tries)	 /* exhaustive bucket search */
 					item = bucket_perm_choose(in, x, r);
 				else
 					item = crush_bucket_choose(in, x, r);
@@ -420,10 +419,19 @@ reject:
 				if (reject || collide) {
 					ftotal++;
 					flocal++;
-
-					if (collide && flocal < 3)
-						/* retry locally a few times */
-						retry_bucket = 1;
+					/*
+					 * For the first couple rejections or collisions,
+					 * we'll retry the descent to keep objects spread
+					 * across the cluster.  After that, we'll fall back
+					 * to exhaustive search of buckets to avoid trying
+					 * forever in the event a bucket has only a few
+					 * "in" items and the hash doesn't do a good job
+					 * of finding them.  Note that we need to retry
+					 * descent during that phase so that multiple
+					 * buckets can be exhaustively searched.
+					 */
+					if (ftotal <= orig_tries)
+						retry_descent = 1;
 					else if (flocal <= in->size + orig_tries)
 						/* exhaustive bucket search */
 						retry_bucket = 1;
-- 
1.7.8.2


