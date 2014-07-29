From: Mark Nelson <mark.nelson@inktank.com>
Subject: Re: giant and hammer dates
Date: Tue, 29 Jul 2014 18:20:23 -0500
Message-ID: <53D82C37.8020705@inktank.com>
References: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f180.google.com ([209.85.213.180]:59387 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811AbaG2XUP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 19:20:15 -0400
Received: by mail-ig0-f180.google.com with SMTP id l13so1863929iga.1
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jul 2014 16:20:14 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org

On 07/29/2014 06:11 PM, Sage Weil wrote:
> We've talked a bit about moving to a ~4 month (instead of 3 month)
> cadence.  I'm still inclined in this direction because it means fewer
> stable releases that we will be maintaining and a longer and (hopefully)
> more productive interval to do real work in between.
>
> The other key point is that we don't want a repeat of the firefly delay.
> I think we should stay as close to a train model as we can.  If something
> isn't ready by freeze, let it wait for the next cycle.  We shouldn't be
> cramming things in at the end, especially big things.  As a general rule,
> big things should be merged early in the cycle so that we have lots of
> time to shake out the issues that only come out of lots of testing and
> aren't obvious from code review.
>
> Anyway, how about:
>
>            Freeze         Approx Release
>    Giant   Mon Sep  1     Mon Sep 29
>    Hammer  Mon Jan  4     Mon Feb  2
>
> That gives us another month for Giant, then September to shake out
> anything issues.  And then three full months before the Hammer freeze.
>
> What say ye?

6 months. ;)

> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

