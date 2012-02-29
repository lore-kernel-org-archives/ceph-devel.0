From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH] libceph: fix overflow check in crush_decode()
Date: Tue, 28 Feb 2012 20:56:09 -0800
Message-ID: <4F4DAFE9.7080104@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:59924 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756186Ab2B2E4K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:56:10 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 5B4C724318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:56:10 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 48AC624314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:56:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The existing overflow check (n > ULONG_MAX / b) didn't work, because
n = ULONG_MAX / b would both bypass the check and still overflow the
allocation size a + n * b.

The correct check should be (n > (ULONG_MAX - a) / b).

Signed-off-by: Xi Wang <xi.wang@gmail.com>
Signed-off-by: Sage Weil <sage@newdream.net>
---
  net/ceph/osdmap.c |    3 ++-
  1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index fd863fe..29ad46e 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -283,7 +283,8 @@ static struct crush_map *crush_decode(void *pbyval, 
void *end)
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

