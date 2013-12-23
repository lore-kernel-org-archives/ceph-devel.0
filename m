From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 04/19] crush: fix some comments
Date: Mon, 23 Dec 2013 19:09:35 +0200
Message-ID: <1387818590-30483-5-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:40588 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752635Ab3LWRKs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:10:48 -0500
Received: by mail-ea0-f174.google.com with SMTP id b10so2456566eae.19
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:10:47 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Reflects ceph.git commit 3cef755428761f2481b1dd0e0fbd0464ac483fc5.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 71192b1f8501..82cab7d3e89d 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -565,7 +565,7 @@ int crush_do_rule(const struct crush_map *map,
 				/* copy final _leaf_ values to output set */
 				memcpy(o, c, osize*sizeof(*o));
 
-			/* swap t and w arrays */
+			/* swap o and w arrays */
 			tmp = o;
 			o = w;
 			w = tmp;
-- 
1.7.10.4

