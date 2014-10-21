From: Lei Dong <leidong@yahoo-inc.com>
Subject: Re: weight VS crush weight when doing osd reweight
Date: Tue, 21 Oct 2014 02:15:02 +0000
Message-ID: <D06BE1E6.33C1%leidong@yahoo-inc.com>
References: <D06AAD30.3328%leidong@yahoo-inc.com>
 <alpine.DEB.2.00.1410200756130.10837@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mrout2.yahoo.com ([216.145.54.172]:47873 "EHLO mrout2.yahoo.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754335AbaJUCPl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Oct 2014 22:15:41 -0400
In-Reply-To: <alpine.DEB.2.00.1410200756130.10837@cobra.newdream.net>
Content-Language: en-US
Content-ID: <912E46F1DC03EE4381C11D3B2B5B4F6E@yforest.corp.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Thanks Sage!
So you mean:

1. Choose step will not be affected by OSD weight(but only CRUSH weight).
2. Chooseleaf step will be affected by both the two weights. But with a
big variation in CRUSH weight and small OSD number, CRUSH works
inefficiently to make the distribution even although we can adjust OSD
weight.

Right?

LeiDong

On 10/20/14, 11:03 PM, "Sage Weil" <sage@newdream.net> wrote:

>On Mon, 20 Oct 2014, Lei Dong wrote:
>> Hi sage:
>> 
>> As you said at https://github.com/ceph/ceph/pull/2199, adjusting weight
>>or
>> crush weight should be both effective at any case. We?ve encounter a
>>situation
>> in which it seems adjusting weight is far less effective than adjusting
>> crush weight. 
>> 
>> We use 6 racks with host number {9, 5, 9, 4, 9, 4} and 11 osds at each
>>host.
>> We created a crush rule for ec pool to survive rack failure:
>> 
>> ruleset ecrule {
>>         ?
>>         min_size 11
>>         max_size 11
>>         step set_chooseleaf_tries 50
>> step take default
>> step choose firstn 4 type rack // we want the distribution to be {3, 3,
>>3,
>> 2} for k=8 m=3
>> step chooseleaf indep 3 type host
>>       step emit
>> }
>> 
>> After creation of the pool, we run osd reweight-by-pg many times, the
>>best
>> result it can reach is
>> Average PGs/OSD (expected): 225.28
>> Max PGs/OSD: 307
>> Min PGs/OSD: 164
>> 
>> Then we run our own tool to reweight(same strategy with reweight-by-pg,
>>just
>> adjust crush weight instead of weight),  the best result is:
>> Average PGs/OSD (expected): 225.28
>> Max PGs/OSD: 241
>> Min PGs/OSD: 207
>> Which is much better than the previous one.
>> 
>> According to my understanding, due to uneven host numbers across rack,
>>  for ?step choose firstn 4 type rack?:
>>  1. If we adjust osd weight,  this step is almost unaffected and
>>     will dispatch almost even pg number for each rack. Thus the host in
>>the
>>     rack which have less host will take more pgs, no matter how we
>>adjust
>>     weight. 
>>  2. If we adjust osd crush weight, this step is affected and will try to
>>     dispatch more pg to the rack which has higher crush weight value,
>>thus
>>     the result can be even.
>> Am I right about this?
>
>I think so, yes.  I am a bit surprised that this is a problem, though.
>We 
>will still be distributing PGs based on the relative CRUSH weights, and I
>would not expect that the expected variation will lead to very much skew
>between racks.
>
>It may be that CRUSH is, at baseline, having trouble respecting your
>weights.  You might try creating a single straw bucket with 6 OSDs and
>those weights (9, 5, 9, 4, 9, 4) and see if it is able to achieve a
>correct distribution.  When there is a lot of variation in weights and
>the 
>total number of items are small it can be hard for it to get to the right
>result.  (We were just looking into a similar problem on another cluster
>on Friday.)
>
>For a more typical chooseleaf the osd weight will have the intended
>behavior, but when the initial step is a regular choose only the CRUSH
>weights affect the decision.  My guess is that your process of skewing
>the 
>CRUSH weights pretty dramatically which is able to compensate for the
>difficulty/improbability of randomly choosing racks with the right
>frequency...
>
>sage
>
>> We then do a further test with 6 racks and 9 hosts in each rack. In this
>> situation, adjusting weight or adjusting crush weight has almost the
>>same
>> effect.
>>
>> So, weight and crush weight do impact the result of CRUSH in a different
>> way? 

