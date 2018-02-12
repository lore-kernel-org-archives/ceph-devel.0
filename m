From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: fix misjudgement of maximum monitor number
Date: Mon, 12 Feb 2018 15:58:05 +0100
Message-ID: <CAOi1vP8RZXLz+9PxLsnYNK4=5q1ouJaT7KfNgxD3iCKdUkewZg@mail.gmail.com>
References: <1518312808-34839-1-git-send-email-cgxu519@icloud.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:55540 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932156AbeBLO6G (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Feb 2018 09:58:06 -0500
Received: by mail-it0-f67.google.com with SMTP id b66so6953478itd.5
        for <ceph-devel@vger.kernel.org>; Mon, 12 Feb 2018 06:58:06 -0800 (PST)
In-Reply-To: <1518312808-34839-1-git-send-email-cgxu519@icloud.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chengguang Xu <cgxu519@icloud.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Feb 11, 2018 at 2:33 AM, Chengguang Xu <cgxu519@icloud.com> wrote:
> num_mon should allow up to CEPH_MAX_MON in ceph_monmap_decode().
>
> Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
> ---
>  net/ceph/mon_client.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> index 1547107..b3dac24 100644
> --- a/net/ceph/mon_client.c
> +++ b/net/ceph/mon_client.c
> @@ -60,7 +60,7 @@ struct ceph_monmap *ceph_monmap_decode(void *p, void *end)
>         num_mon = ceph_decode_32(&p);
>         ceph_decode_need(&p, end, num_mon*sizeof(m->mon_inst[0]), bad);
>
> -       if (num_mon >= CEPH_MAX_MON)
> +       if (num_mon > CEPH_MAX_MON)
>                 goto bad;
>         m = kmalloc(sizeof(*m) + sizeof(m->mon_inst[0])*num_mon, GFP_NOFS);
>         if (m == NULL)

Applied.

Thanks,

                Ilya
