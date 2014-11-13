From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] ceph: fix flush tid comparision
Date: Fri, 14 Nov 2014 00:22:06 +0400
Message-ID: <CALFYKtDe0CVJh9kvpAAD7Vr4m8GQbrNy0b08s_swBy3cFWCa7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176]:46659 "EHLO
	mail-qc0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934061AbaKMUWG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Nov 2014 15:22:06 -0500
Received: by mail-qc0-f176.google.com with SMTP id x3so11832396qcv.35
        for <ceph-devel@vger.kernel.org>; Thu, 13 Nov 2014 12:22:06 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This patch wasn't posted on ceph-devel, posting..

From 2f0351fb79e046eddcfe5f4ac7c293dfc78545e2 Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zyan@redhat.com>
Date: Wed, 22 Oct 2014 17:13:26 -0700
Subject: [PATCH] ceph: fix flush tid comparision

TID of cap flush ack is 64 bits, but ceph_inode_info::flushing_cap_tid
is only 16 bits. 16 bits should be plenty to let the cap flush updates
pipeline appropriately, but we need to cast in the proper direction when
comparing these differently-sized versions. So downcast the 64-bits one
to 16 bits.

Signed-off-by: Yan, Zheng <zyan@redhat.com>
---
 fs/ceph/caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 659f2ea9e6f7..cefca661464b 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2638,7 +2638,7 @@ static void handle_cap_flush_ack(struct inode
*inode, u64 flush_tid,

        for (i = 0; i < CEPH_CAP_BITS; i++)
                if ((dirty & (1 << i)) &&
-                   flush_tid == ci->i_cap_flush_tid[i])
+                   (u16)flush_tid == ci->i_cap_flush_tid[i])
                        cleaned |= 1 << i;

        dout("handle_cap_flush_ack inode %p mds%d seq %d on %s cleaned %s,"

Reviewed-by: Ilya Dryomov <idryomov@redhat.com>

Thanks,

                Ilya
