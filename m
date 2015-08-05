From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: radosgw - stuck ops
Date: Wed, 5 Aug 2015 07:44:34 -0700
Message-ID: <CADRKj5TZT7_=v-mec_td0KAPba0r4D58fBZ_UxeuKweE3mO2+g@mail.gmail.com>
References: <BLU175-W48D8E409F917C02492E3C4DF760@phx.gbl>
	<CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>
	<alpine.DEB.2.00.1508040950540.22099@cobra.newdream.net>
	<CADRKj5QG2Qfbh9z9RghW2=JoSvzXcctUjTjDUXg4F_vw9mM2yw@mail.gmail.com>
	<alpine.DEB.2.00.1508041000490.22099@cobra.newdream.net>
	<CADRKj5Qfffrc3zSaaT+fKV6LpD+Z_p4SfE3z9KHEyXTRPn1s2A@mail.gmail.com>
	<BLU175-W473A2D4104E37342497CC2DF760@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oi0-f44.google.com ([209.85.218.44]:36662 "EHLO
	mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339AbbHEOof convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Aug 2015 10:44:35 -0400
Received: by oigu206 with SMTP id u206so10511056oig.3
        for <ceph-devel@vger.kernel.org>; Wed, 05 Aug 2015 07:44:34 -0700 (PDT)
In-Reply-To: <BLU175-W473A2D4104E37342497CC2DF760@phx.gbl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: GuangYang <yguang11@outlook.com>
Cc: Weil Sage <sweil@redhat.com>, "Just, Samuel" <sjust@redhat.com>, Sadeh-Weinraub Yehuda <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 4, 2015 at 3:23 PM, GuangYang <yguang11@outlook.com> wrote:
> Thanks for Sage, Yehuda and Sam's quick reply.
>
> Given the discussion so far, could I summarize into the following bullet points:
>
> 1> The first step we would like to pursue is to implement the following mechanism to avoid infinite waiting at radosgw side:
>       1.1. radosgw - send OP with a *fast_fail* flag
>       1.2. OSD - reply with -EAGAIN if the PG is *inactive* and the *fast_fail* flag is set
>       1.3. radosgw - upon receiving -EAGAIN, retry till a timeout interval is reached (properly with some back-off?), and if it eventually fails, convert -EAGAIN to some other error code and passes to upper layer.

I'm not crazy about the 'fast_fail' name, maybe we can come up with a
better describing term. Also, not 100% sure the EAGAIN is the error we
want to see. Maybe the flag on the request could specify what would be
the error code to return in this case?
I think it's a good plan to start with, we can adjust things later.

>
> 2> In terms of management of radosgw's worker threads, I think we either pursue Sage's proposal (which could linearly increase the time it takes to stuck all worker threads depending how many threads we expand), or simply try sharding work queue (which we already has some basic building block)?

The problem that I see with that proposal (missed it earlier, only
seeing it now), is that when the threads actually wake up the system
could become unusable. In any case, it's probably a lower priority at
this point, we could rethink this area again later.

Yehuda

>
> Can I start working on patch for <1> and then <2> as a lower priority?
>
> Thanks,
> Guang
> ----------------------------------------
>> Date: Tue, 4 Aug 2015 10:14:06 -0700
>> Subject: Re: radosgw - stuck ops
>> From: ysadehwe@redhat.com
>> To: sweil@redhat.com
>> CC: yguang11@outlook.com; sjust@redhat.com; yehuda@redhat.com; ceph-devel@vger.kernel.org
>>
>> On Tue, Aug 4, 2015 at 10:03 AM, Sage Weil <sweil@redhat.com> wrote:
>>> On Tue, 4 Aug 2015, Yehuda Sadeh-Weinraub wrote:
>>>> On Tue, Aug 4, 2015 at 9:55 AM, Sage Weil <sweil@redhat.com> wrote:
>>>>>> One solution that I can think of is to determine before the read/write
>>>>>> whether the pg we're about to access is healthy (or has been unhealthy for a
>>>>>> short period of time), and if not to cancel the request before sending the
>>>>>> operation. This could mitigate the problem you're seeing at the expense of
>>>>>> availability in some cases. We'd need to have a way to query pg health
>>>>>> through librados which we don't have right now afaik.
>>>>>> Sage / Sam, does that make sense, and/or possible?
>>>>>
>>>>> This seems mostly impossible because we don't know ahead of time which
>>>>> PG(s) a request is going to touch (it'll generally be a lot of them)?
>>>>>
>>>>
>>>> Barring pgls() and such, each rados request that radosgw produces will
>>>> only touch a single pg, right?
>>>
>>> Oh, yeah. I thought you meant before each RGW request. If it's at the
>>> rados level then yeah, you could avoid stuck pgs, although I think a
>>> better approach would be to make the OSD reply with -EAGAIN in that case
>>> so that you know the op didn't happen. There would still be cases (though
>>> more rare) where you weren't sure if the op happened or not (e.g., when
>>> you send to osd A, it goes down, you resend to osd B, and then you get
>>> EAGAIN/timeout).
>>
>> If done on the client side then we should only make it apply to the
>> first request sent. Is it actually a problem if the osd triggered the
>> error?
>>
>>>
>>> What would you do when you get that failure/timeout, though? Is it
>>> practical to abort the rgw request handling completely?
>>>
>>
>> It should be like any error that happens through the transaction
>> (e.g., client disconnection).
>>
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>
