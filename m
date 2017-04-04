From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v6 4/7] libceph: add an epoch_barrier field to struct
 ceph_osd_client
Date: Tue, 04 Apr 2017 17:12:10 -0400
Message-ID: <1491340330.11822.3.camel@redhat.com>
References: <20170330180546.11021-1-jlayton@redhat.com>
         <20170330180707.11137-1-jlayton@redhat.com>
         <20170330180707.11137-4-jlayton@redhat.com>
         <CAOi1vP-ReH9vVktm=ZhegLouhrxV0qYy=mgt6tYGhUZ=p11i=g@mail.gmail.com>
         <1491323678.309.3.camel@redhat.com>
         <CAOi1vP_mk7XojSNu7Jmp1uW7RvfrhN+Y=94xUD1D6z8S1stmkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:35860 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752231AbdDDVMO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Apr 2017 17:12:14 -0400
Received: by mail-qk0-f182.google.com with SMTP id p22so153269876qka.3
        for <ceph-devel@vger.kernel.org>; Tue, 04 Apr 2017 14:12:14 -0700 (PDT)
In-Reply-To: <CAOi1vP_mk7XojSNu7Jmp1uW7RvfrhN+Y=94xUD1D6z8S1stmkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 2017-04-04 at 21:47 +0200, Ilya Dryomov wrote:
> On Tue, Apr 4, 2017 at 6:34 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > On Tue, 2017-04-04 at 17:00 +0200, Ilya Dryomov wrote:
> > > On Thu, Mar 30, 2017 at 8:07 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > > > Cephfs can get cap update requests that contain a new epoch barrier in
> > > > them. When that happens we want to pause all OSD traffic until the right
> > > > map epoch arrives.
> > > > 
> > > > Add an epoch_barrier field to ceph_osd_client that is protected by the
> > > > osdc->lock rwsem. When the barrier is set, and the current OSD map
> > > > epoch is below that, pause the request target when submitting the
> > > > request or when revisiting it. Add a way for upper layers (cephfs)
> > > > to update the epoch_barrier as well.
> > > > 
> > > > If we get a new map, compare the new epoch against the barrier before
> > > > kicking requests and request another map if the map epoch is still lower
> > > > than the one we want.
> > > > 
> > > > If we get a map with a full pool, or at quota condition, then set the
> > > > barrier to the current epoch value.
> > > > 
> > > > Reviewed-by: "Yan, Zheng” <zyan@redhat.com>
> > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > > ---
> > > >  include/linux/ceph/osd_client.h |  2 ++
> > > >  net/ceph/debugfs.c              |  3 ++-
> > > >  net/ceph/osd_client.c           | 48 +++++++++++++++++++++++++++++++++--------
> > > >  3 files changed, 43 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> > > > index 8cf644197b1a..85650b415e73 100644
> > > > --- a/include/linux/ceph/osd_client.h
> > > > +++ b/include/linux/ceph/osd_client.h
> > > > @@ -267,6 +267,7 @@ struct ceph_osd_client {
> > > >         struct rb_root         osds;          /* osds */
> > > >         struct list_head       osd_lru;       /* idle osds */
> > > >         spinlock_t             osd_lru_lock;
> > > > +       u32                    epoch_barrier;
> > > >         struct ceph_osd        homeless_osd;
> > > >         atomic64_t             last_tid;      /* tid of last request */
> > > >         u64                    last_linger_id;
> > > > @@ -305,6 +306,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_client *osdc,
> > > >                                    struct ceph_msg *msg);
> > > >  extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
> > > >                                  struct ceph_msg *msg);
> > > > +void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb);
> > > > 
> > > >  extern void osd_req_op_init(struct ceph_osd_request *osd_req,
> > > >                             unsigned int which, u16 opcode, u32 flags);
> > > > diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> > > > index d7e63a4f5578..71ba13927b3d 100644
> > > > --- a/net/ceph/debugfs.c
> > > > +++ b/net/ceph/debugfs.c
> > > > @@ -62,7 +62,8 @@ static int osdmap_show(struct seq_file *s, void *p)
> > > >                 return 0;
> > > > 
> > > >         down_read(&osdc->lock);
> > > > -       seq_printf(s, "epoch %d flags 0x%x\n", map->epoch, map->flags);
> > > > +       seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
> > > > +                       osdc->epoch_barrier, map->flags);
> > > > 
> > > >         for (n = rb_first(&map->pg_pools); n; n = rb_next(n)) {
> > > >                 struct ceph_pg_pool_info *pi =
> > > > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > > > index 4e56cd1ec265..3a94e8a1c7ff 100644
> > > > --- a/net/ceph/osd_client.c
> > > > +++ b/net/ceph/osd_client.c
> > > > @@ -1298,8 +1298,9 @@ static bool target_should_be_paused(struct ceph_osd_client *osdc,
> > > >                        __pool_full(pi);
> > > > 
> > > >         WARN_ON(pi->id != t->base_oloc.pool);
> > > > -       return (t->flags & CEPH_OSD_FLAG_READ && pauserd) ||
> > > > -              (t->flags & CEPH_OSD_FLAG_WRITE && pausewr);
> > > > +       return ((t->flags & CEPH_OSD_FLAG_READ) && pauserd) ||
> > > > +              ((t->flags & CEPH_OSD_FLAG_WRITE) && pausewr) ||
> > > > +              (osdc->osdmap->epoch < osdc->epoch_barrier);
> > > >  }
> > > > 
> > > >  enum calc_target_result {
> > > > @@ -1609,13 +1610,15 @@ static void send_request(struct ceph_osd_request *req)
> > > >  static void maybe_request_map(struct ceph_osd_client *osdc)
> > > >  {
> > > >         bool continuous = false;
> > > > +       u32 epoch = osdc->osdmap->epoch;
> > > > 
> > > >         verify_osdc_locked(osdc);
> > > > -       WARN_ON(!osdc->osdmap->epoch);
> > > > +       WARN_ON_ONCE(epoch == 0);
> > > > 
> > > >         if (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
> > > >             ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD) ||
> > > > -           ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
> > > > +           ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
> > > > +           epoch < osdc->epoch_barrier) {
> > > >                 dout("%s osdc %p continuous\n", __func__, osdc);
> > > >                 continuous = true;
> > > >         } else {
> > > 
> > > Looks like this hunk is smaller now, but I thought we agreed to drop it
> > > entirely?  "epoch < osdc->epoch_barrier" isn't there in Objecter.
> > > 
> > 
> > I still think if the current map is behind the current barrier value,
> > then you really do want to request a map. I'm not sure that the other
> > flags will necessarily be set in that case, will they?
> 
> We do that from ceph_osdc_handle_map(), on every new map.  That should
> be good enough -- I'm not sure if that continuous sub in FULL, PAUSERD
> and PAUSEWR cases buys us anything at all.
> 

Ahh ok, I see what you're saying now. Fair enough, we probably don't
need a continuous sub to handle an epoch_barrier that we don't have the
map for yet.

That said...should maybe_request_map be calling ceph_monc_want_map with
  this as the epoch argument? 

     max(epoch+1, osdc->epoch_barrier)

It seems like if the barrier is more than one greater than the one we
currently have then we should request enough to get us to the barrier.

Thoughts? 
-- 
Jeff Layton <jlayton@redhat.com>
