From: Dong Wu <archer.wudong@gmail.com>
Subject: Re: [ceph-users] why not add (offset,len) to pglog
Date: Mon, 14 Mar 2016 15:23:31 +0800
Message-ID: <CAAL-TMfCM+dPqfn+KPQXzYgdwkH9TdYgdt3A-oZ_jWxoiO4PDA@mail.gmail.com>
References: <CAAL-TMddLQ-fxNnPcZZhtd8Evk6j+h6PiNTu+KapyPsRCeW9bw@mail.gmail.com>
	<CANE=7sUenL8oO_8CWP_VJJ_qWPWM2pLF6UxpFb-9AGFePT46oA@mail.gmail.com>
	<CAAL-TMcndHOViDmearR5zb+XyEbvRnaV2ur-AMavfzvyDK=r6w@mail.gmail.com>
	<CALZt5jxXuT7W+quYy5C-dDaXvFQ=+PV=35DbvY3D33NR1xX25A@mail.gmail.com>
	<alpine.DEB.2.00.1512250622060.10312@cobra.newdream.net>
	<CALZt5jyzHBcUftq1YGkfW7+dXNA9MPFT3vKF9LDwkdpmZucX-g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:34180 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755018AbcCNHXc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Mar 2016 03:23:32 -0400
Received: by mail-vk0-f53.google.com with SMTP id e185so198016035vkb.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Mar 2016 00:23:32 -0700 (PDT)
In-Reply-To: <CALZt5jyzHBcUftq1YGkfW7+dXNA9MPFT3vKF9LDwkdpmZucX-g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: Sage Weil <sage@newdream.net>, =?UTF-8?B?WGluemUgQ2hpICjkv6Hms70p?= <xmdxcxz@gmail.com>, =?UTF-8?B?5aea5a6BKOeglOWFrSDnpo/lt54p?= <yaoning@ruijie.com.cn>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

Based on Yao Ning's PR, I promote a new PR for this
https://github.com/ceph/ceph/pull/8083

In this PR, i also solved such a upgrade situation problem:
consider such a upgrade situation which we need to upgrade to this
can_recover_partial version:
eg. a pg 3.67 [0, 1, 2]
1)firstly, we update osd.0(service ceph restart osd.0), and recover
normally, everything goes on;
2)a write req(eg. req1, will write to obj1) is sent to primary(osd.0),
and pglog record such a req;
3)then we update osd.1, req1 send to osd.1 fail, but will send to
osd.2, when osd.2 is dealing with the req(just in function
do_request), pg3.67 starts peering, then on osd.7, it call
can_discard_request to check that req1 should be dropped;
4)so the req1 only write successfuly on osd.0, because min_size=2,
osd.0 re-enqueue the req1;
5)when peering, primary find that req1's object obj1 is missing on
osd.1 and osd.2, so recover the object;
6)because osd.0 and osd.1 is already updated, osd.0 will calculate
partial data in prep_push_to_replica, and osd.1 can deal with the
partial data very well,
7)but osd.2 has not been updated, on osd.2's code
logic(submit_push_data), it will remove origin object first, then
write the partial data from osd.0, so the origin data of the object is
lost;

2016-01-22 19:40 GMT+08:00 Ning Yao <zay11022@gmail.com>:
> Great! Based on Sage's suggestion, we just add a flag
> can_recover_partial to indicate whether.
> And I promote a new PR for this https://github.com/ceph/ceph/pull/7325
> Please review and comment
> Regards
> Ning Yao
>
>
> 2015-12-25 22:27 GMT+08:00 Sage Weil <sage@newdream.net>:
>> On Fri, 25 Dec 2015, Ning Yao wrote:
>>> Hi, Dong Wu,
>>>
>>> 1. As I currently work for other things, this proposal is abandon for
>>> a long time
>>> 2. This is a complicated task as we need to consider a lots such as
>>> (not just for writeOp, as well as truncate, delete) and also need to
>>> consider the different affects for different backends(Replicated, EC).
>>> 3. I don't think it is good time to redo this patch now, since the
>>> BlueStore and Kstore  is inprogress, and I'm afraid to bring some
>>> side-effect.  We may prepare and propose the whole design in next CDS.
>>> 4. Currently, we already have some tricks to deal with recovery (like
>>> throttle the max recovery op, set the priority for recovery and so
>>> on). So this kind of patch may not solve the critical problem but just
>>> make things better, and I am not quite sure that this will really
>>> bring a big improvement. Based on my previous test, it works
>>> excellently on slow disk (say hdd), and also for a short-time
>>> maintaining. Otherwise, it will trigger the backfill process.  So wait
>>> for Sage's opinion @sage
>>>
>>> If you are interest on this, we may cooperate to do this.
>>
>> I think it's a great idea.  We didn't do it before only because it is
>> complicated.  The good news is that if we can't conclusively infer exactly
>> which parts of hte object need to be recovered from the log entry we can
>> always just fall back to recovering the whole thing.  Also, the place
>> where this is currently most visible is RBD small writes:
>>
>>  - osd goes down
>>  - client sends a 4k overwrite and modifies an object
>>  - osd comes back up
>>  - client sends another 4k overwrite
>>  - client io blocks while osd recovers 4mb
>>
>> So even if we initially ignore truncate and omap and EC and clones and
>> anything else complicated I suspect we'll get a nice benefit.
>>
>> I haven't thought about this too much, but my guess is that the hard part
>> is making the primary's missing set representation include a partial delta
>> (say, an interval_set<> indicating which ranges of the file have changed)
>> in a way that gracefully degrades to recovering the whole object if we're
>> not sure.
>>
>> In any case, we should definitely have the design conversation!
>>
>> sage
>>
>>>
>>> Regards
>>> Ning Yao
>>>
>>>
>>> 2015-12-25 14:23 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
>>> > Thanks, from this pull request I learned that this issue is not
>>> > completed, is there any new progress of this issue?
>>> >
>>> > 2015-12-25 12:30 GMT+08:00 Xinze Chi (??) <xmdxcxz@gmail.com>:
>>> >> Yeah, This is good idea for recovery, but not for backfill.
>>> >> @YaoNing have pull a request about this
>>> >> https://github.com/ceph/ceph/pull/3837 this year.
>>> >>
>>> >> 2015-12-25 11:16 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
>>> >>> Hi,
>>> >>> I have doubt about pglog, the pglog contains (op,object,version) etc.
>>> >>> when peering, use pglog to construct missing list,then recover the
>>> >>> whole object in missing list even if different data among replicas is
>>> >>> less then a whole object data(eg,4MB).
>>> >>> why not add (offset,len) to pglog? If so, the missing list can contain
>>> >>> (object, offset, len), then we can reduce recover data.
>>> >>> _______________________________________________
>>> >>> ceph-users mailing list
>>> >>> ceph-users@lists.ceph.com
>>> >>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>> >>
>>> >>
>>> >>
>>> >> --
>>> >> Regards,
>>> >> Xinze Chi
>>> > _______________________________________________
>>> > ceph-users mailing list
>>> > ceph-users@lists.ceph.com
>>> > http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>
>>>
