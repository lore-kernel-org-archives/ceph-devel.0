From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: move to a dedicated slabcache for mds requests
Date: Tue, 18 Feb 2020 16:27:45 +0100
Message-ID: <CAOi1vP9fKwZ+Q70Q8kcqByRz3A07+75mWqu5GL6CHoGqTwX2YA@mail.gmail.com>
References: <20200218141116.26481-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f65.google.com ([209.85.166.65]:34413 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgBRP1V (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Feb 2020 10:27:21 -0500
Received: by mail-io1-f65.google.com with SMTP id z193so22738953iof.1
        for <ceph-devel@vger.kernel.org>; Tue, 18 Feb 2020 07:27:21 -0800 (PST)
In-Reply-To: <20200218141116.26481-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>

On Tue, Feb 18, 2020 at 3:11 PM Jeff Layton <jlayton@kernel.org> wrote:
>
> On my machine (x86_64) this struct is 952 bytes, which gets rounded up
> to 1024 by kmalloc. Move this to a dedicated slabcache, so we can
> allocate them without the extra 72 bytes of overhead per.
>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/mds_client.c         | 6 +++---
>  fs/ceph/super.c              | 8 ++++++++
>  include/linux/ceph/libceph.h | 1 +
>  3 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index 2980e57ca7b9..76655047fca5 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -736,7 +736,7 @@ void ceph_mdsc_release_request(struct kref *kref)
>         put_request_session(req);
>         ceph_unreserve_caps(req->r_mdsc, &req->r_caps_reservation);
>         WARN_ON_ONCE(!list_empty(&req->r_wait));
> -       kfree(req);
> +       kmem_cache_free(ceph_mds_request_cachep, req);
>  }
>
>  DEFINE_RB_FUNCS(request, struct ceph_mds_request, r_tid, r_node)
> @@ -2094,8 +2094,8 @@ int ceph_alloc_readdir_reply_buffer(struct ceph_mds_request *req,
>  struct ceph_mds_request *
>  ceph_mdsc_create_request(struct ceph_mds_client *mdsc, int op, int mode)
>  {
> -       struct ceph_mds_request *req = kzalloc(sizeof(*req), GFP_NOFS);
> -
> +       struct ceph_mds_request *req = kmem_cache_alloc(ceph_mds_request_cachep,
> +                                                       GFP_NOFS | __GFP_ZERO);

This can be kmem_cache_zalloc(), less verbose.  Also, I would separate
declaration and assignment here.

Thanks,

                Ilya
