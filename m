From: Ning Yao <zay11022@gmail.com>
Subject: Re: [ceph-users] why not add (offset,len) to pglog
Date: Fri, 22 Jan 2016 19:40:21 +0800
Message-ID: <CALZt5jyzHBcUftq1YGkfW7+dXNA9MPFT3vKF9LDwkdpmZucX-g@mail.gmail.com>
References: <CAAL-TMddLQ-fxNnPcZZhtd8Evk6j+h6PiNTu+KapyPsRCeW9bw@mail.gmail.com>
	<CANE=7sUenL8oO_8CWP_VJJ_qWPWM2pLF6UxpFb-9AGFePT46oA@mail.gmail.com>
	<CAAL-TMcndHOViDmearR5zb+XyEbvRnaV2ur-AMavfzvyDK=r6w@mail.gmail.com>
	<CALZt5jxXuT7W+quYy5C-dDaXvFQ=+PV=35DbvY3D33NR1xX25A@mail.gmail.com>
	<alpine.DEB.2.00.1512250622060.10312@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35319 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752763AbcAVLkW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jan 2016 06:40:22 -0500
Received: by mail-wm0-f42.google.com with SMTP id r129so209642387wmr.0
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jan 2016 03:40:21 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1512250622060.10312@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Dong Wu <archer.wudong@gmail.com>, =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>, =?UTF-8?B?5aea5a6BKOeglOWFrSDnpo/lt54p?= <yaoning@ruijie.com.cn>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Great! Based on Sage's suggestion, we just add a flag
can_recover_partial to indicate whether.
And I promote a new PR for this https://github.com/ceph/ceph/pull/7325
Please review and comment
Regards
Ning Yao


2015-12-25 22:27 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Fri, 25 Dec 2015, Ning Yao wrote:
>> Hi, Dong Wu,
>>
>> 1. As I currently work for other things, this proposal is abandon for
>> a long time
>> 2. This is a complicated task as we need to consider a lots such as
>> (not just for writeOp, as well as truncate, delete) and also need to
>> consider the different affects for different backends(Replicated, EC).
>> 3. I don't think it is good time to redo this patch now, since the
>> BlueStore and Kstore  is inprogress, and I'm afraid to bring some
>> side-effect.  We may prepare and propose the whole design in next CDS.
>> 4. Currently, we already have some tricks to deal with recovery (like
>> throttle the max recovery op, set the priority for recovery and so
>> on). So this kind of patch may not solve the critical problem but just
>> make things better, and I am not quite sure that this will really
>> bring a big improvement. Based on my previous test, it works
>> excellently on slow disk (say hdd), and also for a short-time
>> maintaining. Otherwise, it will trigger the backfill process.  So wait
>> for Sage's opinion @sage
>>
>> If you are interest on this, we may cooperate to do this.
>
> I think it's a great idea.  We didn't do it before only because it is
> complicated.  The good news is that if we can't conclusively infer exactly
> which parts of hte object need to be recovered from the log entry we can
> always just fall back to recovering the whole thing.  Also, the place
> where this is currently most visible is RBD small writes:
>
>  - osd goes down
>  - client sends a 4k overwrite and modifies an object
>  - osd comes back up
>  - client sends another 4k overwrite
>  - client io blocks while osd recovers 4mb
>
> So even if we initially ignore truncate and omap and EC and clones and
> anything else complicated I suspect we'll get a nice benefit.
>
> I haven't thought about this too much, but my guess is that the hard part
> is making the primary's missing set representation include a partial delta
> (say, an interval_set<> indicating which ranges of the file have changed)
> in a way that gracefully degrades to recovering the whole object if we're
> not sure.
>
> In any case, we should definitely have the design conversation!
>
> sage
>
>>
>> Regards
>> Ning Yao
>>
>>
>> 2015-12-25 14:23 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
>> > Thanks, from this pull request I learned that this issue is not
>> > completed, is there any new progress of this issue?
>> >
>> > 2015-12-25 12:30 GMT+08:00 Xinze Chi (??) <xmdxcxz@gmail.com>:
>> >> Yeah, This is good idea for recovery, but not for backfill.
>> >> @YaoNing have pull a request about this
>> >> https://github.com/ceph/ceph/pull/3837 this year.
>> >>
>> >> 2015-12-25 11:16 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
>> >>> Hi,
>> >>> I have doubt about pglog, the pglog contains (op,object,version) etc.
>> >>> when peering, use pglog to construct missing list,then recover the
>> >>> whole object in missing list even if different data among replicas is
>> >>> less then a whole object data(eg,4MB).
>> >>> why not add (offset,len) to pglog? If so, the missing list can contain
>> >>> (object, offset, len), then we can reduce recover data.
>> >>> _______________________________________________
>> >>> ceph-users mailing list
>> >>> ceph-users@lists.ceph.com
>> >>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>> >>
>> >>
>> >>
>> >> --
>> >> Regards,
>> >> Xinze Chi
>> > _______________________________________________
>> > ceph-users mailing list
>> > ceph-users@lists.ceph.com
>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
