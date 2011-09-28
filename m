From: Sage Weil <sage@newdream.net>
Subject: [PATCH 2/5] libceph: fix parse options memory leak
Date: Wed, 28 Sep 2011 10:26:28 -0700
Message-ID: <1317230791-6642-3-git-send-email-sage@newdream.net>
References: <1317230791-6642-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46490 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218Ab1I1R0i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 13:26:38 -0400
In-Reply-To: <1317230791-6642-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Noah Watkins <noahwatkins@gmail.com>, Sage Weil <sage@newdream.net>

From: Noah Watkins <noahwatkins@gmail.com>

ceph_destroy_options does not free opt->mon_addr that
is allocated in ceph_parse_options.

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/ceph_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index 132963a..2883ea0 100644
--- a/net/ceph/ceph_common.c
+++ b/net/ceph/ceph_common.c
@@ -232,6 +232,7 @@ void ceph_destroy_options(struct ceph_options *opt)
 		ceph_crypto_key_destroy(opt->key);
 		kfree(opt->key);
 	}
+	kfree(opt->mon_addr);
 	kfree(opt);
 }
 EXPORT_SYMBOL(ceph_destroy_options);
-- 
1.7.0

