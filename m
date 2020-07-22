From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH V2] fs:ceph: Remove unused variables in ceph_mdsmap_decode()
Date: Wed, 22 Jul 2020 15:53:16 +0200
Message-ID: <CAOi1vP9kMKVTr4K0WzEpr1cjvguuH-gOy8vnOrMm3ELdiBfk_A@mail.gmail.com>
References: <20200722134604.3026-1-jiayang5@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbgGVNxU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Jul 2020 09:53:20 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F63EC0619DC
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2020 06:53:20 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id z6so2623749iow.6
        for <ceph-devel@vger.kernel.org>; Wed, 22 Jul 2020 06:53:20 -0700 (PDT)
In-Reply-To: <20200722134604.3026-1-jiayang5@huawei.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jia Yang <jiayang5@huawei.com>
Cc: Jeff Layton <jlayton@kernel.org>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jul 22, 2020 at 3:39 PM Jia Yang <jiayang5@huawei.com> wrote:
>
> Fix build warnings:
>
> fs/ceph/mdsmap.c: In function =E2=80=98ceph_mdsmap_decode=E2=80=99:
> fs/ceph/mdsmap.c:192:7: warning:
> variable =E2=80=98info_cv=E2=80=99 set but not used [-Wunused-but-set-var=
iable]
> fs/ceph/mdsmap.c:177:7: warning:
> variable =E2=80=98state_seq=E2=80=99 set but not used [-Wunused-but-set-v=
ariable]
> fs/ceph/mdsmap.c:123:15: warning:
> variable =E2=80=98mdsmap_cv=E2=80=99 set but not used [-Wunused-but-set-v=
ariable]
>
> Use ceph_decode_skip_* instead of ceph_decode_*, because p is
> increased in ceph_decode_*.
>
> Signed-off-by: Jia Yang <jiayang5@huawei.com>
> ---
>  fs/ceph/mdsmap.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
> index 889627817e52..7455ba83822a 100644
> --- a/fs/ceph/mdsmap.c
> +++ b/fs/ceph/mdsmap.c
> @@ -120,7 +120,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void=
 *end)
>         const void *start =3D *p;
>         int i, j, n;
>         int err;
> -       u8 mdsmap_v, mdsmap_cv;
> +       u8 mdsmap_v;
>         u16 mdsmap_ev;
>
>         m =3D kzalloc(sizeof(*m), GFP_NOFS);
> @@ -129,7 +129,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void=
 *end)
>
>         ceph_decode_need(p, end, 1 + 1, bad);
>         mdsmap_v =3D ceph_decode_8(p);
> -       mdsmap_cv =3D ceph_decode_8(p);
> +       ceph_decode_skip_8(p, end, bad);

Hi Jia,

The bounds are already checked in ceph_decode_need(), so using
ceph_decode_skip_*() is unnecessary.  Just increment the position
with *p +=3D 1, staying consistent with ceph_decode_8(), which does
not bounds check.

>         if (mdsmap_v >=3D 4) {
>                u32 mdsmap_len;
>                ceph_decode_32_safe(p, end, mdsmap_len, bad);
> @@ -174,7 +174,6 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void=
 *end)
>                 u64 global_id;
>                 u32 namelen;
>                 s32 mds, inc, state;
> -               u64 state_seq;
>                 u8 info_v;
>                 void *info_end =3D NULL;
>                 struct ceph_entity_addr addr;
> @@ -189,9 +188,8 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void=
 *end)
>                 info_v=3D ceph_decode_8(p);
>                 if (info_v >=3D 4) {
>                         u32 info_len;
> -                       u8 info_cv;
>                         ceph_decode_need(p, end, 1 + sizeof(u32), bad);
> -                       info_cv =3D ceph_decode_8(p);
> +                       ceph_decode_skip_8(p, end, bad);

Ditto.

>                         info_len =3D ceph_decode_32(p);
>                         info_end =3D *p + info_len;
>                         if (info_end > end)
> @@ -210,7 +208,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void=
 *end)
>                 mds =3D ceph_decode_32(p);
>                 inc =3D ceph_decode_32(p);
>                 state =3D ceph_decode_32(p);
> -               state_seq =3D ceph_decode_64(p);
> +               ceph_decode_skip_64(p, end, bad);

Ditto.

Thanks,

                Ilya
