From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 2/2] rbd: compression_hint option
Date: Tue, 2 Jun 2020 11:59:41 +0200
Message-ID: <CAOi1vP-7qgEDQSE+0050_uH=fcUbtBGQurk3nsGVyYJMbeiKaA@mail.gmail.com>
References: <20200601195826.17159-1-idryomov@gmail.com> <20200601195826.17159-3-idryomov@gmail.com>
 <e3446fba-65e9-89b4-9687-6735f6935196@easystack.cn> <CAOi1vP9yu=xTJ-Oec=M-g0C0RKzb_oZ9DxjLDfmoqeNhyVpwHg@mail.gmail.com>
 <f5d1cc3a-935d-542d-c6ac-29e698ef1b1f@easystack.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgFBJ7f (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Jun 2020 05:59:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08607C061A0E
        for <ceph-devel@vger.kernel.org>; Tue,  2 Jun 2020 02:59:35 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so10151954iow.7
        for <ceph-devel@vger.kernel.org>; Tue, 02 Jun 2020 02:59:34 -0700 (PDT)
In-Reply-To: <f5d1cc3a-935d-542d-c6ac-29e698ef1b1f@easystack.cn>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jason Dillaman <jdillama@redhat.com>

On Tue, Jun 2, 2020 at 11:06 AM Dongsheng Yang
<dongsheng.yang@easystack.cn> wrote:
>
>
> =E5=9C=A8 6/2/2020 4:31 PM, Ilya Dryomov =E5=86=99=E9=81=93:
> > On Tue, Jun 2, 2020 at 4:34 AM Dongsheng Yang
> > <dongsheng.yang@easystack.cn> wrote:
> >> Hi Ilya,
> >>
> >> =E5=9C=A8 6/2/2020 3:58 AM, Ilya Dryomov =E5=86=99=E9=81=93:
> >>> Allow hinting to bluestore if the data should/should not be compresse=
d.
> >>> The default is to not hint (compression_hint=3Dnone).
> >>>
> >>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> >>> ---
> >>>    drivers/block/rbd.c | 43 +++++++++++++++++++++++++++++++++++++++++=
+-
> >>>    1 file changed, 42 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> >>> index b1cd41e671d1..e02089d550a4 100644
> >>> --- a/drivers/block/rbd.c
> >>> +++ b/drivers/block/rbd.c
> >>> @@ -836,6 +836,7 @@ enum {
> >>>        Opt_lock_timeout,
> >>>        /* int args above */
> >>>        Opt_pool_ns,
> >>> +     Opt_compression_hint,
> >>>        /* string args above */
> >>>        Opt_read_only,
> >>>        Opt_read_write,
> >>> @@ -844,8 +845,23 @@ enum {
> >>>        Opt_notrim,
> >>>    };
> >>>
> >>> +enum {
> >>> +     Opt_compression_hint_none,
> >>> +     Opt_compression_hint_compressible,
> >>> +     Opt_compression_hint_incompressible,
> >>> +};
> >>> +
> >>> +static const struct constant_table rbd_param_compression_hint[] =3D =
{
> >>> +     {"none",                Opt_compression_hint_none},
> >>> +     {"compressible",        Opt_compression_hint_compressible},
> >>> +     {"incompressible",      Opt_compression_hint_incompressible},
> >>> +     {}
> >>> +};
> >>> +
> >>>    static const struct fs_parameter_spec rbd_parameters[] =3D {
> >>>        fsparam_u32     ("alloc_size",                  Opt_alloc_size=
),
> >>> +     fsparam_enum    ("compression_hint",            Opt_compression=
_hint,
> >>> +                      rbd_param_compression_hint),
> >>>        fsparam_flag    ("exclusive",                   Opt_exclusive)=
,
> >>>        fsparam_flag    ("lock_on_read",                Opt_lock_on_re=
ad),
> >>>        fsparam_u32     ("lock_timeout",                Opt_lock_timeo=
ut),
> >>> @@ -867,6 +883,8 @@ struct rbd_options {
> >>>        bool    lock_on_read;
> >>>        bool    exclusive;
> >>>        bool    trim;
> >>> +
> >>> +     u32 alloc_hint_flags;  /* CEPH_OSD_OP_ALLOC_HINT_FLAG_* */
> >>>    };
> >>>
> >>>    #define RBD_QUEUE_DEPTH_DEFAULT     BLKDEV_MAX_RQ
> >>> @@ -2254,7 +2272,7 @@ static void __rbd_osd_setup_write_ops(struct ce=
ph_osd_request *osd_req,
> >>>                osd_req_op_alloc_hint_init(osd_req, which++,
> >>>                                           rbd_dev->layout.object_size=
,
> >>>                                           rbd_dev->layout.object_size=
,
> >>> -                                        0);
> >>> +                                        rbd_dev->opts->alloc_hint_fl=
ags);
> >>>        }
> >>>
> >>>        if (rbd_obj_is_entire(obj_req))
> >>> @@ -6332,6 +6350,29 @@ static int rbd_parse_param(struct fs_parameter=
 *param,
> >>>                pctx->spec->pool_ns =3D param->string;
> >>>                param->string =3D NULL;
> >>>                break;
> >>> +     case Opt_compression_hint:
> >>> +             switch (result.uint_32) {
> >>> +             case Opt_compression_hint_none:
> >>> +                     opt->alloc_hint_flags &=3D
> >>> +                         ~(CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE |
> >>> +                           CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE);
> >>> +                     break;
> >>> +             case Opt_compression_hint_compressible:
> >>> +                     opt->alloc_hint_flags |=3D
> >>> +                         CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE;
> >>> +                     opt->alloc_hint_flags &=3D
> >>> +                         ~CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE;
> >>> +                     break;
> >>> +             case Opt_compression_hint_incompressible:
> >>> +                     opt->alloc_hint_flags |=3D
> >>> +                         CEPH_OSD_ALLOC_HINT_FLAG_INCOMPRESSIBLE;
> >>> +                     opt->alloc_hint_flags &=3D
> >>> +                         ~CEPH_OSD_ALLOC_HINT_FLAG_COMPRESSIBLE;
> >>> +                     break;
> >>
> >> Just one little question here,
> >>
> >> (1) none opt means clear compressible related bits in hint flags, then
> >> lets the compressor in bluestore to decide compress or not.
> >>
> >> (2) compressible opt means set compressible bit and clear incompressib=
le bit
> >>
> >> (3) incompressible opt means set incompressible bit and clear
> >> compressible bit
> >>
> >>
> >> Is there any scenario that alloc_hint_flags is not zero filled before
> >> rbd_parse_param(), then we have to clear the unexpected bit?
> > Hi Dongsheng,
> >
> > This is to handle the case when the map option string has multiple
> > compression_hint options:
> >
> >    name=3Dadmin,...,compression_hint=3Dcompressible,...,compression_hin=
t=3Dnone
> >
> > The last one wins and we always end up with either zero or just one
> > of the flags set, not both.
>
>
> Hi Ilya,
>
>       Considering this case, should we make this kind of useage invalid?
> Maybe we
>
> can do it in another patch to solve all rbd parameters conflicting proble=
m.

No.  On the contrary, the intention is to support overriding in
the form of "the last one wins" going forward to be consistent with
filesystems, where this behaviour is expected for the use case of
overriding /etc/fstab options on the command line.

Thanks,

                Ilya
