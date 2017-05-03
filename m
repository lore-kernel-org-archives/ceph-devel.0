From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [PATCH 0/9] rbd: support for rbd map --exclusive
Date: Wed, 3 May 2017 15:16:25 -0400
Message-ID: <CA+aFP1BgPUzQQ6Qfj=fpursJpY1AuvxFDD64DgT_ncaxX+v54w@mail.gmail.com>
References: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f174.google.com ([209.85.161.174]:36466 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755950AbdECTQ0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 3 May 2017 15:16:26 -0400
Received: by mail-yw0-f174.google.com with SMTP id l18so90377165ywh.3
        for <ceph-devel@vger.kernel.org>; Wed, 03 May 2017 12:16:26 -0700 (PDT)
In-Reply-To: <1493112825-16403-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Reviewed-by: Jason Dillaman <dillaman@redhat.com>

On Tue, Apr 25, 2017 at 5:33 AM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Hello,
>
> This adds support for optionally disabling automatic exclusive lock
> transitions.  Patches 1-3 fix some existing error paths and can go in
> independently.
>
> Thanks,
>
>                 Ilya
>
>
> Ilya Dryomov (9):
>   rbd: move rbd_dev_destroy() call out of rbd_dev_image_release()
>   rbd: move rbd_unregister_watch() call into rbd_dev_image_release()
>   rbd: fix error handling around rbd_init_disk()
>   rbd: ignore unlock errors
>   rbd: store lock cookie
>   rbd: support updating the lock cookie without releasing the lock
>   rbd: kill rbd_is_lock_supported()
>   rbd: return ResponseMessage result from rbd_handle_request_lock()
>   rbd: exclusive map option
>
>  drivers/block/rbd.c                  | 357 +++++++++++++++++++++--------------
>  include/linux/ceph/cls_lock_client.h |   5 +
>  net/ceph/cls_lock_client.c           |  51 +++++
>  3 files changed, 270 insertions(+), 143 deletions(-)
>
> --
> 2.4.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Jason
