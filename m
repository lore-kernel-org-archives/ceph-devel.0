From: Wido den Hollander <wido@42on.com>
Subject: [PATCH] config: Add small note about default number of PGs
Date: Sat,  9 Feb 2013 20:55:48 +0100
Message-ID: <1360439748-4363-1-git-send-email-wido@42on.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from hosted.by.pcextreme ([79.99.132.139]:34014 "EHLO
	wido-desktop.widodh.nl" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S932485Ab3BIUCD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Feb 2013 15:02:03 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Wido den Hollander <wido@widodh.nl>, Wido den Hollander <wido@42on.com>

From: Wido den Hollander <wido@widodh.nl>

It's still not clear to end users this should go into the
mon or global section of ceph.conf

Until this gets resolved document it here as well for the people
who look up their settings in the source code.

Signed-off-by: Wido den Hollander <wido@42on.com>
---
 src/common/config_opts.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/common/config_opts.h b/src/common/config_opts.h
index ce3bca2..0fc07a3 100644
--- a/src/common/config_opts.h
+++ b/src/common/config_opts.h
@@ -317,8 +317,8 @@ OPTION(osd_max_rep, OPT_INT, 10)
 OPTION(osd_pool_default_crush_rule, OPT_INT, 0)
 OPTION(osd_pool_default_size, OPT_INT, 2)
 OPTION(osd_pool_default_min_size, OPT_INT, 0)  // 0 means no specific default; ceph will use size-size/2
-OPTION(osd_pool_default_pg_num, OPT_INT, 8)
-OPTION(osd_pool_default_pgp_num, OPT_INT, 8)
+OPTION(osd_pool_default_pg_num, OPT_INT, 8) // number of PGs for new pools. Configure in global or mon section of ceph.conf
+OPTION(osd_pool_default_pgp_num, OPT_INT, 8) // number of PGs for placement purposes. Should be equal to pg_num
 OPTION(osd_map_dedup, OPT_BOOL, true)
 OPTION(osd_map_cache_size, OPT_INT, 500)
 OPTION(osd_map_message_max, OPT_INT, 100)  // max maps per MOSDMap message
-- 
1.7.9.5

