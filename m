From: "Yan, Zheng" <ukernel@gmail.com>
Subject: Re: ceph: set i_head_snapc when getting CEPH_CAP_FILE_WR reference
Date: Wed, 15 Jun 2016 20:54:32 +0800
Message-ID: <CAAM7YA=RFQyhgR12aGtQw4QtUaXZ04thQ0XX_scLaYgQk+Oy7A@mail.gmail.com>
References: <20160615124418.GA11243@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:36033 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753146AbcFOMyd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Jun 2016 08:54:33 -0400
Received: by mail-vk0-f54.google.com with SMTP id u64so27826933vkf.3
        for <ceph-devel@vger.kernel.org>; Wed, 15 Jun 2016 05:54:33 -0700 (PDT)
In-Reply-To: <20160615124418.GA11243@mwanda>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Zheng Yan <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, Jun 15, 2016 at 8:44 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Hello Yan, Zheng,
>
> The patch 5dda377cf0a6: "ceph: set i_head_snapc when getting
> CEPH_CAP_FILE_WR reference" from Apr 30, 2015, leads to the following
> static checker warning:
>
>         fs/ceph/snap.c:557 ceph_queue_cap_snap()
>         error: potential NULL dereference 'old_snapc'.
>
> fs/ceph/snap.c
>    547          /* dirty page count moved from _head to this cap_snap;
>    548             all subsequent writes page dirties occur _after_ this
>    549             snapshot. */
>    550          capsnap->dirty_pages = ci->i_wrbuffer_ref_head;
>    551          ci->i_wrbuffer_ref_head = 0;
>    552          capsnap->context = old_snapc;
>    553          list_add_tail(&capsnap->ci_item, &ci->i_cap_snaps);
>    554          old_snapc = NULL;
>                 ^^^^^^^^^^^^^^^^^
>    555
>    556          if (used & CEPH_CAP_FILE_WR) {
>    557                  dout("queue_cap_snap %p cap_snap %p snapc %p"
>    558                       " seq %llu used WR, now pending\n", inode,
>    559                       capsnap, old_snapc, old_snapc->seq);
>                                                  ^^^^^^^^^^^^^^
> This is a NULL deref.
>
>    560                  capsnap->writing = 1;
>    561          } else {
>    562                  /* note mtime, size NOW. */
>    563                  __ceph_finish_cap_snap(ci, capsnap);
>    564          }
>    565          capsnap = NULL;


Fixed by https://github.com/ceph/ceph-client/commit/c17197fca778207cc24d434106b5b5b2f2a17c16

Thanks
Yan, Zheng


>
> regards,
> dan carpenter
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
