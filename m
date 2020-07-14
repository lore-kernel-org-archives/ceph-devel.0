From: simon gao <simon29rock@gmail.com>
Subject: Re: [PATCH] libceph : client only want latest osdmap. If the gap with
 the latest version exceeds the threshold, mon will send the fullosdmap
 instead of incremental osdmap
Date: Tue, 14 Jul 2020 09:58:24 +0800
Message-ID: <CAGR3woXcQpE_LUuVM54SAqxdXGEJh1Q_koh_6bJHJQ-sfybnUw@mail.gmail.com>
References: <1594439373-2120-1-git-send-email-simon29rock@gmail.com> <CAOi1vP9Qu4QZcpLBYcpmxfsBFh-p0MxOFKw75qZH6QM=AusSPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbgGNB46 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Jul 2020 21:56:58 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723D9C061755
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2020 18:56:58 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 12so12718238oir.4
        for <ceph-devel@vger.kernel.org>; Mon, 13 Jul 2020 18:56:58 -0700 (PDT)
In-Reply-To: <CAOi1vP9Qu4QZcpLBYcpmxfsBFh-p0MxOFKw75qZH6QM=AusSPQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

hi idryomov
I've already replied to you under this patch.
thanks.
gao yu

Ilya Dryomov <idryomov@gmail.com> =E4=BA=8E2020=E5=B9=B47=E6=9C=8813=E6=97=
=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=8810:01=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, Jul 11, 2020 at 5:52 AM simon gao <simon29rock@gmail.com> wrote:
> >
> > Fix: https://tracker.ceph.com/issues/43421
> > Signed-off-by: simon gao <simon29rock@gmail.com>
> > ---
> >  include/linux/ceph/ceph_fs.h | 1 +
> >  net/ceph/mon_client.c        | 3 ++-
> >  2 files changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/ceph/ceph_fs.h b/include/linux/ceph/ceph_fs.=
h
> > index ebf5ba6..9dcc132 100644
> > --- a/include/linux/ceph/ceph_fs.h
> > +++ b/include/linux/ceph/ceph_fs.h
> > @@ -208,6 +208,7 @@ struct ceph_client_mount {
> >  } __attribute__ ((packed));
> >
> >  #define CEPH_SUBSCRIBE_ONETIME    1  /* i want only 1 update after hav=
e */
> > +#define CEPH_SUBSCRIBE_LATEST_OSDMAP   2  /* i want the latest fullmap=
, for client */
> >
> >  struct ceph_mon_subscribe_item {
> >         __le64 start;
> > diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
> > index 3d8c801..8d67671 100644
> > --- a/net/ceph/mon_client.c
> > +++ b/net/ceph/mon_client.c
> > @@ -349,7 +349,8 @@ static bool __ceph_monc_want_map(struct ceph_mon_cl=
ient *monc, int sub,
> >  {
> >         __le64 start =3D cpu_to_le64(epoch);
> >         u8 flags =3D !continuous ? CEPH_SUBSCRIBE_ONETIME : 0;
> > -
> > +       if (CEPH_SUB_OSDMAP =3D=3D sub)
> > +            flags |=3D CEPH_SUBSCRIBE_LATEST_OSDMAP;
> >         dout("%s %s epoch %u continuous %d\n", __func__, ceph_sub_str[s=
ub],
> >              epoch, continuous);
>
> I left my comments in https://github.com/ceph/ceph/pull/32422.
> This patch cannot be considered unless a corresponding change is
> merged into Objecter.
>
> Thanks,
>
>                 Ilya
