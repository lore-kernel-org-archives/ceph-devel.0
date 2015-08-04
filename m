From: Yehuda Sadeh-Weinraub <ysadehwe@redhat.com>
Subject: Re: radosgw - stuck ops
Date: Tue, 4 Aug 2015 10:14:06 -0700
Message-ID: <CADRKj5Qfffrc3zSaaT+fKV6LpD+Z_p4SfE3z9KHEyXTRPn1s2A@mail.gmail.com>
References: <BLU175-W48D8E409F917C02492E3C4DF760@phx.gbl>
	<CADRKj5SadChvVbVmVx18SFKfAeXWKiGmLB4Xybkqn3xXxoxnyg@mail.gmail.com>
	<alpine.DEB.2.00.1508040950540.22099@cobra.newdream.net>
	<CADRKj5QG2Qfbh9z9RghW2=JoSvzXcctUjTjDUXg4F_vw9mM2yw@mail.gmail.com>
	<alpine.DEB.2.00.1508041000490.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:33609 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbbHDROI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Aug 2015 13:14:08 -0400
Received: by obdeg2 with SMTP id eg2so12177129obd.0
        for <ceph-devel@vger.kernel.org>; Tue, 04 Aug 2015 10:14:06 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508041000490.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: GuangYang <yguang11@outlook.com>, "Just, Samuel" <sjust@redhat.com>, Sadeh-Weinraub Yehuda <yehuda@redhat.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Aug 4, 2015 at 10:03 AM, Sage Weil <sweil@redhat.com> wrote:
> On Tue, 4 Aug 2015, Yehuda Sadeh-Weinraub wrote:
>> On Tue, Aug 4, 2015 at 9:55 AM, Sage Weil <sweil@redhat.com> wrote:
>> >> One solution that I can think of is to determine before the read/write
>> >> whether the pg we're about to access is healthy (or has been unhealthy for a
>> >> short period of time), and if not to cancel the request before sending the
>> >> operation. This could mitigate the problem you're seeing at the expense of
>> >> availability in some cases. We'd need to have a way to query pg health
>> >> through librados which we don't have right now afaik.
>> >> Sage / Sam, does that make sense, and/or possible?
>> >
>> > This seems mostly impossible because we don't know ahead of time which
>> > PG(s) a request is going to touch (it'll generally be a lot of them)?
>> >
>>
>> Barring pgls() and such, each rados request that radosgw produces will
>> only touch a single pg, right?
>
> Oh, yeah.  I thought you meant before each RGW request.  If it's at the
> rados level then yeah, you could avoid stuck pgs, although I think a
> better approach would be to make the OSD reply with -EAGAIN in that case
> so that you know the op didn't happen.  There would still be cases (though
> more rare) where you weren't sure if the op happened or not (e.g., when
> you send to osd A, it goes down, you resend to osd B, and then you get
> EAGAIN/timeout).

If done on the client side then we should only make it apply to the
first request sent. Is it actually a problem if the osd triggered the
error?

>
> What would you do when you get that failure/timeout, though?  Is it
> practical to abort the rgw request handling completely?
>

It should be like any error that happens through the transaction
(e.g., client disconnection).

Yehuda
