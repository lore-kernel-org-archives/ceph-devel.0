From: Li Wang <liwang@ubuntukylin.com>
Subject: Re: contraining crush placement possibilities
Date: Mon, 10 Mar 2014 17:37:04 +0800
Message-ID: <531D87C0.2050304@ubuntukylin.com>
References: <alpine.DEB.2.00.1403061227080.17325@cobra.newdream.net> <CABZ+qqkYw2CznTS5ters9LMaX7zPMQ8LxvB8e0rfGuz_3BYXZA@mail.gmail.com> <alpine.DEB.2.00.1403070705440.24219@cobra.newdream.net> <CAPYLRziGh52rUq1yk5U74D55zs+C=Sda9Dm_UbR9M7F5sECSdA@mail.gmail.com> <alpine.DEB.2.00.1403070934450.3593@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from m199-177.yeah.net ([123.58.177.199]:60350 "EHLO
	m199-177.yeah.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbaCJJhK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 10 Mar 2014 05:37:10 -0400
In-Reply-To: <alpine.DEB.2.00.1403070934450.3593@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>, Gregory Farnum <greg@inktank.com>
Cc: Dan van der Ster <daniel.vanderster@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

pgp_num is the upper bound of number of OSD combinations, right?
so we can reduce pgp_num to constrain the possible combinations,
and the data loss probability is only dependent on pgp_num,
say, pgp_num/Pn(replica_num) (Since (a, b) and (b, a) are different pgs, 
so it is permutation rather than combination). But we can still
maintain a big pg_num, will it make the object distribution more
uniform? Currently object_id is mapped to pg_id, then pg_id mapped to
OSD combinations, why does it need two levels of mapping, why not map
object_id to OSD combinations directly, will it achieve a more uniform
distribution?

On 2014/3/8 1:43, Sage Weil wrote:
> On Fri, 7 Mar 2014, Gregory Farnum wrote:
>> On Fri, Mar 7, 2014 at 7:10 AM, Sage Weil <sage@inktank.com> wrote:
>>> On Fri, 7 Mar 2014, Dan van der Ster wrote:
>>>> On Thu, Mar 6, 2014 at 9:30 PM, Sage Weil <sage@inktank.com> wrote:
>>>>> Sheldon just
>>>>> pointed out a talk from ATC that discusses the basic problem:
>>>>>
>>>>>          https://www.usenix.org/conference/atc13/technical-sessions/presentation/cidon
>>>>>
>>>>> The situation with CRUSH is slightly better, I think, because the number
>>>>> of peers for a given OSD in a large cluster is bounded (pg_num /
>>>>> num_osds), but I think we may still be able improve things.
>>>>
>>>> I'm surprised they didn't cite Ceph -- aren't copysets ~= placement groups?
>>>
>>> I think so (I didn't listen to the whole talk :).  My ears did perk up
>>> when Carlos (who was part of the original team at UCSC) asked the question
>>> about the CRUSH paper at the end, though. :)
>>>
>>> Anyway, now I'm thinking that this *is* really just all about tuning
>>> pg_num/pgp_num.  And of course managing failure domains in the CRUSH map
>>> as best we can to align placement with expected sources of correlated
>>> failure.  But again, I would appreciate any confirmation from others'
>>> intuitions or (better yet) a proper mathematical model.  This bit of my
>>> brain is full of cobwebs, and wasn't particularly strong here to begin
>>> with.
>>
>> Well, yes and no. They're constraining data sharing in order to reduce
>> the probability of any given data loss event, and we can reduce data
>> sharing by reducing the pgp_num. But the example you cited was "place
>> all copies in the top third of the selected racks", and that's a
>> little different because it means they can independently scale the
>> data sharing *within* that grouping to maintain a good data balance,
>> which CRUSH would have trouble with.
>> Unfortunately my intuition around probability and stats isn't much
>> good, so that's about as far as I can take this effectively. ;)
>
> Yeah I'm struggling with this too, but I *think* the top/middle/bottom
> rack analogy is just an easy way to think about constraining the placement
> options, which we're doing anyway with the placement group count--just in
> a way that looks random but is still sampling a small portion of the
> possible combinations.  In the end, whether you eliminate 8/9 of the
> options of the rack layers and *then* scale pg_num, or just scale pg_num,
> I think it still boils down to the number of distinct 3-disk sets out of
> the total possible 3-disk sets.
>
> Also, FWIW, the rack thing is equivalent to making 3 parallel trees so
> that the crush hierarchy goes like:
>
>   root
>   layer of rack (top/middle/bottom)
>   rack
>   host
>   osd
>
> and make the crush rule first pick 1 layer before doing the chooseleaf
> over racks.
>
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
