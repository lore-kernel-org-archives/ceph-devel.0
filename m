From: Gregory Farnum <greg@inktank.com>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 30 Sep 2014 10:36:41 -0700
Message-ID: <CAPYLRzj3mMCcMsAXC0CM7g6z7ZwUty4_E74ymy3-p5kWXd8i1w@mail.gmail.com>
References: <alpine.DEB.2.00.1409300658510.6593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f42.google.com ([209.85.216.42]:63601 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbaI3Rgm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Sep 2014 13:36:42 -0400
Received: by mail-qa0-f42.google.com with SMTP id j7so2418342qaq.1
        for <ceph-devel@vger.kernel.org>; Tue, 30 Sep 2014 10:36:41 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409300658510.6593@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Sep 30, 2014 at 6:59 AM, Sage Weil <sweil@redhat.com> wrote:
> Looks like recent changes from Greg, Loic, and I.
>
> ---------- Forwarded message ----------
> From: scan-admin@coverity.com
> To: undisclosed-recipients:;
> Cc:
> Date: Tue, 30 Sep 2014 06:21:08 -0700
> Subject: New Defects reported by Coverity Scan for ceph
>
>
> Hi,
>
>
> Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.
>
> Defect(s) Reported-by: Coverity Scan
> Showing 4 of 4 defect(s)
>
>
> ** CID 1242019:  Data race condition  (MISSING_LOCK)
> /msg/Pipe.cc: 230 in Pipe::DelayedDelivery::entry()()
>
> ** CID 1242021:  Resource leak  (RESOURCE_LEAK)
> /test/librados/tier.cc: 1026 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
> /test/librados/tier.cc: 1022 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
> /test/librados/tier.cc: 1040 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
> /test/librados/tier.cc: 1037 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
>
> ** CID 1242020:  Resource leak  (RESOURCE_LEAK)
> /test/librados/aio.cc: 168 in LibRadosAio_TooBig_Test::TestBody()()
>
> ** CID 1242018:  Resource leak  (RESOURCE_LEAK)
> /test/librados/aio.cc: 188 in LibRadosAio_TooBigPP_Test::TestBody()()
> /test/librados/aio.cc: 190 in LibRadosAio_TooBigPP_Test::TestBody()()
> /test/librados/aio.cc: 187 in LibRadosAio_TooBigPP_Test::TestBody()()
>
>
> ________________________________________________________________________________________________________
> *** CID 1242019:  Data race condition  (MISSING_LOCK)
> /msg/Pipe.cc: 230 in Pipe::DelayedDelivery::entry()()
> 224         if (flush_count > 0) {
> 225           --flush_count;
> 226           active_flush = true;
> 227         }
> 228         if (pipe->in_q->can_fast_dispatch(m)) {
> 229           if (!stop_fast_dispatching_flag) {
>>>>     CID 1242019:  Data race condition  (MISSING_LOCK)
>>>>     Accessing "this->delay_dispatching" without holding lock "Mutex._m". Elsewhere, "_ZN4Pipe15DelayedDeliveryE.delay_dispatching" is accessed with "Mutex._m" held 1 out of 2 times (1 of these accesses strongly imply that it is necessary).
> 230             delay_dispatching = true;
> 231             delay_lock.Unlock();
> 232             pipe->in_q->fast_dispatch(m);
> 233             delay_lock.Lock();
> 234             delay_dispatching = false;
> 235             if (stop_fast_dispatching_flag) {

This one's a false positive. (delay_dispatching is protected by the
delay_lock, but I think it's picking up on the Pipe::lock which is
held when DelayedDelivery is constructed and initialized.) Is there a
way I should annotate this, or is it something we need to adjust in
the Coverity web interface?
-Greg
