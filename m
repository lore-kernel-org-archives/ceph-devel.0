From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: cosd multi-second stalls cause "wrongly marked me down"
Date: Mon, 11 Apr 2011 08:41:22 -0600
Message-ID: <4DA31312.4060206@sandia.gov>
References: <1297891508.25491.120.camel@sale659.sandia.gov>
 <75157CFDA63D45458FC47FB7BA6CB974@gmail.com>
 <1297893011.25491.124.camel@sale659.sandia.gov>
 <Pine.LNX.4.64.1102161649560.11150@cobra.newdream.net>
 <4D9F367B.1070904@sandia.gov>
 <Pine.LNX.4.64.1104081343460.15928@cobra.newdream.net>
 <4D9F87F7.6090203@sandia.gov>
 <BANLkTimUZJhzCcC1AGTC73vi4ELVdy5H3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-three.sandia.gov ([132.175.109.17]:56558 "EHLO
	sentry-three.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753225Ab1DKOlq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Apr 2011 10:41:46 -0400
In-Reply-To: <BANLkTimUZJhzCcC1AGTC73vi4ELVdy5H3w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Colin McCabe <cmccabe@alumni.cmu.edu>
Cc: Sage Weil <sage@newdream.net>, Gregory Farnum <gregory.farnum@dreamhost.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Colin McCabe wrote:
> On Fri, Apr 8, 2011 at 3:11 PM, Jim Schutt <jaschut@sandia.gov> wrote:
>> Sage Weil wrote:
>>
>>> I would also be interested in seeing a system level profile (oprofile?) to
>>> see where CPU time is being spent.  There are likely low hanging fruit in
>>> the OSD that would reduce CPU overhead.
>> This will take me a little while, since I need to learn
>> about the tools.  But since I need to learn about them
>> anyway, that's a good thing.
> 
> oprofile is surprisingly easy to get started with. We have a wiki page about it:
> 
> http://ceph.newdream.net/wiki/Cpu_profiling

Cool, thanks.

> 
>>> I guess the other thing that would help to confirm this is to just halve
>>> the number of OSDs on your machines in a test and see if the problem goes
>>> away.
>> I was going to try this first, exactly because it seems like
>> a definitive test.
>>
>>>> If my analysis above is correct, do you think anything
>>>> can be gained by running the heartbeat and heartbeat
>>>> dispatcher threads as SCHED_RR threads?  Since tick() runs
>>>> heartbeat_check(), that would also need to be SCHED_RR,
>>>> or the heartbeats could arrive on time, but not checked
>>>> until it was too late.
> 
> Thanks for the ideas. However, I doubt that making the OSD::tick()
> thread SCHED_RR would really work.
> 
> The OSD::tick() code is taking locks all over the place. Since a bunch
> of other threads besides the tick thread can be holding those locks,
> this would soon result in priority inversion. Not to mention,
> heartbeat_messenger has its own thread(s) which actually perform the
> work of sending the heartbeat messages.

Yes, I think I understand.

-- Jim

> 
> cheers,
> Colin
> 
> 


