From: Dan van der Ster <dan@vanderster.com>
Subject: Re: throttling reweight-by-utilization
Date: Tue, 1 Mar 2016 09:58:13 +0100
Message-ID: <CABZ+qq=Cdeq83=Fihp+3NvjGmvtUeZm=YygvJEO2XBd8PHrYhw@mail.gmail.com>
References: <CABZ+qqmnOCvGa_=XRowxHy=Q-wRihxiTs2=bX1AsDuymvOUd3g@mail.gmail.com>
 <alpine.DEB.2.11.1601180859180.26381@cpach.fuggernut.com> <CABZ+qqkCZEZcj99sXQw_hZzaBbLAJyaO48MLbbrA6JVhNYEFOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36819 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751870AbcCAI65 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Mar 2016 03:58:57 -0500
Received: by mail-lb0-f179.google.com with SMTP id x1so95005614lbj.3
        for <ceph-devel@vger.kernel.org>; Tue, 01 Mar 2016 00:58:56 -0800 (PST)
Received: from mail-lf0-f41.google.com (mail-lf0-f41.google.com. [209.85.215.41])
        by smtp.gmail.com with ESMTPSA id ay2sm4680789lbc.39.2016.03.01.00.58.53
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 00:58:53 -0800 (PST)
Received: by mail-lf0-f41.google.com with SMTP id j186so34318333lfg.2
        for <ceph-devel@vger.kernel.org>; Tue, 01 Mar 2016 00:58:53 -0800 (PST)
In-Reply-To: <CABZ+qqkCZEZcj99sXQw_hZzaBbLAJyaO48MLbbrA6JVhNYEFOQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage,
I have a wip here: https://github.com/cernceph/ceph/commits/wip-reweight
I still need to spin up a small test cluster to test it.
-- Dan

On Mon, Jan 18, 2016 at 4:25 PM, Dan van der Ster <dan@vanderster.com> wrote:
> On Mon, Jan 18, 2016 at 3:06 PM, Sage Weil <sage@newdream.net> wrote:
>> On Mon, 18 Jan 2016, Dan van der Ster wrote:
>>> Hi,
>>>
>>> I'd like to propose a few changes to reweight-by-utilization which
>>> will make it significantly less scary:
>>>
>>> 1. Change reweight-by-utilization to run in "dry run" -- display only
>>> -- mode unless an admin runs with  --yes-i-really-really-mean-it. This
>>> way admins can see what will be reweighted before committing to any
>>> changes.
>>
>> I think this piece is key, and there is a lot we might do here to make
>> this more informative.  In particular, we have the (approx) sizes of each
>> PG(*) and can calculate their mapping after the proposed change, which
>> means we could show the min/max utilization, standard deviation, and/or
>> number of nearfull or full OSDs before and after.
>>
>
> I hadn't thought of that, but it would be cool.
> My main use of the dry-run functionality is to ensure that it's not
> going to change too many OSDs at once (IOW letting me try different
> oload and pool values). Maybe some users want to make a large change
> all in one go -- in that case this would be useful.
>
>
>> * Almost... we don't really know how many bytes of key/value omap data are
>> consumed.  So we could either go by the user data accounting, which is a
>> lower bound, or average the OSD utilization by the PGs it stores
>> (averaging pools together), or try do the same for just the difference
>> (which would presumably be omap data + overall overhead).
>>
>> I'm not sure how much it is worth trying to be accurate here...
>>
>>> 2. Add a configurable to limit the number of OSDs changed per execution:
>>>   mon_reweight_max_osds_changed (default 4)
>>>
>>> 3. Add a configurable to limit the weight changed per OSD:
>>>   mon_reweight_max_weight_change (default 0.05)
>>>
>>> Along with (2) and (3), the main loop in reweight_by_utilization:
>>>   https://github.com/ceph/ceph/blob/master/src/mon/OSDMonitor.cc#L568
>>> needs to sort the OSDs by utilization.
>>>
>>> 4. Make adjusting weights up optional with a new CLI option
>>> --adjust-up. This is useful because if you have nearly full OSDs you
>>> want to prioritize making space on those OSDs.
>>
>> These sound reasonable to me.  Although, in general, if we ultimately want
>> people do to this regularly via cron or something, we'll need --adjust-up.
>> I wonder if there is some other way it should be biased so that we weight
>> the overfull stuff down before weighting the underfull stuff up.  Maybe
>> the max_osds_changed already mostly does that by doing the fullest osds
>> first?
>
> One other reason we need to be able to disable --adjust-up is for
> non-flat crush trees, where some OSDs get more PGs because of a non
> trivial ruleset. reweight-by-pg helps in this case, but its still not
> perfect for all crush layouts. For example, we have a ruleset which
> puts two replicas in one root and a third replica in another root...
> this is difficult for the reweight-by-* function to get right. One
> solution to this which I haven't yet tried is to add a --bucket option
> to reweight-by-* which only looks at OSDs under a given point in the
> tree.
>
> -- Dan
>
>
>
>> Thanks, Dan!
>> sage
>>
>>
>>
>>> I have already been running with these options in a python prototype:
>>>   https://github.com/cernceph/ceph-scripts/blob/master/tools/crush-reweight-by-utilization.py
>>>
>>> If you agree I'll port these changes to OSDMonitor.cc and send a PR.
>>>
>>> Best Regards,
>>> Dan
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
