From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v5 2/6] libceph: abort already submitted but abortable
 requests when map or pool goes full
Date: Wed, 29 Mar 2017 12:39:32 -0400
Message-ID: <1490805572.2678.2.camel@redhat.com>
References: <20170225174323.20289-1-jlayton@redhat.com>
         <20170225174323.20289-3-jlayton@redhat.com>
         <CAOi1vP-Y2y7ikVEA9sgsZWBx3KnPpWPUNg1ZPKQfPVcQ+vdQGg@mail.gmail.com>
         <1490796093.2332.3.camel@redhat.com>
         <CAOi1vP9io-UMO-a5PSeqocQ_X2nkMkCJFdifN=BtVoam8AkCxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f179.google.com ([209.85.216.179]:35214 "EHLO
        mail-qt0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753167AbdC2Qjh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Mar 2017 12:39:37 -0400
Received: by mail-qt0-f179.google.com with SMTP id x35so17514765qtc.2
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 09:39:36 -0700 (PDT)
In-Reply-To: <CAOi1vP9io-UMO-a5PSeqocQ_X2nkMkCJFdifN=BtVoam8AkCxw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 2017-03-29 at 16:14 +0200, Ilya Dryomov wrote:
> On Wed, Mar 29, 2017 at 4:01 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > On Tue, 2017-03-28 at 16:34 +0200, Ilya Dryomov wrote:
> > > On Sat, Feb 25, 2017 at 6:43 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > > > When a Ceph volume hits capacity, a flag is set in the OSD map to
> > > > indicate that, and a new map is sprayed around the cluster. With cephfs
> > > > we want it to shut down any abortable requests that are in progress with
> > > > an -ENOSPC error as they'd just hang otherwise.
> > > > 
> > > > Add a new ceph_osdc_abort_on_full helper function to handle this. It
> > > > will first check whether there is an out-of-space condition in the
> > > > cluster. It will then walk the tree and abort any request that has
> > > > r_abort_on_full set with an ENOSPC error. Call this new function
> > > > directly whenever we get a new OSD map.
> > > > 
> > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > > ---
> > > >  net/ceph/osd_client.c | 42 ++++++++++++++++++++++++++++++++++++++++++
> > > >  1 file changed, 42 insertions(+)
> > > > 
> > > > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > > > index 8fc0ccc7126f..b286ff6dec29 100644
> > > > --- a/net/ceph/osd_client.c
> > > > +++ b/net/ceph/osd_client.c
> > > > @@ -1770,6 +1770,47 @@ static void complete_request(struct ceph_osd_request *req, int err)
> > > >         ceph_osdc_put_request(req);
> > > >  }
> > > > 
> > > > +/*
> > > > + * Drop all pending requests that are stalled waiting on a full condition to
> > > > + * clear, and complete them with ENOSPC as the return code.
> > > > + */
> > > > +static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
> > > > +{
> > > > +       struct ceph_osd_request *req;
> > > > +       struct ceph_osd *osd;
> > > 
> > > These variables could have narrower scope.
> > > 
> > > > +       struct rb_node *m, *n;
> > > > +       u32 latest_epoch = 0;
> > > > +       bool osdmap_full = ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL);
> > > 
> > > This variable is redundant.
> > > 
> > > > +
> > > > +       dout("enter abort_on_full\n");
> > > > +
> > > > +       if (!osdmap_full && !have_pool_full(osdc))
> > > > +               goto out;
> > > > +
> > > > +       for (n = rb_first(&osdc->osds); n; n = rb_next(n)) {
> > > > +               osd = rb_entry(n, struct ceph_osd, o_node);
> > > > +               mutex_lock(&osd->lock);
> > > 
> > > No need to take osd->lock here as osdc->lock is held for write.
> > > 
> > > > +               m = rb_first(&osd->o_requests);
> > > > +               while (m) {
> > > > +                       req = rb_entry(m, struct ceph_osd_request, r_node);
> > > > +                       m = rb_next(m);
> > > > +
> > > > +                       if (req->r_abort_on_full &&
> > > > +                           (osdmap_full || pool_full(osdc, req->r_t.base_oloc.pool))) {
> > > 
> > > Over 80 lines and I think we need target_oloc instead of base_oloc
> > > here.
> > > 
> > > > +                               u32 cur_epoch = le32_to_cpu(req->r_replay_version.epoch);
> > > 
> > > Is replay_version used this way in the userspace client?  It is an ack
> > > vs commit leftover and AFAICT it is never set (i.e. always 0'0) in newer
> > > Objecter, so something is wrong here.
> > > 
> > 
> > Yeah I see what you mean now. This does look to be entirely vestigial
> > in the current code.
> > 
> > Basically, what we want is to scan the list of outstanding requests for
> > this OSD, and abort any that predate the current map epoch. I suppose
> > this means that we need to record the current map epoch in the request
> > somewhere. ISTR looking and seeing that it was recorded here, but I
> > don't think that's the case anymore.
> 
> Why only those that predate the current epoch and not simply all of
> those marked as r_abort_on_full?  I mean, this is triggered by a pool
> or an entire cluster going full, right?
> 
> 

My mistake, you're right. We cancel based on r_abort_on_full and the
pool/OSD full flags.

We do need to determine the latest cancelled map epoch though, so that
we can update the epoch_barrier properly when this occurs. What I'm
doing now is just recording the current map epoch before we link a
request into the tree and using that to determine this.
-- 
Jeff Layton <jlayton@redhat.com>
