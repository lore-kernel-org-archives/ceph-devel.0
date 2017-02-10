From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v4 2/6] libceph: abort already submitted but abortable
 requests when map or pool goes full
Date: Fri, 10 Feb 2017 13:59:41 +0100
Message-ID: <CAOi1vP_6jYb2x+EjUjL7OCsy050VaSecyUtUWNsOh+=Z7+x+Ew@mail.gmail.com>
References: <20170209144836.12525-1-jlayton@redhat.com> <20170209144836.12525-3-jlayton@redhat.com>
 <285D1D56-D4CD-4B4F-BF51-F915560F28C2@redhat.com> <1486728422.4233.10.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33276 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751555AbdBJRRE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2017 12:17:04 -0500
Received: by mail-vk0-f66.google.com with SMTP id t8so3135028vke.0
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 09:17:04 -0800 (PST)
In-Reply-To: <1486728422.4233.10.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>

On Fri, Feb 10, 2017 at 1:07 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Fri, 2017-02-10 at 20:01 +0800, Yan, Zheng wrote:
>> > On 9 Feb 2017, at 22:48, Jeff Layton <jlayton@redhat.com> wrote:
>> >
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
>> > net/ceph/osd_client.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>> > 1 file changed, 42 insertions(+)
>> >
>> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> > index f68bb42da240..cdb0b58c4c99 100644
>> > --- a/net/ceph/osd_client.c
>> > +++ b/net/ceph/osd_client.c
>> > @@ -1777,6 +1777,47 @@ static void complete_request(struct ceph_osd_request *req, int err)
>> >     ceph_osdc_put_request(req);
>> > }
>> >
>> > +/*
>> > + * Drop all pending requests that are stalled waiting on a full condition to
>> > + * clear, and complete them with ENOSPC as the return code.
>> > + */
>> > +static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
>> > +{
>> > +   struct ceph_osd_request *req;
>> > +   struct ceph_osd *osd;
>> > +   struct rb_node *m, *n;
>> > +   u32 latest_epoch = 0;
>> > +   bool osdmap_full = ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL);
>> > +
>> > +   dout("enter abort_on_full\n");
>> > +
>> > +   if (!osdmap_full && !have_pool_full(osdc))
>> > +           goto out;
>> > +
>> > +   for (n = rb_first(&osdc->osds); n; n = rb_next(n)) {
>> > +           osd = rb_entry(n, struct ceph_osd, o_node);
>> > +           mutex_lock(&osd->lock);
>> > +           m = rb_first(&osd->o_requests);
>> > +           while (m) {
>> > +                   req = rb_entry(m, struct ceph_osd_request, r_node);
>> > +                   m = rb_next(m);
>> > +
>>
>> For requests that have already got unsafe reply, we should ignore them or call req->r_unsafe_callback() to clean them up
>>
>>
>> Regards
>> Yan, Zheng
>
> Ok, yeah. I had to stare at the r_unsafe_callback code a bit the other
> day to handle the ERROR_WRITE flag and what you say makes sense.
>
> Honestly what we really need is a function like complete_request that
> hides all of these fiddly details about the request state. Maybe it
> would be simpler to just have complete_request handle the case where
> we've gotten an unsafe reply as well?
>
> I'll see what I can come up with there.

This is exactly what I meant in my reply to Artur yesterday.  Note that
ceph_osdc_cancel_request() is explicit about not completing the request.
It shouldn't be hard to mend it though -- let me look into it.

Thanks,

                Ilya
