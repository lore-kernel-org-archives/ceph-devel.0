From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v5 2/6] libceph: abort already submitted but abortable
 requests when map or pool goes full
Date: Wed, 29 Mar 2017 18:52:08 +0200
Message-ID: <CAOi1vP8VTDK4Z91OrDCqA7cYPm9PkNZ613jAvo4h3gQcLA1Z4g@mail.gmail.com>
References: <20170225174323.20289-1-jlayton@redhat.com> <20170225174323.20289-3-jlayton@redhat.com>
 <CAOi1vP-Y2y7ikVEA9sgsZWBx3KnPpWPUNg1ZPKQfPVcQ+vdQGg@mail.gmail.com> <1490733863.24656.9.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34169 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752333AbdC2QwK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Mar 2017 12:52:10 -0400
Received: by mail-vk0-f65.google.com with SMTP id y16so3059459vky.1
        for <ceph-devel@vger.kernel.org>; Wed, 29 Mar 2017 09:52:09 -0700 (PDT)
In-Reply-To: <1490733863.24656.9.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Mar 28, 2017 at 10:44 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Tue, 2017-03-28 at 16:34 +0200, Ilya Dryomov wrote:
>> On Sat, Feb 25, 2017 at 6:43 PM, Jeff Layton <jlayton@redhat.com> wrote:
>> > When a Ceph volume hits capacity, a flag is set in the OSD map to
>> > indicate that, and a new map is sprayed around the cluster. With cephfs
>> > we want it to shut down any abortable requests that are in progress with
>> > an -ENOSPC error as they'd just hang otherwise.
>> >
>> > Add a new ceph_osdc_abort_on_full helper function to handle this. It
>> > will first check whether there is an out-of-space condition in the
>> > cluster. It will then walk the tree and abort any request that has
>> > r_abort_on_full set with an ENOSPC error. Call this new function
>> > directly whenever we get a new OSD map.
>> >
>> > Signed-off-by: Jeff Layton <jlayton@redhat.com>
>> > ---
>> >  net/ceph/osd_client.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>> >  1 file changed, 42 insertions(+)
>> >
>> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> > index 8fc0ccc7126f..b286ff6dec29 100644
>> > --- a/net/ceph/osd_client.c
>> > +++ b/net/ceph/osd_client.c
>> > @@ -1770,6 +1770,47 @@ static void complete_request(struct ceph_osd_request *req, int err)
>> >         ceph_osdc_put_request(req);
>> >  }
>> >
>> > +/*
>> > + * Drop all pending requests that are stalled waiting on a full condition to
>> > + * clear, and complete them with ENOSPC as the return code.
>> > + */
>> > +static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
>> > +{
>> > +       struct ceph_osd_request *req;
>> > +       struct ceph_osd *osd;
>>
>> These variables could have narrower scope.
>>
>> > +       struct rb_node *m, *n;
>> > +       u32 latest_epoch = 0;
>> > +       bool osdmap_full = ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL);
>>
>> This variable is redundant.
>>
>> > +
>> > +       dout("enter abort_on_full\n");
>> > +
>> > +       if (!osdmap_full && !have_pool_full(osdc))
>> > +               goto out;
>> > +
>> > +       for (n = rb_first(&osdc->osds); n; n = rb_next(n)) {
>> > +               osd = rb_entry(n, struct ceph_osd, o_node);
>> > +               mutex_lock(&osd->lock);
>>
>> No need to take osd->lock here as osdc->lock is held for write.
>>
>
> Could you explain how this locking works?
>
> It appeared to me that o_requests was protected by osd->lock based on
> when link_request is called in __submit_request. If the osdc->lock is
> sufficient, then why take the osd->lock before grabbing the tid and
> linking it into the tree?

osd->lock protects the individual ceph_osd trees and is always taken
along with osdc->lock.  osdc->lock is the per-ceph_osd_client -- if you
have it down for write, osd->lock becomes unnecessary.

__submit_request() is called with osdc->lock down for read.

>
>> > +               m = rb_first(&osd->o_requests);
>> > +               while (m) {
>> > +                       req = rb_entry(m, struct ceph_osd_request, r_node);
>> > +                       m = rb_next(m);
>> > +
>> > +                       if (req->r_abort_on_full &&
>> > +                           (osdmap_full || pool_full(osdc, req->r_t.base_oloc.pool))) {
>>
>> Over 80 lines and I think we need target_oloc instead of base_oloc
>> here.
>>
>> > +                               u32 cur_epoch = le32_to_cpu(req->r_replay_version.epoch);
>>
>> Is replay_version used this way in the userspace client?  It is an ack
>> vs commit leftover and AFAICT it is never set (i.e. always 0'0) in newer
>> Objecter, so something is wrong here.
>>
>> > +
>> > +                               dout("%s: abort tid=%llu flags 0x%x\n", __func__, req->r_tid, req->r_flags);
>>
>> Over 80 lines and probably unnecessary -- complete_request() has
>> a similar dout.
>>
>> > +                               complete_request(req, -ENOSPC);
>>
>> This should be abort_request() (newly introduced in 4.11).
>>
>
> Fixed most of the above, but could you explain this bit?
>
> abort_request() just calls cancel_map_check() and then does a
> complete_request(). Why do we want to cancel the map check here?

Because the request in question could be in the map check tree.
ceph_osdc_abort_on_full() is asynchronous with respect to the rest of
request processing code, much like the recently merged timeout stuff.

complete_request() is for handle_reply() and map check code itself.

Thanks,

                Ilya
