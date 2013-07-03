From: Milosz Tanski <milosz@adfin.com>
Subject: Re: [PATCH 1/3] libceph: call r_unsafe_callback when unsafe reply is received
Date: Wed, 3 Jul 2013 18:07:45 -0400
Message-ID: <CANP1eJFe+d-UM4vSOSLiFP07NrbXGUeD1TNaXusSLrEo8HEXTQ@mail.gmail.com>
References: <1372056089-11603-1-git-send-email-zheng.z.yan@intel.com>
	<51D12FA7.1090605@intel.com>
	<alpine.DEB.2.00.1307011245410.11177@cobra.newdream.net>
	<alpine.DEB.2.00.1307031455220.3375@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:58888 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932486Ab3GCWHq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Jul 2013 18:07:46 -0400
Received: by mail-ie0-f179.google.com with SMTP id c10so1799871ieb.10
        for <ceph-devel@vger.kernel.org>; Wed, 03 Jul 2013 15:07:45 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1307031455220.3375@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, alex.elder@linaro.org, Sage Weil <sage@inktank.com>

Yan,

Can you help me understand how this change fixes:
http://tracker.ceph.com/issues/2019 ? The symptom on the client is
that the processes get stuck waiting in ceph_mdsc_do_request according
to /proc/PID/stack.

Thanks in advance,
- Milosz

On Wed, Jul 3, 2013 at 5:57 PM, Sage Weil <sage@inktank.com> wrote:
> Hi Yan-
>
> On Mon, 1 Jul 2013, Sage Weil wrote:
>> On Mon, 1 Jul 2013, Yan, Zheng wrote:
>> > ping
>> >
>> > I think this patch should goes into 3.11 or fix the issue by other means
>>
>> Applied this to the testing branch, thanks.  Let me know if there are any
>> others I missed!
>
> This broke rbd, which was using the unsafe callback. I pushed a patch to
> simplify that (testing-next^); care to take a look?
>
> Thanks!
> sage
>
>
>>
>> sage
>>
>> >
>> >
>> > On 06/24/2013 02:41 PM, Yan, Zheng wrote:
>> > > From: "Yan, Zheng" <zheng.z.yan@intel.com>
>> > >
>> > > We can't use !req->r_sent to check if OSD request is sent for the
>> > > first time, this is because __cancel_request() zeros req->r_sent
>> > > when OSD map changes. Rather than adding a new variable to struct
>> > > ceph_osd_request to indicate if it's sent for the first time, We
>> > > can call the unsafe callback only when unsafe OSD reply is received.
>> > > If OSD's first reply is safe, just skip calling the unsafe callback.
>> > >
>> > > The purpose of unsafe callback is adding unsafe request to a list,
>> > > so that fsync(2) can wait for the safe reply. fsync(2) doesn't need
>> > > to wait for a write(2) that hasn't returned yet. So it's OK to add
>> > > request to the unsafe list when the first OSD reply is received.
>> > > (ceph_sync_write() returns after receiving the first OSD reply)
>> > >
>> > > Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
>> > > ---
>> > >  net/ceph/osd_client.c | 14 +++++++-------
>> > >  1 file changed, 7 insertions(+), 7 deletions(-)
>> > >
>> > > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> > > index 540dd29..dd47889 100644
>> > > --- a/net/ceph/osd_client.c
>> > > +++ b/net/ceph/osd_client.c
>> > > @@ -1337,10 +1337,6 @@ static void __send_request(struct ceph_osd_client *osdc,
>> > >
>> > >   ceph_msg_get(req->r_request); /* send consumes a ref */
>> > >
>> > > - /* Mark the request unsafe if this is the first timet's being sent. */
>> > > -
>> > > - if (!req->r_sent && req->r_unsafe_callback)
>> > > -         req->r_unsafe_callback(req, true);
>> > >   req->r_sent = req->r_osd->o_incarnation;
>> > >
>> > >   ceph_con_send(&req->r_osd->o_con, req->r_request);
>> > > @@ -1431,8 +1427,6 @@ static void handle_osds_timeout(struct work_struct *work)
>> > >
>> > >  static void complete_request(struct ceph_osd_request *req)
>> > >  {
>> > > - if (req->r_unsafe_callback)
>> > > -         req->r_unsafe_callback(req, false);
>> > >   complete_all(&req->r_safe_completion);  /* fsync waiter */
>> > >  }
>> > >
>> > > @@ -1559,14 +1553,20 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
>> > >   mutex_unlock(&osdc->request_mutex);
>> > >
>> > >   if (!already_completed) {
>> > > +         if (req->r_unsafe_callback &&
>> > > +             result >= 0 && !(flags & CEPH_OSD_FLAG_ONDISK))
>> > > +                 req->r_unsafe_callback(req, true);
>> > >           if (req->r_callback)
>> > >                   req->r_callback(req, msg);
>> > >           else
>> > >                   complete_all(&req->r_completion);
>> > >   }
>> > >
>> > > - if (flags & CEPH_OSD_FLAG_ONDISK)
>> > > + if (flags & CEPH_OSD_FLAG_ONDISK) {
>> > > +         if (req->r_unsafe_callback && already_completed)
>> > > +                 req->r_unsafe_callback(req, false);
>> > >           complete_request(req);
>> > > + }
>> > >
>> > >  done:
>> > >   dout("req=%p req->r_linger=%d\n", req, req->r_linger);
>> > >
>> >
>> >
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
