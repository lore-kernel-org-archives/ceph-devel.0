Return-Path: <ceph-devel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46E1C43334
	for <ceph-devel@archiver.kernel.org>; Tue, 14 Jun 2022 07:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353370AbiFNHMJ (ORCPT <rfc822;ceph-devel@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352657AbiFNHMI (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Jun 2022 03:12:08 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7AC983B54C;
        Tue, 14 Jun 2022 00:12:07 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 71A761E80D5E;
        Tue, 14 Jun 2022 15:10:47 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ro-17gUlV4U2; Tue, 14 Jun 2022 15:10:44 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: liqiong@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 30F761E80D0E;
        Tue, 14 Jun 2022 15:10:44 +0800 (CST)
From:   Li Qiong <liqiong@nfschina.com>
To:     Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuzhe@nfschina.com, renyu@nfschina.com,
        Li Qiong <liqiong@nfschina.com>
Subject: [PATCH] libceph: check pointer before assigned to "c->rules[]"
Date:   Tue, 14 Jun 2022 15:10:59 +0800
Message-Id: <20220614071059.23696-1-liqiong@nfschina.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <ceph-devel.vger.kernel.org>
X-Mailing-List: ceph-devel@vger.kernel.org

It should be better to check pointer firstly, then assign it
to c->rules[]. Refine code a little bit.

Signed-off-by: Li Qiong <liqiong@nfschina.com>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 2823bb3cff55..6ec5007f96dc 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -571,9 +571,9 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 			goto bad;
 #endif
 		r = kmalloc(struct_size(r, steps, yes), GFP_NOFS);
-		c->rules[i] = r;
 		if (r == NULL)
 			goto badmem;
+		c->rules[i] = r;
 		dout(" rule %d is at %p\n", i, r);
 		r->len = yes;
 		ceph_decode_copy_safe(p, end, &r->mask, 4, bad); /* 4 u8's */
-- 
2.11.0

