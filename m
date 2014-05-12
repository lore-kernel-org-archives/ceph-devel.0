From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] crush: decode and initialize chooseleaf_vary_r
Date: Mon, 12 May 2014 16:17:39 +0400
Message-ID: <1399897059-4813-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:46934 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754597AbaELMRn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 May 2014 08:17:43 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so7428656lbd.12
        for <ceph-devel@vger.kernel.org>; Mon, 12 May 2014 05:17:42 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Dmitry Smirnov <onlyjob@member.fsf.org>

Commit e2b149cc4ba0 ("crush: add chooseleaf_vary_r tunable") added the
crush_map::chooseleaf_vary_r field but missed the decode part.  This
lead to misdirected requests caused by incorrect raw crush mapping
sets.

Fixes: http://tracker.ceph.com/issues/8226

Reported-and-Tested-by: Dmitry Smirnov <onlyjob@member.fsf.org>
Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osdmap.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 8b8a5a24b223..c547e46084d3 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -329,6 +329,11 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 	dout("crush decode tunable chooseleaf_descend_once = %d",
 	     c->chooseleaf_descend_once);
 
+	ceph_decode_need(p, end, sizeof(u8), done);
+	c->chooseleaf_vary_r = ceph_decode_8(p);
+	dout("crush decode tunable chooseleaf_vary_r = %d",
+	     c->chooseleaf_vary_r);
+
 done:
 	dout("crush_decode success\n");
 	return c;
-- 
1.7.10.4

