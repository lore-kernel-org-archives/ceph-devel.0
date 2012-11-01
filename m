From: Alex Elder <elder@inktank.com>
Subject: [PATCH 3/4] rbd: add a warning in bio_chain_clone_range()
Date: Thu, 01 Nov 2012 10:26:42 -0500
Message-ID: <509294B2.6090705@inktank.com>
References: <50929419.6020302@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f174.google.com ([209.85.210.174]:42446 "EHLO
	mail-ia0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935828Ab2KAP0q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Nov 2012 11:26:46 -0400
Received: by mail-ia0-f174.google.com with SMTP id y32so1983034iag.19
        for <ceph-devel@vger.kernel.org>; Thu, 01 Nov 2012 08:26:46 -0700 (PDT)
In-Reply-To: <50929419.6020302@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Add a warning in bio_chain_clone_range() to help a user determine
what exactly might have led to a failure.  There is only one; please
say something if you disagree with the following reasoning.

There are three places this can return abnormally:
    - Initially, if there is nothing to clone.  It turns out that
      right now this cannot happen anyway.  The test is in place
      because the code below it doesn't work if those conditions
      don't hold.  As such they could be assertions but since I can
      return a null to indicate an error I just do that instead.
      I have not added a warning here because it won't happen.
    - While processing bio's, if none remain but there are supposed
      to be more bytes to clone.  Here I have added a warning.
    - If bio_clone_range() returns a null pointer.  That function
      will have already produced a warning (at least the first
      time, via WARN_ON_ONCE()) to distinguish the cause of the
      error.  The only exception is memory exhaustion, and I'd
      rather not pepper the code with warnings in all those spots.
      So no warning is added in that place.

Signed-off-by: Alex Elder <elder@inktank.com>
---
 drivers/block/rbd.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index de1d3b1..3ab3970 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -995,8 +995,10 @@ static struct bio *bio_chain_clone_range(struct bio
**bio_src,
 		unsigned int bi_size;
 		struct bio *bio;

-		if (!bi)
+		if (!bi) {
+			rbd_warn(NULL, "bio_chain exhausted with %u left", len);
 			goto out_err;	/* EINVAL; ran out of bio's */
+		}
 		bi_size = min_t(unsigned int, bi->bi_size - off, len);
 		bio = bio_clone_range(bi, off, bi_size, gfpmask);
 		if (!bio)
-- 
1.7.9.5

