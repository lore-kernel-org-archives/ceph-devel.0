From: Jason Dillaman <jdillama@redhat.com>
Subject: Re: [PATCH 00/15] rbd: support for data-pool + obj_request->object_no
Date: Wed, 15 Feb 2017 09:53:40 -0500
Message-ID: <CA+aFP1Aontez+pP88B2+rp0XiCy0usB2_Ld8b_aJ_SWNtxW23w@mail.gmail.com>
References: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Reply-To: dillaman@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f42.google.com ([209.85.215.42]:35164 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdBOOxm (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 15 Feb 2017 09:53:42 -0500
Received: by mail-lf0-f42.google.com with SMTP id n124so82109740lfd.2
        for <ceph-devel@vger.kernel.org>; Wed, 15 Feb 2017 06:53:42 -0800 (PST)
In-Reply-To: <1487103124-2974-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Alex Elder <elder@ieee.org>

Reviewed-by: Jason Dillaman <dillaman@redhat.com>

On Tue, Feb 14, 2017 at 3:11 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> Hello,
>
> There are two pieces here: support for RBD_FEATURE_DATA_POOL (patches
> 1-10) and a couple of cleanups / minor optimizations that build on it
> and allow us to get rid of rbd_segment_name_cache (patches 11 - 15).
>
> Thanks,
>
>                 Ilya
>
>
> Ilya Dryomov (15):
>   rbd: use kstrndup() in rbd_header_from_disk()
>   rbd: kill rbd_image_header::{crypt_type,comp_type}
>   rbd: initialize rbd_dev->header_oloc early
>   rbd: do away with obj_request in rbd_obj_read_sync()
>   libceph: pass reply buffer length through ceph_osdc_call()
>   rbd: switch rbd_obj_method_sync() to ceph_osdc_call()
>   rbd: remove now unused rbd_obj_request_wait() and helpers
>   rbd: use rbd_obj_bytes() more
>   rbd: introduce rbd_init_layout()
>   rbd: support for data-pool feature
>   rbd: set offset and length outside of rbd_obj_request_create()
>   rbd: factor out __rbd_osd_req_create()
>   rbd: RBD_V{1,2}_DATA_FORMAT macros
>   rbd: store and use obj_request->object_no
>   rbd: kill obj_request->object_name and rbd_segment_name_cache
>
>  drivers/block/rbd.c         | 601 +++++++++++++++++---------------------------
>  drivers/block/rbd_types.h   |  10 +-
>  include/linux/ceph/osdmap.h |   7 -
>  net/ceph/cls_lock_client.c  |   2 +-
>  net/ceph/osd_client.c       |   7 +-
>  5 files changed, 238 insertions(+), 389 deletions(-)
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
