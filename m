From: Noah Watkins <noahwatkins@gmail.com>
Subject: [PATCH 1/2] ceph: fix parse options memory leak
Date: Mon, 12 Sep 2011 14:51:53 -0700
Message-ID: <CAB2gnbXKGD5fBykQdNhgTjS4GZDchzFGxXqRuuLEMqALLO4_7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f52.google.com ([209.85.212.52]:38381 "EHLO
	mail-vw0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754856Ab1ILVvz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Sep 2011 17:51:55 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

ceph_destroy_options does not free opt->mon_addr that
is allocated in ceph_parse_options.

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 net/ceph/ceph_common.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
index d4038ca..97f70e5 100644
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
1.7.6.1
