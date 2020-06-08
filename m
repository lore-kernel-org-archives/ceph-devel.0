From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: move away from global osd_req_flags
Date: Mon, 8 Jun 2020 12:25:30 +0200
Message-ID: <CAOi1vP-K8RQ1gapeYObmCestiqnYgh4iWE25NVKy4e6x3-OE-w@mail.gmail.com>
References: <20200608075603.29053-1-idryomov@gmail.com> <878sgxan7d.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726202AbgFHKZY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Jun 2020 06:25:24 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A7EC08C5C3
        for <ceph-devel@vger.kernel.org>; Mon,  8 Jun 2020 03:25:24 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q8so17974925iow.7
        for <ceph-devel@vger.kernel.org>; Mon, 08 Jun 2020 03:25:24 -0700 (PDT)
In-Reply-To: <878sgxan7d.fsf@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Luis Henriques <lhenriques@suse.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Jeff Layton <jlayton@kernel.org>

On Mon, Jun 8, 2020 at 12:03 PM Luis Henriques <lhenriques@suse.com> wrote:
>
> Ilya Dryomov <idryomov@gmail.com> writes:
>
> > osd_req_flags is overly general and doesn't suit its only user
> > (read_from_replica option) well:
> >
> > - applying osd_req_flags in account_request() affects all OSD
> >   requests, including linger (i.e. watch and notify).  However,
> >   linger requests should always go to the primary even though
> >   some of them are reads (e.g. notify has side effects but it
> >   is a read because it doesn't result in mutation on the OSDs).
> >
> > - calls to class methods that are reads are allowed to go to
> >   the replica, but most such calls issued for "rbd map" and/or
> >   exclusive lock transitions are requested to be resent to the
> >   primary via EAGAIN, doubling the latency.
> >
> > Get rid of global osd_req_flags and set read_from_replica flag
> > only on specific OSD requests instead.
> >
> > Fixes: 8ad44d5e0d1e ("libceph: read_from_replica option")
>
> Since this isn't yet in mainline, can't you simply merge these two
> patches?

Hi Luis,

The pull request has already been put together and I'd rather not
rebase.

>
> > Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
> > ---
> >  drivers/block/rbd.c          |  4 +++-
> >  include/linux/ceph/libceph.h |  4 ++--
> >  net/ceph/ceph_common.c       | 14 ++++++--------
> >  net/ceph/osd_client.c        |  3 +--
> >  4 files changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> > index e02089d550a4..b2bb2f10562a 100644
> > --- a/drivers/block/rbd.c
> > +++ b/drivers/block/rbd.c
> > @@ -1451,8 +1451,10 @@ static void rbd_osd_req_callback(struct ceph_osd_request *osd_req)
> >  static void rbd_osd_format_read(struct ceph_osd_request *osd_req)
> >  {
> >       struct rbd_obj_request *obj_request = osd_req->r_priv;
> > +     struct rbd_device *rbd_dev = obj_request->img_request->rbd_dev;
> > +     struct ceph_options *opt = rbd_dev->rbd_client->client->options;
> >
> > -     osd_req->r_flags = CEPH_OSD_FLAG_READ;
> > +     osd_req->r_flags = CEPH_OSD_FLAG_READ | opt->read_from_replica;
> >       osd_req->r_snapid = obj_request->img_request->snap_id;
> >  }
> >
> > diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
> > index 2247e71beb83..e5ed1c541e7f 100644
> > --- a/include/linux/ceph/libceph.h
> > +++ b/include/linux/ceph/libceph.h
> > @@ -52,8 +52,7 @@ struct ceph_options {
> >       unsigned long osd_idle_ttl;             /* jiffies */
> >       unsigned long osd_keepalive_timeout;    /* jiffies */
> >       unsigned long osd_request_timeout;      /* jiffies */
> > -
> > -     u32 osd_req_flags;  /* CEPH_OSD_FLAG_*, applied to each OSD request */
> > +     u32 read_from_replica;  /* CEPH_OSD_FLAG_BALANCE/LOCALIZE_READS */
> >
> >       /*
> >        * any type that can't be simply compared or doesn't need
> > @@ -76,6 +75,7 @@ struct ceph_options {
> >  #define CEPH_OSD_KEEPALIVE_DEFAULT   msecs_to_jiffies(5 * 1000)
> >  #define CEPH_OSD_IDLE_TTL_DEFAULT    msecs_to_jiffies(60 * 1000)
> >  #define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT 0  /* no timeout */
> > +#define CEPH_READ_FROM_REPLICA_DEFAULT       0  /* read from primary */
> >
> >  #define CEPH_MONC_HUNT_INTERVAL              msecs_to_jiffies(3 * 1000)
> >  #define CEPH_MONC_PING_INTERVAL              msecs_to_jiffies(10 * 1000)
> > diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
> > index 9bab3e9a039b..b7705e91ae9a 100644
> > --- a/net/ceph/ceph_common.c
> > +++ b/net/ceph/ceph_common.c
> > @@ -333,6 +333,7 @@ struct ceph_options *ceph_alloc_options(void)
> >       opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT;
> >       opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;
> >       opt->osd_request_timeout = CEPH_OSD_REQUEST_TIMEOUT_DEFAULT;
> > +     opt->read_from_replica = CEPH_READ_FROM_REPLICA_DEFAULT;
> >       return opt;
> >  }
> >  EXPORT_SYMBOL(ceph_alloc_options);
> > @@ -491,16 +492,13 @@ int ceph_parse_param(struct fs_parameter *param, struct ceph_options *opt,
> >       case Opt_read_from_replica:
> >               switch (result.uint_32) {
> >               case Opt_read_from_replica_no:
> > -                     opt->osd_req_flags &= ~(CEPH_OSD_FLAG_BALANCE_READS |
> > -                                             CEPH_OSD_FLAG_LOCALIZE_READS);
> > +                     opt->read_from_replica = 0;
>
> CEPH_READ_FROM_REPLICA_DEFAULT?

No.  If the default changes, read_from_replica=no should still mean
"don't go to the replica, use the primary".

Thanks,

                Ilya
