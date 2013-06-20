From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: rbd: refactor rbd_header_from_disk()
Date: Fri, 21 Jun 2013 00:11:58 +0300
Message-ID: <20130620211158.GA31274@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:21021 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161153Ab3FTVMI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 17:12:08 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: ceph-devel@vger.kernel.org

Hello Alex Elder,

The patch bb23e37acb2a: "rbd: refactor rbd_header_from_disk()" from 
May 6, 2013, has some integer overflow bugs:

drivers/block/rbd.c
   793          snap_count = le32_to_cpu(ondisk->snap_count);
   794          snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);

snap_count comes from the disk.  On 32 bit systems there is an integer
overflow problem inside ceph_create_snap_context() so snapc could be
smaller than intended.

   795          if (!snapc)
   796                  goto out_err;
   797          snapc->seq = le64_to_cpu(ondisk->snap_seq);
   798          if (snap_count) {
   799                  struct rbd_image_snap_ondisk *snaps;
   800                  u64 snap_names_len = le64_to_cpu(ondisk->snap_names_len);
   801  
   802                  /* We'll keep a copy of the snapshot names... */
   803  
   804                  if (snap_names_len > (u64)SIZE_MAX)
   805                          goto out_2big;
   806                  snap_names = kmalloc(snap_names_len, GFP_KERNEL);
   807                  if (!snap_names)
   808                          goto out_err;
   809  
   810                  /* ...as well as the array of their sizes. */
   811  
   812                  size = snap_count * sizeof (*header->snap_sizes);
                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
There is a second integer overflow bug here.

   813                  snap_sizes = kmalloc(size, GFP_KERNEL);
   814                  if (!snap_sizes)
   815                          goto out_err;

regards,
dan carpenter

