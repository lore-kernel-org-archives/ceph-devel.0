From: GuangYang <yguang11@outlook.com>
Subject: RE: radosgw - stuck ops
Date: Tue, 4 Aug 2015 15:23:42 -0700
Message-ID: <BLU175-W473A2D4104E37342497CC2DF760@phx.gbl>
References: <BLU175-W48D8E409F917C02492E3C4DF760@phx.gbl>,<CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>,<alpine.DEB.2.00.1508040950540.22099@cobra.newdream.net>,<CADRKj5QG2Qfbh9z9RghW2=JoSvzXcctUjTjDUXg4F_vw9mM2yw@mail.gmail.com>,<alpine.DEB.2.00.1508041000490.22099@cobra.newdream.net>,<CADRKj5Qfffrc3zSaaT+fKV6LpD+Z_p4SfE3z9KHEyXTRPn1s2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from blu004-omc1s24.hotmail.com ([65.55.116.35]:50072 "EHLO
	BLU004-OMC1S24.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750829AbbHDWXn convert rfc822-to-8bit
	(ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 4 Aug 2015 18:23:43 -0400
In-Reply-To: <CADRKj5Qfffrc3zSaaT+fKV6LpD+Z_p4SfE3z9KHEyXTRPn1s2A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>, Weil Sage <sweil@redhat.com>
Cc: "Just, Samuel" <sjust@redhat.com>, Sadeh-Weinraub Yehuda <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks for Sage, Yehuda and Sam's quick reply.

Given the discussion so far, could I summarize into the following bulle=
t points:

1> The first step we would like to pursue is to implement the following=
 mechanism to avoid infinite waiting at radosgw side:
=A0 =A0 =A0 1.1. radosgw - send OP with a *fast_fail* flag
=A0 =A0 =A0 1.2. OSD - reply with -EAGAIN if the PG is *inactive* and t=
he *fast_fail* flag is set
=A0 =A0 =A0 1.3. radosgw - upon receiving -EAGAIN, retry till a timeout=
 interval is reached (properly with some back-off?), and if it eventual=
ly fails, convert -EAGAIN to some other error code and passes to upper =
layer.

2> In terms of management of radosgw's worker threads, I think we eithe=
r pursue Sage's proposal (which could linearly increase the time it tak=
es to stuck all worker threads depending how many threads we expand), o=
r simply try sharding work queue (which we already has some basic build=
ing block)?

Can I start working on patch for <1> and then <2> as a lower priority?

Thanks,
Guang
----------------------------------------
> Date: Tue, 4 Aug 2015 10:14:06 -0700
> Subject: Re: radosgw - stuck ops
> From: ysadehwe@redhat.com
> To: sweil@redhat.com
> CC: yguang11@outlook.com; sjust@redhat.com; yehuda@redhat.com; ceph-d=
evel@vger.kernel.org
>
> On Tue, Aug 4, 2015 at 10:03 AM, Sage Weil <sweil@redhat.com> wrote:
>> On Tue, 4 Aug 2015, Yehuda Sadeh-Weinraub wrote:
>>> On Tue, Aug 4, 2015 at 9:55 AM, Sage Weil <sweil@redhat.com> wrote:
>>>>> One solution that I can think of is to determine before the read/=
write
>>>>> whether the pg we're about to access is healthy (or has been unhe=
althy for a
>>>>> short period of time), and if not to cancel the request before se=
nding the
>>>>> operation. This could mitigate the problem you're seeing at the e=
xpense of
>>>>> availability in some cases. We'd need to have a way to query pg h=
ealth
>>>>> through librados which we don't have right now afaik.
>>>>> Sage / Sam, does that make sense, and/or possible?
>>>>
>>>> This seems mostly impossible because we don't know ahead of time w=
hich
>>>> PG(s) a request is going to touch (it'll generally be a lot of the=
m)?
>>>>
>>>
>>> Barring pgls() and such, each rados request that radosgw produces w=
ill
>>> only touch a single pg, right?
>>
>> Oh, yeah. I thought you meant before each RGW request. If it's at th=
e
>> rados level then yeah, you could avoid stuck pgs, although I think a
>> better approach would be to make the OSD reply with -EAGAIN in that =
case
>> so that you know the op didn't happen. There would still be cases (t=
hough
>> more rare) where you weren't sure if the op happened or not (e.g., w=
hen
>> you send to osd A, it goes down, you resend to osd B, and then you g=
et
>> EAGAIN/timeout).
>
> If done on the client side then we should only make it apply to the
> first request sent. Is it actually a problem if the osd triggered the
> error?
>
>>
>> What would you do when you get that failure/timeout, though? Is it
>> practical to abort the rgw request handling completely?
>>
>
> It should be like any error that happens through the transaction
> (e.g., client disconnection).
>
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at http://vger.kernel.org/majordomo-info.html
 		 	   		  --
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
