From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: radosgw - stuck ops
Date: Tue, 4 Aug 2015 10:14:30 -0700
Message-ID: <CADRKj5TPV-OVzx3vPcL7a_c9+UcPqJyU4DC3DaDL_gBHbWd_iw@mail.gmail.com>
References: <BLU175-W48D8E409F917C02492E3C4DF760@phx.gbl>
	<CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>
	<BLU175-W4225FE328848A260F90305DF760@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:34662 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753428AbbHDROb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 13:14:31 -0400
Received: by obre1 with SMTP id e1so12200838obr.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 10:14:30 -0700 (PDT)
In-Reply-To: <BLU175-W4225FE328848A260F90305DF760@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: Weil Sage <sweil@redhat.com>, "Just, Samuel" <sjust@redhat.com>, Sadeh-Weinraub Yehuda <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 4, 2015 at 9:48 AM, GuangYang <yguang11@outlook.com> wrote:
> Hi Yehuda,
> Thanks for the quick response. My comments inline..
>
> Thanks,
> Guang
> ________________________________
>> Date: Tue, 4 Aug 2015 08:41:26 -0700
>> Subject: Re: radosgw - stuck ops
>> From: ysadehwe@redhat.com
>> To: yguang11@outlook.com; sweil@redhat.com; sjust@redhat.com
>> CC: yehuda@redhat.com; ceph-devel@vger.kernel.org
>>
>>
>>
>> On Mon, Aug 3, 2015 at 6:53 PM, GuangYang
>> <yguang11@outlook.com<mailto:yguang11@outlook.com>> wrote:
>> Hi Yehuda,
>> Recently with our pre-production clusters (with radosgw), we had an
>> outage that all radosgw worker threads got stuck and all clients
>> request resulted in 500 because that there is no worker thread taking
>> care of them.
>>
>> What we observed from the cluster, is that there was a PG stuck at
>> *peering* state, as a result, all requests hitting that PG would occupy
>> a worker thread infinitely and that gradually stuck all workers.
>>
>> The reason why the PG stuck at peering is still under investigation,
>> but radosgw side, I am wondering if we can pursue anything to improve
>> such use case (to be more specific, 1 out of 8192 PGs' issue cascading
>> to a service unavailable across the entire cluster):
>>
>> 1. The first approach I can think of is to add timeout at objecter
>> layer for each OP to OSD, I think the complexity comes with WRITE, that
>> is, how do we make sure the integrity if we abort at objecter layer.
>> But for immutable op, I think we certainly can do this, since at an
>> upper layer, we already reply back to client with an error.
>> 2. Do thread pool/working queue sharding at radosgw, in which case,
>> partial failure would (hopefully) only impact partial of worker threads
>> and only cause a partial outage.
>>
>>
>> The problem with timeouts is that they are racy and can bring the
>> system into inconsistent state. For example, an operation takes too
>> long, rgw gets a timeout, but the operation actually completes on the
>> osd. So rgw returns with an error, removes the tail and does not
>> complete the write, whereas in practice the new head was already
>> written and points at the newly removed tail. The index would still
>> show as if the old version of the object was still there. I'm sure we
>> can come up with some more scenarios that I'm not sure we could resolve
>> easily.
> Right, that is my concern as well, we will need to come up with a mechanism to
> preserve integrity, like for each write, it should be all or nothing, not partial, though
> we already reply to client with a 500 error.
> But that is the problem we properly need to deal with anyway, for example, in our
> cluster, each time we detect this kind of availability issue, we will need to restart
> all radosgw daemons to bring it back, which has the possibility to leave some
> inconsistent state.

It's a different kind of inconsistency, one that we're built to recover from.

> I am thinking it might make sense to start with *immutable* requests, for example,
> bucket listing, object get/head, etc. We can timeout as long as we timeout with client.
> That should be much easier to implement and solve part of the problem.
>> The problem with sharding is that for large enough objects they could
>> end up writing to any pg, so I'm not sure how effective that would be.
> Not sure of other use cases with radosgw across the community, but for us, at
> time being, 95%tile of the objects are stored with one chunk, so that should be
> effective for this kind of work load, but yeah we should consider to support more
> general use cases. As a bottom line, that should not make things worse.

Yeah, the idea is to get the general case working.

>> One solution that I can think of is to determine before the read/write
>> whether the pg we're about to access is healthy (or has been unhealthy
>> for a short period of time), and if not to cancel the request before
>> sending the operation. This could mitigate the problem you're seeing at
>> the expense of availability in some cases. We'd need to have a way to
>> query pg health through librados which we don't have right now afaik.
> That sounds good. The only complexity I can think of is for large objects
> which has several chunks, we will need to deal with the write issue as well, since each chunk
> might assign to different PGs?

For larger objects, in theory we can get it to retry a write using
different prefix. Not sure how easy it would be to implement, and
won't work with reads obviously.

Yehuda
