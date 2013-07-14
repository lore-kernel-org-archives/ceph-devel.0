From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: [ceph-users] slow request problem
Date: Sun, 14 Jul 2013 21:26:06 +0200
Message-ID: <51E2FB4E.40804@profihost.ag>
References: <51E00197.7010708@profihost.ag> <51E29660.4040200@profihost.ag> <alpine.DEB.2.00.1307140753380.25223@cobra.newdream.net> <10993195-49C7-44DB-B6D2-EFF484204DB3@profihost.ag> <alpine.DEB.2.00.1307140914480.25223@cobra.newdream.net> <51E2ED49.30304@profihost.ag> <alpine.DEB.2.00.1307141201330.25223@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:57541 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753013Ab3GNT0G (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 14 Jul 2013 15:26:06 -0400
In-Reply-To: <alpine.DEB.2.00.1307141201330.25223@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

Am 14.07.2013 21:05, schrieb Sage Weil:
> On Sun, 14 Jul 2013, Stefan Priebe wrote:
>> Am 14.07.2013 18:19, schrieb Sage Weil:
>>> On Sun, 14 Jul 2013, Stefan Priebe - Profihost AG wrote:
>>>> Hi sage,
>>>>
>>>> Am 14.07.2013 um 17:01 schrieb Sage Weil <sage@inktank.com>:
>>>>
>>>>> On Sun, 14 Jul 2013, Stefan Priebe wrote:
>>>>>> Hello list,
>>>>>>
>>>>>> might this be a problem due to having too much PGs? I've 370 per OSD
>>>>>> instead
>>>>>> of having 33 / OSD (OSDs*100/3).
>>>>>
>>>>> That might exacerbate it.
>>>>>
>>>>> Can you try setting
>>>>>
>>>>> osd min pg log entries = 50
>>>>> osd max pg log entries = 100
>>>>
>>>> What does that exactly do? And why is a restart of all osds needed.
>>>> Thanks!
>>>
>>> This limits the size of the pg log.
>>>
>>>>
>>>>> across your cluster, restarting your osds, and see if that makes a
>>>>> difference?  I'm wondering if this is a problem with pg log rewrites
>>>>> after
>>>>> peering.  Note that adding that option and restarting isn't enough to
>>>>> trigger the trim; you have to hit the cluster with some IO too, and (if
>>>>> this is the source of your problem) the trim itself might be expensive.
>>>>> So add it, restart, do a bunch of io (to all pools/pgs if you can), and
>>>>> then see if the problem is still present?
>>>>
>>>> Will try can't produce a write to every pg. it's a prod. Cluster with
>>>> KVM rbd. But it has 800-1200 iop/s per second.
>>>
>>> Hmm, if this is a production cluster, I would be careful, then!  Setting
>>> the pg logs too short can lead to backfill, which is very expensive (as
>>> you know).
>>>
>>> The defaults are 3000 / 10000, so maybe try something less aggressive like
>>> changing min to 500?
>>
>> I've lowered the values to 500 / 1500 and it seems to lower the impact but
>> does not seem to solve that one.
>
> This suggests that the problem is the pg log rewrites that are an inherent
> part of cuttlefish.  This is replaced with improved rewrite logic in 0.66
> or so, so dumpling will be better.  I suspect that having a large number
> of pgs is exacerbating the issue for you.
>
> We think there is still a different peering performance problem that Sam
> and paravoid have been trying to track down, but I believe in that case
> reducing the pg log sizes didn't have much effect.  (Maybe one of them can
> chime in here.)
>
> This was unfortunately something we failed to catch before cuttlefish was
> released.  One of the main focuses right now is in creating large clusters
> and observing peering and recovery to make sure we don't repeat the same
> sort of mistake for dumpling!

Thanks Sage for these information. I had some OSD restarts which went 
better with the new settings but others which don't. But it's hard to 
measure and compare restart OSD.X with OSD.Y.

Do you have any recommandations for me? Wait for dumpling and hope that 
nothing fails until then? Or upgrading to 0.66? Or trying to move all 
data to a new pool having fewer PGs?

Thanks!

Greets,
Stefan
