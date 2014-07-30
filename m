From: Gregory Farnum <greg@inktank.com>
Subject: Re: giant and hammer dates
Date: Wed, 30 Jul 2014 10:22:43 -0400
Message-ID: <CAPYLRzgv8m-7LzQBgcGafwOw3SWjn_wVBh7L_+vMnwtRFUYz7g@mail.gmail.com>
References: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34373 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbaG3OWr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jul 2014 10:22:47 -0400
Received: by mail-wi0-f171.google.com with SMTP id hi2so7656977wib.10
        for <ceph-devel@vger.kernel.org>; Wed, 30 Jul 2014 07:22:43 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1407291558060.26221@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jul 29, 2014 at 7:11 PM, Sage Weil <sweil@redhat.com> wrote:
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

These two points are sort of opposing. In particular, extending the
release cycle just makes the release seem more important, and
increases the pressure to merge features in one cycle instead of
waiting for the next one. (*Especially* if we continue to maintain
every other named release.)
I continue to prefer a 3-month cycle where we maintain enough merging
discipline that the follow-on one-month shakeout period is something
that the development team largely doesn't have to worry about, because
the code is already working *before* we start it and we're just
uncovering rare and longer-term bugs during that period.
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
