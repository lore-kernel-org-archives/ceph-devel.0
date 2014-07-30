From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: giant and hammer dates
Date: Wed, 30 Jul 2014 11:52:56 -0500
Message-ID: <53D922E8.3050809@inktank.com>
References: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net> <CAPYLRzgv8m-7LzQBgcGafwOw3SWjn_wVBh7L_+vMnwtRFUYz7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:55269 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454AbaG3QxE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 12:53:04 -0400
Received: by mail-ie0-f182.google.com with SMTP id y20so1938687ier.13
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jul 2014 09:53:03 -0700 (PDT)
In-Reply-To: <CAPYLRzgv8m-7LzQBgcGafwOw3SWjn_wVBh7L_+vMnwtRFUYz7g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 07/30/2014 09:22 AM, Gregory Farnum wrote:
> On Tue, Jul 29, 2014 at 7:11 PM, Sage Weil <sweil@redhat.com> wrote:
>> We've talked a bit about moving to a ~4 month (instead of 3 month)
>> cadence.  I'm still inclined in this direction because it means fewer
>> stable releases that we will be maintaining and a longer and (hopefully)
>> more productive interval to do real work in between.
>>
>> The other key point is that we don't want a repeat of the firefly delay.
>> I think we should stay as close to a train model as we can.  If something
>> isn't ready by freeze, let it wait for the next cycle.  We shouldn't be
>> cramming things in at the end, especially big things.  As a general rule,
>> big things should be merged early in the cycle so that we have lots of
>> time to shake out the issues that only come out of lots of testing and
>> aren't obvious from code review.
>
> These two points are sort of opposing. In particular, extending the
> release cycle just makes the release seem more important, and
> increases the pressure to merge features in one cycle instead of
> waiting for the next one. (*Especially* if we continue to maintain
> every other named release.)
> I continue to prefer a 3-month cycle where we maintain enough merging
> discipline that the follow-on one-month shakeout period is something
> that the development team largely doesn't have to worry about, because
> the code is already working *before* we start it and we're just
> uncovering rare and longer-term bugs during that period.

Personally I'd prefer a longer testing and bugfix period for named 
releases.  4 months of development plus 2 months of testing. 
Development can easily go several weeks or a month over schedule 
(Personally I believe even good teams can't consistently stop this from 
happening, especially with something as complicated as next generation 
distributed storage!).  Our bugfix/test period gets too crunched as it 
is and our initial named releases feel more like release candidates. 
Soon after release we tend to make a bunch of point releases to fix 
semi-major bugs.  If we are doing that anyway, I think it would be 
better to just extend the test time and really make sure we've devoted a 
solid chunk of time for RC or Beta releases before the named release 
goes out.

I think the short point release cycle does help mitigate the merge 
pressure problem, but only if we are disciplined.  If the point releases 
are getting behind, stuff has to get cut.  6 months isn't that much 
longer to wait than 4 months, especially if people are already waiting 
until the 2nd or 3rd point release before they deploy for production 
(not sure if this is happening, but I suspect it is).

Mark

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

