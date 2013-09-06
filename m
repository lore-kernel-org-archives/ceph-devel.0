From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: [ceph-users] CephFS test-case
Date: Fri, 06 Sep 2013 18:29:42 -0500
Message-ID: <522A6566.4020700@inktank.com>
References: <CACSYr9TsjHq9uWx816aPrW0SDYqwhfyfVkfcR0L-jsk-XcH9Ag@mail.gmail.com> <alpine.DEB.2.00.1309060825410.2805@cobra.newdream.net> <CACSYr9RcSbX8qhTA3QCsFOT0qLi4x5hVqCitwHzdVOASx_UNsA@mail.gmail.com> <alpine.DEB.2.00.1309061611580.18150@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:58496 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708Ab3IFX3o (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Sep 2013 19:29:44 -0400
Received: by mail-ie0-f182.google.com with SMTP id aq17so8468193iec.27
        for <ceph-devel@vger.kernel.org>; Fri, 06 Sep 2013 16:29:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1309061611580.18150@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Nigel Williams <nigel.d.williams@gmail.com>, ceph-devel@vger.kernel.org

On 09/06/2013 06:22 PM, Sage Weil wrote:
> [re-adding ceph-devel]
>
> On Sat, 7 Sep 2013, Nigel Williams wrote:
>
>> On Sat, Sep 7, 2013 at 1:27 AM, Sage Weil <sage@inktank.com> wrote:
>>> It sounds like the problem is cluster B's pools have too few PGs, making
>>> the data distribution get all out of whack.
>>
>> Agree, it was too few PGs, I have no re-adjusted and it is busy
>> backfilling and evening out the data-distribution across the OSDs.
>>
>> My overall point is that the out-of-the-box defaults don't provide a
>> stable test-deployment (whereas older versions like 0.61 did), and so
>> minimally perhaps ceph-deploy needs to have a stab at choosing a
>> workable value of PGs? or alternatively the health warning could
>> include a note about PGs being too low.
>
> I agree; this is a general problem that we need to come up with a better
> solution to.
>
> One idea:
>
> - make ceph health warn when the pg distribution looks "bad"
> 	- too few pgs relative the # of osds
> 	- too many objects in a pool relative to the # of pgs and the
> 	  above
>
> (We'll need to be a little creative to make thresholds that make sense.)
>
> If we have an interactive ceph-deploy new, we can also estimate how big
> the cluster will get and make a more sensible starting count.  I like that
> less, though, as it potentially confusing and has more room for user
> error.

At one point Sam and I were discussing some kind of message that 
wouldn't be a health warning, but something kind of similar to what you 
are discussing here.  The idea is this would be for when Ceph thinks 
something is configured sub-optimally, but the issue doesn't necessarily 
affect the health of the cluster (at least in so much as everything is 
functioning as defined).  We were concerned that people might not want 
more things causing health warnings.

>
> sage
>
>
>>
>>>   ceph osd dump | grep ^pool
>>> say, and how many OSDs do you have?
>>
>> I assume you mean PGs, it was the default (192?) and changing it to
>> 400 seems to have helped. There are 12 OSDs (4 per server, 3 servers).
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

