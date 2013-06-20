From: Alex Elder <alex.elder@linaro.org>
Subject: Re: rbd: refactor rbd_header_from_disk()
Date: Thu, 20 Jun 2013 16:23:13 -0500
Message-ID: <51C372C1.7010607@linaro.org>
References: <20130620211158.GA31274@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:50080 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758204Ab3FTVXD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 17:23:03 -0400
Received: by mail-ie0-f172.google.com with SMTP id 16so17933844iea.31
        for <ceph-devel@vger.kernel.org>; Thu, 20 Jun 2013 14:23:03 -0700 (PDT)
In-Reply-To: <20130620211158.GA31274@elgon.mountain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: elder@inktank.com, ceph-devel@vger.kernel.org

On 06/20/2013 04:11 PM, Dan Carpenter wrote:
> Hello Alex Elder,
> 
> The patch bb23e37acb2a: "rbd: refactor rbd_header_from_disk()" from 
> May 6, 2013, has some integer overflow bugs:
> 
> drivers/block/rbd.c
>    793          snap_count = le32_to_cpu(ondisk->snap_count);
>    794          snapc = ceph_create_snap_context(snap_count, GFP_KERNEL);
> 
> snap_count comes from the disk.  On 32 bit systems there is an integer
> overflow problem inside ceph_create_snap_context() so snapc could be
> smaller than intended.

Is it true that fixing ceph_create_snap_context() would resolve
the issues you describe here?

I believe inserting this at the top of that function would
resolve the potential overflow:

        if (snap_count > SNAP_COUNT_MAX)
                return NULL;

Where SNAP_COUNT_MAX would be defined as:

#define SNAP_COUNT_MAX \
        ((SIZE_MAX - sizeof (struct ceph_snap_context)) / sizeof (u64))

Do you agree, or is there something else you would recommend?
Thanks.

					-Alex
> 
>    795          if (!snapc)
>    796                  goto out_err;
>    797          snapc->seq = le64_to_cpu(ondisk->snap_seq);
>    798          if (snap_count) {
>    799                  struct rbd_image_snap_ondisk *snaps;
>    800                  u64 snap_names_len = le64_to_cpu(ondisk->snap_names_len);
>    801  
>    802                  /* We'll keep a copy of the snapshot names... */
>    803  
>    804                  if (snap_names_len > (u64)SIZE_MAX)
>    805                          goto out_2big;
>    806                  snap_names = kmalloc(snap_names_len, GFP_KERNEL);
>    807                  if (!snap_names)
>    808                          goto out_err;
>    809  
>    810                  /* ...as well as the array of their sizes. */
>    811  
>    812                  size = snap_count * sizeof (*header->snap_sizes);
>                                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> There is a second integer overflow bug here.
> 
>    813                  snap_sizes = kmalloc(size, GFP_KERNEL);
>    814                  if (!snap_sizes)
>    815                          goto out_err;
> 
> regards,
> dan carpenter
> 

