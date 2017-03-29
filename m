From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v5 2/6] libceph: abort already submitted but abortable
 requests when map or pool goes full
Date: Wed, 29 Mar 2017 10:01:33 -0400
Message-ID: <1490796093.2332.3.camel@redhat.com>
References: <20170225174323.20289-1-jlayton@redhat.com>
         <20170225174323.20289-3-jlayton@redhat.com>
         <CAOi1vP-Y2y7ikVEA9sgsZWBx3KnPpWPUNg1ZPKQfPVcQ+vdQGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f179.google.com ([209.85.220.179]:36290 "EHLO
        mail-qk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbdC2OBj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Mar 2017 10:01:39 -0400
Received: by mail-qk0-f179.google.com with SMTP id p22so13401846qka.3
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 07:01:38 -0700 (PDT)
In-Reply-To: <CAOi1vP-Y2y7ikVEA9sgsZWBx3KnPpWPUNg1ZPKQfPVcQ+vdQGg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 2017-03-28 at 16:34 +0200, Ilya Dryomov wrote:
> On Sat, Feb 25, 2017 at 6:43 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > When a Ceph volume hits capacity, a flag is set in the OSD map to
> > indicate that, and a new map is sprayed around the cluster. With cephfs
> > we want it to shut down any abortable requests that are in progress with
> > an -ENOSPC error as they'd just hang otherwise.
> > 
> > Add a new ceph_osdc_abort_on_full helper function to handle this. It
> > will first check whether there is an out-of-space condition in the
> > cluster. It will then walk the tree and abort any request that has
> > r_abort_on_full set with an ENOSPC error. Call this new function
> > directly whenever we get a new OSD map.
> > 
> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > ---
> >  net/ceph/osd_client.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 8fc0ccc7126f..b286ff6dec29 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -1770,6 +1770,47 @@ static void complete_request(struct ceph_osd_request *req, int err)
> >         ceph_osdc_put_request(req);
> >  }
> > 
> > +/*
> > + * Drop all pending requests that are stalled waiting on a full condition to
> > + * clear, and complete them with ENOSPC as the return code.
> > + */
> > +static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
> > +{
> > +       struct ceph_osd_request *req;
> > +       struct ceph_osd *osd;
> 
> These variables could have narrower scope.
> 
> > +       struct rb_node *m, *n;
> > +       u32 latest_epoch = 0;
> > +       bool osdmap_full = ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL);
> 
> This variable is redundant.
> 
> > +
> > +       dout("enter abort_on_full\n");
> > +
> > +       if (!osdmap_full && !have_pool_full(osdc))
> > +               goto out;
> > +
> > +       for (n = rb_first(&osdc->osds); n; n = rb_next(n)) {
> > +               osd = rb_entry(n, struct ceph_osd, o_node);
> > +               mutex_lock(&osd->lock);
> 
> No need to take osd->lock here as osdc->lock is held for write.
> 
> > +               m = rb_first(&osd->o_requests);
> > +               while (m) {
> > +                       req = rb_entry(m, struct ceph_osd_request, r_node);
> > +                       m = rb_next(m);
> > +
> > +                       if (req->r_abort_on_full &&
> > +                           (osdmap_full || pool_full(osdc, req->r_t.base_oloc.pool))) {
> 
> Over 80 lines and I think we need target_oloc instead of base_oloc
> here.
> 
> > +                               u32 cur_epoch = le32_to_cpu(req->r_replay_version.epoch);
> 
> Is replay_version used this way in the userspace client?  It is an ack
> vs commit leftover and AFAICT it is never set (i.e. always 0'0) in newer
> Objecter, so something is wrong here.
> 

Yeah I see what you mean now. This does look to be entirely vestigial
in the current code.

Basically, what we want is to scan the list of outstanding requests for
this OSD, and abort any that predate the current map epoch. I suppose
this means that we need to record the current map epoch in the request
somewhere. ISTR looking and seeing that it was recorded here, but I
don't think that's the case anymore.

Since that field is never set to anything now, what I'll probably do is
just remove it, and replace it with an epoch field that we record at
the time that the request is marshaled.

> > +
> > +                               dout("%s: abort tid=%llu flags 0x%x\n", __func__, req->r_tid, req->r_flags);
> 
> Over 80 lines and probably unnecessary -- complete_request() has
> a similar dout.
> 
> > +                               complete_request(req, -ENOSPC);
> 
> This should be abort_request() (newly introduced in 4.11).
> 
> > +                               if (cur_epoch > latest_epoch)
> > +                                       latest_epoch = cur_epoch;
> > +                       }
> > +               }
> > +               mutex_unlock(&osd->lock);
> > +       }
> > +out:
> > +       dout("return abort_on_full latest_epoch=%u\n", latest_epoch);
> > +}
> > +
> >  static void cancel_map_check(struct ceph_osd_request *req)
> >  {
> >         struct ceph_osd_client *osdc = req->r_osdc;
> > @@ -3232,6 +3273,7 @@ void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
> > 
> >         ceph_monc_got_map(&osdc->client->monc, CEPH_SUB_OSDMAP,
> >                           osdc->osdmap->epoch);
> > +       ceph_osdc_abort_on_full(osdc);
> 
> Nit: swap ceph_osdc_abort_on_full() and ceph_monc_got_map() so that
> ceph_osdc_abort_on_full() follows kick_requests().  No real reason
> other than for "I processed this map" notification to go last, after
> the map is fully processed.
> 
> Thanks,
> 
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Jeff Layton <jlayton@redhat.com>
