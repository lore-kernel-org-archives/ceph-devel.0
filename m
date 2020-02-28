From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] ceph: using POOL FULL flag instead of OSDMAP FULL flag
Date: Fri, 28 Feb 2020 15:01:56 +0100
Message-ID: <CAOi1vP_opdc=OP70T2eiamMWa-o71nU8t_LYyTCytqT5BT8gdQ@mail.gmail.com>
References: <20200228044518.20314-1-gmayyyha@gmail.com> <CAOi1vP-K+e0N26qpthLcst8HLE-FAMGSE9XwBhj1dPBiLyN-iA@mail.gmail.com>
 <CAB9OAC0dURDHgqGDVCg_Gd+EhH-9_n4-mycgsqfxS64GRgd4Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAB9OAC0dURDHgqGDVCg_Gd+EhH-9_n4-mycgsqfxS64GRgd4Og@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yanhu Cao <gmayyyha@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "David S. Miller" <davem@davemloft.net>, kuba@kernel.org, Ceph Development <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

On Fri, Feb 28, 2020 at 12:41 PM Yanhu Cao <gmayyyha@gmail.com> wrote:
>
> On Fri, Feb 28, 2020 at 6:23 PM Ilya Dryomov <idryomov@gmail.com> wrote:
> >
> > On Fri, Feb 28, 2020 at 5:45 AM Yanhu Cao <gmayyyha@gmail.com> wrote:
> > >
> > > OSDMAP_FULL and OSDMAP_NEARFULL are deprecated since mimic.
> > >
> > > Signed-off-by: Yanhu Cao <gmayyyha@gmail.com>
> > > ---
> > >  fs/ceph/file.c                  |  6 ++++--
> > >  include/linux/ceph/osd_client.h |  2 ++
> > >  include/linux/ceph/osdmap.h     |  3 ++-
> > >  net/ceph/osd_client.c           | 23 +++++++++++++----------
> > >  4 files changed, 21 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > index 7e0190b1f821..60ea1eed1b84 100644
> > > --- a/fs/ceph/file.c
> > > +++ b/fs/ceph/file.c
> > > @@ -1482,7 +1482,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >         }
> > >
> > >         /* FIXME: not complete since it doesn't account for being at quota */
> > > -       if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_FULL)) {
> > > +       if (pool_flag(&fsc->client->osdc, ci->i_layout.pool_id,
> > > +                               CEPH_POOL_FLAG_FULL)) {
> > >                 err = -ENOSPC;
> > >                 goto out;
> > >         }
> > > @@ -1575,7 +1576,8 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
> > >         }
> > >
> > >         if (written >= 0) {
> > > -               if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_NEARFULL))
> > > +               if (pool_flag(&fsc->client->osdc, ci->i_layout.pool_id,
> > > +                                       CEPH_POOL_FLAG_NEARFULL))
> >
> > Hi Yanhu,
> >
> > Have you considered pre-mimic clusters here?  They are still supported
> > (and will continue to be supported for the foreseeable future).
> >
> > Thanks,
> >
> >                 Ilya
>
> I have tested it work on Luminous, I think it work too since
> ceph-v0.80(https://github.com/ceph/ceph/blob/b78644e7dee100e48dfeca32c9270a6b210d3003/src/osd/osd_types.h#L815)
> alread have pool FLAG_FULL.

But not FLAG_NEARFULL, which appeared in mimic.

>
> CephFS doesn't write synchronously even if CEPH_OSDMAP_NEARFULL is
> used, then should fixed by CEPH_POOL_FLAG_NEARFULL.

I'm not sure I follow.

-    if (ceph_osdmap_flag(&fsc->client->osdc, CEPH_OSDMAP_NEARFULL))
+    if (pool_flag(&fsc->client->osdc, ci->i_layout.pool_id,
+                            CEPH_POOL_FLAG_NEARFULL))

AFAICT this change would effectively disable this branch for pre-mimic
clusters.  Are you saying this branch is already broken?

Thanks,

                Ilya
