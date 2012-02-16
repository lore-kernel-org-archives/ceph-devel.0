From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH] libceph: fix overflow check in crush_decode()
Date: Thu, 16 Feb 2012 11:55:48 -0500
Message-ID: <1329411348-13456-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:41800 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab2BPQ63 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2012 11:58:29 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

The existing overflow check (n > ULONG_MAX / b) didn't work, because
n = ULONG_MAX / b would both bypass the check and still overflow the
allocation size a + n * b.

The correct check should be (n > (ULONG_MAX - a) / b).

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 net/ceph/osdmap.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index fd863fe..29ad46e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -283,7 +283,8 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		ceph_decode_32_safe(p, end, yes, bad);
 #if BITS_PER_LONG == 32
 		err = -EINVAL;
-		if (yes > ULONG_MAX / sizeof(struct crush_rule_step))
+		if (yes > (ULONG_MAX - sizeof(*r))
+			  / sizeof(struct crush_rule_step))
 			goto bad;
 #endif
 		r = c->rules[i] = kmalloc(sizeof(*r) +
-- 
1.7.5.4

