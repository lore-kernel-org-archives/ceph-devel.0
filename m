From: Chris Dunlop <chris@onthe.net.au>
Subject: Re: krbd + format=2 ?
Date: Thu, 13 Jun 2013 16:35:35 +1000
Message-ID: <20130613063535.GA19160@onthe.net.au>
References: <20130603092428.GB28293@onthe.net.au>
 <51B2103C.7040402@inktank.com>
 <20130608024852.GA31065@onthe.net.au>
 <20130612045949.GA13654@onthe.net.au>
 <51B94302.1010104@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp1.onthe.net.au ([203.22.196.249]:59813 "EHLO
	smtp1.onthe.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750762Ab3FMGfp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Jun 2013 02:35:45 -0400
Content-Disposition: inline
In-Reply-To: <51B94302.1010104@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Alex Elder <elder@inktank.com>, ceph-devel@vger.kernel.org

On Wed, Jun 12, 2013 at 08:56:50PM -0700, Josh Durgin wrote:
> On 06/11/2013 09:59 PM, Chris Dunlop wrote:
>> Looks like the kernel rbd and librbd aren't compatible, as at
>> 3.10.0-rc4+ceph-client/for-linus@3abef3b vs librbd1 0.56.6-1~bpo70+1.
> 
> Thanks for the detailed report Chris. The kernel client was using the
> wrong object names for format 2 (zero-padding them with a different
> length than librbd). I just posted a patch fixing this.

Works for me!

(I had to modify the first of your posted patches to apply it to
current linux master (@26e04462c) which pulled in Sage's
for-linus branch: see below.)

Cheers,

Chris.

----------------------------------------------------------------------
commit 932c369af21c9449649238f1b91d1062ab45384e
Author: Josh Durgin <josh.durgin@inktank.com>
Date:   Wed Jun 12 20:10:45 2013 -0700

    rbd: fetch object order before using it
    
    rbd_dev_v2_header_onetime() fetches striping information, and
    checks whether the image can be read by compariing the stripe unit
    to the object size. It determines the object size by shifting
    the object order, which is 0 at this point since it has not been
    read yet. Move the call to get the image size and object order
    before rbd_dev_v2_header_onetime() so it is set before use.
    
    Signed-off-by: Josh Durgin <josh.durgin@inktank.com>

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 3063452..2fecab2 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4239,6 +4239,10 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 
 	down_write(&rbd_dev->header_rwsem);
 
+	ret = rbd_dev_v2_image_size(rbd_dev);
+	if (ret)
+		goto out;
+
 	if (first_time) {
 		ret = rbd_dev_v2_header_onetime(rbd_dev);
 		if (ret)
@@ -4272,10 +4276,6 @@ static int rbd_dev_v2_header_info(struct rbd_device *rbd_dev)
 					"is EXPERIMENTAL!");
 	}
 
-	ret = rbd_dev_v2_image_size(rbd_dev);
-	if (ret)
-		goto out;
-
 	if (rbd_dev->spec->snap_id == CEPH_NOSNAP)
 		if (rbd_dev->mapping.size != rbd_dev->header.image_size)
 			rbd_dev->mapping.size = rbd_dev->header.image_size;
