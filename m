From: "Jim Schutt" <jaschut@sandia.gov>
Subject: Re: leveldb compaction overhead
Date: Wed, 5 Jun 2013 13:00:24 -0600
Message-ID: <51AF8AC8.6030301@sandia.gov>
References: <alpine.DEB.2.00.1305291406080.16097@cobra.newdream.net>
 <51A916AE.9010700@sandia.gov>
 <alpine.DEB.2.00.1305311659200.16097@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:37849 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756164Ab3FETAm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Jun 2013 15:00:42 -0400
In-Reply-To: <alpine.DEB.2.00.1305311659200.16097@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

Hi Sage,

On 05/31/2013 06:00 PM, Sage Weil wrote:
> On Fri, 31 May 2013, Jim Schutt wrote:
>> Hi Sage,
>>
>> On 05/29/2013 03:07 PM, Sage Weil wrote:
>>> Hi all-
>>>
>>> I have a couple of branches (wip-5176 and wip-5176-cuttlefish) that try to 
>>> make the leveldb compaction on the monitor less expensive by doing it in 
>>> an async thread and compaction only the trimmed range.  If anyone who is 
>>> experience high monitor io on cuttlefish would like to test it out, 
>>> feedback on whether/how much it improves things would be much appreciated!
>>
>> I've been flogging wip-5176-cuttlefish merged into recent cuttlefish
>> branch (commit 02ef6e918e), and the result has been very stable for
>> me.  I've been testing OSD reweights, and so have been getting lots
>> of pgmap updates, and lots of data movement.
>>
>> I'm no longer seeing stalls, and I see much less data movement
>> on the monitor hosts.  I haven't seen any monitors drop out
>> and rejoin, which had been a regular occurrence for me.
>> I stopped a mon and reinitialized it, and it resync'ed in 
>> just a few minutes, which is also a big improvement.
>>
>> This is all with 128K PGs - next week I'll try much higher
>> PG counts.
>>
>> Thanks a bunch for these fixes - they are working great
>> for me!
> 
> This is great news!
> 
> I pushed a few more patches to wip-5176-cuttlefish that should make it 
> even better (smarter about ranges to compact, and perfcounters so we can 
> tell what leveldb compactions are taking place).  Do you mind trying it 
> out as well?

I've been testing these out, in the cuttlefish branch (at commit 8544ea7518).
They've been working well for me, with the possible exception of commit
61135964419 ("mon/Paxos: adjust trimming defaults up; rename options").

FWIW, I've found that the new default values for paxos_trim_min and
paxos_service_trim_min aren't working well for me at 256K PGs.
I periodically get the classic symptoms of monitor non-responsiveness:
mons dropping out of quorum and coming back in later, and an mds going
laggy and booting.  The mds behavior is slightly new - the active
mds doesn't fail over to one of my standby mds instances, it just
goes laggy, boots, repeat.

I've gone to really, really aggressive trimming (both paxos_trim_min
and paxos_service_trim_min at 10), and this has been working really
well for me so far.

I'm wondering, when leveldb compacts, does it stop committing new
objects for the duration of the compaction?  If so, then possibly
smaller but more frequent compaction causes shorter periods of
no updates.  So, even though there's more compaction work overall,
each episode is much less disruptive, and my cluster is much happier.
If not, then I'm not sure why my trim tuning seems to help.

Thanks -- Jim

> 
> In the meantime, I'm going to pull it into the cuttlefish branch and test 
> over the weekend.  If that looks good we'll cut a point release with all 
> of these fixes.
> 
> Thank you to everyone who has helped with the debugging and testing on 
> these issues!
> 
> sage
> 
> 
>>
>> Thanks -- Jim
>>
>>>
>>> Thanks-
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> 
> 


