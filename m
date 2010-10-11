From: Dan Carpenter <error27@gmail.com>
Subject: [patch 2/2 -next] rbd: passing wrong variable to bvec_kunmap_irq()
Date: Mon, 11 Oct 2010 21:15:11 +0200
Message-ID: <20101011191511.GJ5851@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44000 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755608Ab0JKTP1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Oct 2010 15:15:27 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@hq.newdream.net>
Cc: Sage Weil <sage@newdream.net>, ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

We should be passing "buf" here insead of "bv".  This is tricky because
it's not the same as kmap() and kunmap().  GCC does warn about it if you
compile on i386 with CONFIG_HIGHMEM.

Signed-off-by: Dan Carpenter <error27@gmail.com>
---
If it's any consolation, out of three callers to bvec_kunmap_irq() only
one caller was correct.  :P

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 52f9420..6ec9d53 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -554,7 +554,7 @@ static void zero_bio_chain(struct bio *chain, int start_ofs)
 				buf = bvec_kmap_irq(bv, &flags);
 				memset(buf + remainder, 0,
 				       bv->bv_len - remainder);
-				bvec_kunmap_irq(bv, &flags);
+				bvec_kunmap_irq(buf, &flags);
 			}
 			pos += bv->bv_len;
 		}
