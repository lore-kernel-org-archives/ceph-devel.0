From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 08/19] crush: add note about r in recursive choose
Date: Mon, 23 Dec 2013 19:09:39 +0200
Message-ID: <1387818590-30483-9-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f171.google.com ([209.85.215.171]:40323 "EHLO
	mail-ea0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3LWRK4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:56 -0500
Received: by mail-ea0-f171.google.com with SMTP id h10so2493119eak.30
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:55 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Reflects ceph.git commit 4551fee9ad89d0427ed865d766d0d44004d3e3e1.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index caeb1066bea3..77b7a73e65cf 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -514,6 +514,14 @@ static void crush_choose_indep(const struct crush_map *map,
 
 			/* choose through intervening buckets */
 			for (;;) {
+				/* note: we base the choice on the position
+				 * even in the nested call.  that means that
+				 * if the first layer chooses the same bucket
+				 * in a different position, we will tend to
+				 * choose a different item in that bucket.
+				 * this will involve more devices in data
+				 * movement and tend to distribute the load.
+				 */
 				r = rep;
 
 				/* be careful */
-- 
1.7.10.4

