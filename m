From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [PATCH 0/3] rbd: fix some issues around flushing notifies
Date: Tue, 17 Mar 2020 12:41:16 -0400
Message-ID: <CA+aFP1DkGftqkWF6_g6Op0prYBXgv50ynfsG=yyCinLDm++uRg@mail.gmail.com>
References: <20200317120422.3406-1-idryomov@gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:21833 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgCQQlc (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:41:32 -0400
Received: by mail-wm1-f72.google.com with SMTP id z16so2056512wmi.2
        for <ceph-devel@vger.kernel.org>; Tue, 17 Mar 2020 09:41:29 -0700 (PDT)
In-Reply-To: <20200317120422.3406-1-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Mar 17, 2020 at 8:06 AM Ilya Dryomov <idryomov@gmail.com> wrote:
>
> Hello,
>
> A recent snapshot-based mirroring experiment exposed a deadlock on
> header_rwsem in the error path of rbd_dev_image_probe() (i.e. "rbd
> map").
>
> Thanks,
>
>                 Ilya
>
>
> Ilya Dryomov (3):
>   rbd: avoid a deadlock on header_rwsem when flushing notifies
>   rbd: call rbd_dev_unprobe() after unwatching and flushing notifies
>   rbd: don't test rbd_dev->opts in rbd_dev_image_release()
>
>  drivers/block/rbd.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> --
> 2.19.2
>

The "get_snapcontext" call still going to hang (albeit in an
interruptible state) if the image has > 510 snapshots, correct?

Reviewed-by: Jason Dillaman <dillaman@redhat.com>

-- 
Jason
