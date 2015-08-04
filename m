From: Samuel Just <sjust@redhat.com>
Subject: Re: radosgw - stuck ops
Date: Tue, 4 Aug 2015 09:42:51 -0700
Message-ID: <CAN=+7FVRSKsJw7fK43XoT9-SesxVv_fpBsBiyRuLV9BW5ag7Dw@mail.gmail.com>
References: <BLU175-W48D8E409F917C02492E3C4DF760@phx.gbl>
	<CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38762 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbbHDQmw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 12:42:52 -0400
Received: by iggf3 with SMTP id f3so15126370igg.1
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 09:42:52 -0700 (PDT)
In-Reply-To: <CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Cc: GuangYang <yguang11@outlook.com>, "Weil, Sage" <sweil@redhat.com>, Sadeh-Weinraub Yehuda <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

What if instead the request had a marker that would cause the OSD to
reply with EAGAIN if the pg is unhealthy?
-Sam

On Tue, Aug 4, 2015 at 8:41 AM, Yehuda Sadeh-Weinraub
<ysadehwe@redhat.com> wrote:
>
>
> On Mon, Aug 3, 2015 at 6:53 PM, GuangYang <yguang11@outlook.com> wrote:
>>
>> Hi Yehuda,
>> Recently with our pre-production clusters (with radosgw), we had an outage
>> that all radosgw worker threads got stuck and all clients request resulted
>> in 500 because that there is no worker thread taking care of them.
>>
>> What we observed from the cluster, is that there was a PG stuck at
>> *peering* state, as a result, all requests hitting that PG would occupy a
>> worker thread infinitely and that gradually stuck all workers.
>>
>> The reason why the PG stuck at peering is still under investigation, but
>> radosgw side, I am wondering if we can pursue anything to improve such use
>> case (to be more specific, 1 out of 8192 PGs' issue cascading to a service
>> unavailable across the entire cluster):
>>
>> 1. The first approach I can think of is to add timeout at objecter layer
>> for each OP to OSD, I think the complexity comes with WRITE, that is, how do
>> we make sure the integrity if we abort at objecter layer. But for immutable
>> op, I think we certainly can do this, since at an upper layer, we already
>> reply back to client with an error.
>> 2. Do thread pool/working queue sharding  at radosgw, in which case,
>> partial failure would (hopefully) only impact partial of worker threads and
>> only cause a partial outage.
>>
>
> The problem with timeouts is that they are racy and can bring the system
> into inconsistent state. For example, an operation takes too long, rgw gets
> a timeout, but the operation actually completes on the osd. So rgw returns
> with an error, removes the tail and does not complete the write, whereas in
> practice the new head was already written and points at the newly removed
> tail. The index would still show as if the old version of the object was
> still there. I'm sure we can come up with some more scenarios that I'm not
> sure we could resolve easily.
> The problem with sharding is that for large enough objects they could end up
> writing to any pg, so I'm not sure how effective that would be.
> One solution that I can think of is to determine before the read/write
> whether the pg we're about to access is healthy (or has been unhealthy for a
> short period of time), and if not to cancel the request before sending the
> operation. This could mitigate the problem you're seeing at the expense of
> availability in some cases. We'd need to have a way to query pg health
> through librados which we don't have right now afaik.
> Sage / Sam, does that make sense, and/or possible?
>
> Yehuda
