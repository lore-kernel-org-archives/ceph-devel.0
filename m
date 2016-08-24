From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH -next] ceph: use list_move instead of list_del/list_add
Date: Wed, 24 Aug 2016 15:41:54 +0200
Message-ID: <CAOi1vP9TB3vsRSCUWsWCD4aKZ9bBkmaydwG6Jj_Y6jwTgtxMOQ@mail.gmail.com>
References: <1471079428-9951-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:34325 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753286AbcHXNy5 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 09:54:57 -0400
Received: by mail-ua0-f193.google.com with SMTP id d97so1302898uad.1
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 06:54:56 -0700 (PDT)
In-Reply-To: <1471079428-9951-1-git-send-email-weiyj.lk@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sat, Aug 13, 2016 at 11:10 AM, Wei Yongjun <weiyj.lk@gmail.com> wrote:
> Using list_move() instead of list_del() + list_add().
>
> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
> ---
>  fs/ceph/mds_client.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index f72d4ae..d55df51 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1150,8 +1150,7 @@ static int remove_session_caps_cb(struct inode *inode, struct ceph_cap *cap,
>                 while (!list_empty(&ci->i_cap_flush_list)) {
>                         cf = list_first_entry(&ci->i_cap_flush_list,
>                                               struct ceph_cap_flush, i_list);
> -                       list_del(&cf->i_list);
> -                       list_add(&cf->i_list, &to_remove);
> +                       list_move(&cf->i_list, &to_remove);
>                 }
>
>                 spin_lock(&mdsc->cap_dirty_lock);

Applied.

Thanks,

                Ilya
