From: Alex Elder <elder@inktank.com>
Subject: [PATCH REPOST 3/4] rbd: add a warning in bio_chain_clone_range()
Date: Thu, 03 Jan 2013 13:12:07 -0600
Message-ID: <50E5D807.6040300@inktank.com>
References: <50E5D7A9.6040101@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:50582 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751Ab3ACTMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Jan 2013 14:12:10 -0500
Received: by mail-ie0-f181.google.com with SMTP id 16so18806126iea.12
        for <ceph-devel@vger.kernel.org>; Thu, 03 Jan 2013 11:12:10 -0800 (PST)
In-Reply-To: <50E5D7A9.6040101@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

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
index 31da8c5..ce6c0cb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -993,8 +993,10 @@ static struct bio *bio_chain_clone_range(struct bio
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

