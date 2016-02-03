From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 2/5] crush: ensure take bucket value is valid
Date: Wed,  3 Feb 2016 15:23:18 +0100
Message-ID: <1454509401-19734-3-git-send-email-idryomov@gmail.com>
References: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37276 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752920AbcBCOXb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 09:23:31 -0500
Received: by mail-wm0-f44.google.com with SMTP id l66so72741058wml.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 06:23:30 -0800 (PST)
In-Reply-To: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

Ensure that the take argument is a valid bucket ID before indexing the
buckets array.

Reflects ceph.git commit 93ec538e8a667699876b72459b8ad78966d89c61.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/crush/mapper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 97ecf6f262aa..abb700621e4a 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -835,7 +835,8 @@ int crush_do_rule(const struct crush_map *map,
 		case CRUSH_RULE_TAKE:
 			if ((curstep->arg1 >= 0 &&
 			     curstep->arg1 < map->max_devices) ||
-			    (-1-curstep->arg1 < map->max_buckets &&
+			    (-1-curstep->arg1 >= 0 &&
+			     -1-curstep->arg1 < map->max_buckets &&
 			     map->buckets[-1-curstep->arg1])) {
 				w[0] = curstep->arg1;
 				wsize = 1;
-- 
2.4.3

