From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [ceph-users] slow request problem
Date: Sun, 14 Jul 2013 20:26:17 +0200
Message-ID: <51E2ED49.30304@profihost.ag>
References: <51E00197.7010708@profihost.ag> <51E29660.4040200@profihost.ag> <alpine.DEB.2.00.1307140753380.25223@cobra.newdream.net> <10993195-49C7-44DB-B6D2-EFF484204DB3@profihost.ag> <alpine.DEB.2.00.1307140914480.25223@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:36060 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923Ab3GNS0R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Jul 2013 14:26:17 -0400
In-Reply-To: <alpine.DEB.2.00.1307140914480.25223@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Am 14.07.2013 18:19, schrieb Sage Weil:
> On Sun, 14 Jul 2013, Stefan Priebe - Profihost AG wrote:
>> Hi sage,
>>
>> Am 14.07.2013 um 17:01 schrieb Sage Weil <sage@inktank.com>:
>>
>>> On Sun, 14 Jul 2013, Stefan Priebe wrote:
>>>> Hello list,
>>>>
>>>> might this be a problem due to having too much PGs? I've 370 per OSD instead
>>>> of having 33 / OSD (OSDs*100/3).
>>>
>>> That might exacerbate it.
>>>
>>> Can you try setting
>>>
>>> osd min pg log entries = 50
>>> osd max pg log entries = 100
>>
>> What does that exactly do? And why is a restart of all osds needed. Thanks!
>
> This limits the size of the pg log.
>
>>
>>> across your cluster, restarting your osds, and see if that makes a
>>> difference?  I'm wondering if this is a problem with pg log rewrites after
>>> peering.  Note that adding that option and restarting isn't enough to
>>> trigger the trim; you have to hit the cluster with some IO too, and (if
>>> this is the source of your problem) the trim itself might be expensive.
>>> So add it, restart, do a bunch of io (to all pools/pgs if you can), and
>>> then see if the problem is still present?
>>
>> Will try can't produce a write to every pg. it's a prod. Cluster with
>> KVM rbd. But it has 800-1200 iop/s per second.
>
> Hmm, if this is a production cluster, I would be careful, then!  Setting
> the pg logs too short can lead to backfill, which is very expensive (as
> you know).
>
> The defaults are 3000 / 10000, so maybe try something less aggressive like
> changing min to 500?

I've lowered the values to 500 / 1500 and it seems to lower the impact 
but does not seem to solve that one.

Stefan

> Also, I think
>
>   ceph osd tell \* injectargs '--osd-min-pg-log-entries 500'
>
> should work as well.  But again, be aware that lowering the value will
> incur a trim that may in itself be a bit expensive (if this is the source
> of the problem).
>
> It is probably worth watching ceph pg dump | grep $some_random_pg and
> watching the 'v' column over time (say, a minute or two) to see how
> quickly pg events are being generated on your cluster. This will give you
> a sense of how much time 500 (or however many) pg log entries covers!
>
> sage
>
>
>>
>>>
>>> Also note that the lower osd min pg log entries means that the osd cannot
>>> be down as long without requiring a backfill (50 ios per pg).  These
>>> probably aren't the values that we want, but I'd like to find out whether
>>> the pg log rewrites after peering in cuttlefish are the culprit here.
>>
>>
>>>
>>> Thanks!
>>>
>>>> Is there any plan for PG merging?
>>>
>>> Not right now.  :(  I'll talk to Sam, though, to see how difficult it
>>> would be given the split approach we settled on.
>>>
>>> Thanks!
>>> sage
>>>
>>>
>>>>
>>>> Stefan
>>>>> Hello list,
>>>>>
>>>>> anyone else here who always has problems bringing back an offline OSD?
>>>>> Since cuttlefish i'm seeing slow requests for the first 2-5 minutes
>>>>> after bringing an OSD oinline again but that's so long that the VMs
>>>>> crash as they think their disk is offline...
>>>>>
>>>>> Under bobtail i never had any problems with that.
>>>>>
>>>>> Please HELP!
>>>>>
>>>>> Greets,
>>>>> Stefan
>>>> _______________________________________________
>>>> ceph-users mailing list
>>>> ceph-users@lists.ceph.com
>>>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>>>
>>>>
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
