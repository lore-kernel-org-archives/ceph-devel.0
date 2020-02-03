From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [RFC PATCH] ceph: fix the debug message for calc_layout
Date: Mon, 3 Feb 2020 11:25:22 +0100
Message-ID: <CAOi1vP-pGZ1dBhr_EY8t=jas-16T887HTmtyJuVz70roKiYW1A@mail.gmail.com>
References: <20200203040133.39319-1-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io1-f67.google.com ([209.85.166.67]:39702 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726100AbgBCKZJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2020 05:25:09 -0500
Received: by mail-io1-f67.google.com with SMTP id c16so16114910ioh.6
        for <ceph-devel@vger.kernel.org>; Mon, 03 Feb 2020 02:25:09 -0800 (PST)
In-Reply-To: <20200203040133.39319-1-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Feb 3, 2020 at 5:02 AM <xiubli@redhat.com> wrote:
>
> From: Xiubo Li <xiubli@redhat.com>
>
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  net/ceph/osd_client.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 108c9457d629..6afe36ffc1ba 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -113,10 +113,11 @@ static int calc_layout(struct ceph_file_layout *layout, u64 off, u64 *plen,
>         if (*objlen < orig_len) {
>                 *plen = *objlen;
>                 dout(" skipping last %llu, final file extent %llu~%llu\n",
> -                    orig_len - *plen, off, *plen);
> +                    orig_len - *plen, off, off + *plen);
>         }
>
> -       dout("calc_layout objnum=%llx %llu~%llu\n", *objnum, *objoff, *objlen);
> +       dout("calc_layout objnum=%llx, object extent %llu~%llu\n", *objnum,
> +            *objoff, *objoff + *objlen);

Hi Xiubo,

offset~length is how extents are printed both on the OSD side and
elsewhere in the kernel client.

Thanks,

                Ilya
