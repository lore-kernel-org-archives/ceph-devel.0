From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v5 3/6] libceph: add an epoch_barrier field to struct
 ceph_osd_client
Date: Wed, 29 Mar 2017 13:43:57 -0400
Message-ID: <1490809437.2678.4.camel@redhat.com>
References: <20170225174323.20289-1-jlayton@redhat.com>
         <20170225174323.20289-4-jlayton@redhat.com>
         <CAOi1vP-xgoxnbgve3uOfiSRN1vESh-e+jFp1QyvPTa_DXE2R2Q@mail.gmail.com>
         <1490788473.2332.1.camel@redhat.com>
         <CAOi1vP-xyGZxTidnOAwTt=agOFrQxP6wUUyFDQFbdUtcyBjY4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35835 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932437AbdC2RoD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Mar 2017 13:44:03 -0400
Received: by mail-qt0-f173.google.com with SMTP id x35so19116712qtc.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 10:44:02 -0700 (PDT)
In-Reply-To: <CAOi1vP-xyGZxTidnOAwTt=agOFrQxP6wUUyFDQFbdUtcyBjY4w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 2017-03-29 at 18:52 +0200, Ilya Dryomov wrote:
> On Wed, Mar 29, 2017 at 1:54 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > On Tue, 2017-03-28 at 16:54 +0200, Ilya Dryomov wrote:
> > > On Sat, Feb 25, 2017 at 6:43 PM, Jeff Layton <jlayton@redhat.com> wrote:
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
> > > > If we end up cancelling requests because of a new map showing a full OSD
> > > > or pool condition, then set the barrier higher than the highest replay
> > > > epoch of all the cancelled requests.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > > ---
> > > >  include/linux/ceph/osd_client.h |  2 ++
> > > >  net/ceph/osd_client.c           | 51 +++++++++++++++++++++++++++++++++--------
> > > >  2 files changed, 43 insertions(+), 10 deletions(-)
> > > > 
> > > > diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> > > > index 55dcff2455e0..833942226560 100644
> > > > --- a/include/linux/ceph/osd_client.h
> > > > +++ b/include/linux/ceph/osd_client.h
> > > > @@ -266,6 +266,7 @@ struct ceph_osd_client {
> > > >         struct rb_root         osds;          /* osds */
> > > >         struct list_head       osd_lru;       /* idle osds */
> > > >         spinlock_t             osd_lru_lock;
> > > > +       u32                    epoch_barrier;
> > > 
> > > It would be good to include it in debugfs -- osdmap_show().
> > > 
> > 
> > Ok, I'll plan to add it in there.
> > 
> > > >         struct ceph_osd        homeless_osd;
> > > >         atomic64_t             last_tid;      /* tid of last request */
> > > >         u64                    last_linger_id;
> > > > @@ -304,6 +305,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_client *osdc,
> > > >                                    struct ceph_msg *msg);
> > > >  extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
> > > >                                  struct ceph_msg *msg);
> > > > +void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb);
> > > > 
> > > >  extern void osd_req_op_init(struct ceph_osd_request *osd_req,
> > > >                             unsigned int which, u16 opcode, u32 flags);
> > > > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > > > index b286ff6dec29..2e9b6211814a 100644
> > > > --- a/net/ceph/osd_client.c
> > > > +++ b/net/ceph/osd_client.c
> > > > @@ -1299,8 +1299,10 @@ static bool target_should_be_paused(struct ceph_osd_client *osdc,
> > > >                        __pool_full(pi);
> > > > 
> > > >         WARN_ON(pi->id != t->base_oloc.pool);
> > > > -       return (t->flags & CEPH_OSD_FLAG_READ && pauserd) ||
> > > > -              (t->flags & CEPH_OSD_FLAG_WRITE && pausewr);
> > > > +       return ((t->flags & CEPH_OSD_FLAG_READ) && pauserd) ||
> > > > +              ((t->flags & CEPH_OSD_FLAG_WRITE) && pausewr) ||
> > > > +              (osdc->epoch_barrier &&
> > > > +               osdc->osdmap->epoch < osdc->epoch_barrier);
> > > 
> > > Why the osdc->epoch_barrier != 0 check, here and everywhere else?
> > > 
> > 
> > My understanding is that we have to deal with clusters that predate the
> > addition of this value. The client sets this to 0 when it's not set.
> 
> That and initialization to 0 in ceph_create_client(), so how does this
> != 0 check affect anything?  Won't we always return false in that case,
> thus preserving the old behavior?
> 
> > 
> > > >  }
> > > > 
> > > >  enum calc_target_result {
> > > > @@ -1610,21 +1612,24 @@ static void send_request(struct ceph_osd_request *req)
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
> > > > +           (osdc->epoch_barrier && epoch < osdc->epoch_barrier)) {
> > > >                 dout("%s osdc %p continuous\n", __func__, osdc);
> > > >                 continuous = true;
> > > >         } else {
> > > >                 dout("%s osdc %p onetime\n", __func__, osdc);
> > > >         }
> > > > 
> > > > +       ++epoch;
> > > >         if (ceph_monc_want_map(&osdc->client->monc, CEPH_SUB_OSDMAP,
> > > > -                              osdc->osdmap->epoch + 1, continuous))
> > > > +                              epoch, continuous))
> > > >                 ceph_monc_renew_subs(&osdc->client->monc);
> > > >  }
> > > 
> > > Why was this change needed?  Wouldn't the existing call to unmodified
> > > maybe_request_map() from ceph_osdc_handle_map() be sufficient?
> > > 
> > 
> > It's not strictly required, but it's more efficient to fetch the epoch
> > at the beginning of the function like this and then work with it the
> > value on the stack than to potentially deal with having to refetch it.
> > It also looks cleaner.
> 
> It was more about the if condition change.  I don't see a reason for it
> and it's not present in the Objecter counterpart, so I'd rather we drop
> the entire hunk.
> 

To be clear, there is no functional difference here.

epoch == osdc->osdmap->epoch, and we don't use "epoch" after that
point. I'll leave the code as-is per your wish, but I don't think it
makes any substantive difference here.
-- 
Jeff Layton <jlayton@redhat.com>
