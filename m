From: Ric Wheeler <rwheeler@redhat.com>
Subject: Re: New Defects reported by Coverity Scan for ceph (fwd)
Date: Tue, 30 Sep 2014 13:41:46 -0400
Message-ID: <542AEB5A.9070804@redhat.com>
References: <alpine.DEB.2.00.1409300658510.6593@cobra.newdream.net> <CAPYLRzj3mMCcMsAXC0CM7g6z7ZwUty4_E74ymy3-p5kWXd8i1w@mail.gmail.com> <alpine.DEB.2.00.1409301037300.17090@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:23496 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752848AbaI3Rmw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 30 Sep 2014 13:42:52 -0400
In-Reply-To: <alpine.DEB.2.00.1409301037300.17090@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <greg@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Jeff Darcy <jdarcy@redhat.com>, Kaleb Keithley <kaleb@redhat.com>

On 09/30/2014 01:38 PM, Sage Weil wrote:
> On Tue, 30 Sep 2014, Gregory Farnum wrote:
>> On Tue, Sep 30, 2014 at 6:59 AM, Sage Weil <sweil@redhat.com> wrote:
>>> Looks like recent changes from Greg, Loic, and I.
>>>
>>> ---------- Forwarded message ----------
>>> From: scan-admin@coverity.com
>>> To: undisclosed-recipients:;
>>> Cc:
>>> Date: Tue, 30 Sep 2014 06:21:08 -0700
>>> Subject: New Defects reported by Coverity Scan for ceph
>>>
>>>
>>> Hi,
>>>
>>>
>>> Please find the latest report on new defect(s) introduced to ceph found with Coverity Scan.
>>>
>>> Defect(s) Reported-by: Coverity Scan
>>> Showing 4 of 4 defect(s)
>>>
>>>
>>> ** CID 1242019:  Data race condition  (MISSING_LOCK)
>>> /msg/Pipe.cc: 230 in Pipe::DelayedDelivery::entry()()
>>>
>>> ** CID 1242021:  Resource leak  (RESOURCE_LEAK)
>>> /test/librados/tier.cc: 1026 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
>>> /test/librados/tier.cc: 1022 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
>>> /test/librados/tier.cc: 1040 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
>>> /test/librados/tier.cc: 1037 in LibRadosTwoPoolsPP_EvictSnap2_Test::TestBody()()
>>>
>>> ** CID 1242020:  Resource leak  (RESOURCE_LEAK)
>>> /test/librados/aio.cc: 168 in LibRadosAio_TooBig_Test::TestBody()()
>>>
>>> ** CID 1242018:  Resource leak  (RESOURCE_LEAK)
>>> /test/librados/aio.cc: 188 in LibRadosAio_TooBigPP_Test::TestBody()()
>>> /test/librados/aio.cc: 190 in LibRadosAio_TooBigPP_Test::TestBody()()
>>> /test/librados/aio.cc: 187 in LibRadosAio_TooBigPP_Test::TestBody()()
>>>
>>>
>>> ________________________________________________________________________________________________________
>>> *** CID 1242019:  Data race condition  (MISSING_LOCK)
>>> /msg/Pipe.cc: 230 in Pipe::DelayedDelivery::entry()()
>>> 224         if (flush_count > 0) {
>>> 225           --flush_count;
>>> 226           active_flush = true;
>>> 227         }
>>> 228         if (pipe->in_q->can_fast_dispatch(m)) {
>>> 229           if (!stop_fast_dispatching_flag) {
>>>>>>      CID 1242019:  Data race condition  (MISSING_LOCK)
>>>>>>      Accessing "this->delay_dispatching" without holding lock "Mutex._m". Elsewhere, "_ZN4Pipe15DelayedDeliveryE.delay_dispatching" is accessed with "Mutex._m" held 1 out of 2 times (1 of these accesses strongly imply that it is necessary).
>>> 230             delay_dispatching = true;
>>> 231             delay_lock.Unlock();
>>> 232             pipe->in_q->fast_dispatch(m);
>>> 233             delay_lock.Lock();
>>> 234             delay_dispatching = false;
>>> 235             if (stop_fast_dispatching_flag) {
>> This one's a false positive. (delay_dispatching is protected by the
>> delay_lock, but I think it's picking up on the Pipe::lock which is
>> held when DelayedDelivery is constructed and initialized.) Is there a
>> way I should annotate this, or is it something we need to adjust in
>> the Coverity web interface?
> There are annotations but I don't know how they work.  I've been marking
> them through the web interface...
>
> sage
>

Jeff and Kaleb (last I remember) had more expertise in coverity magic - they 
might know how to annotate those false positives...

ric

