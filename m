From: Sage Weil <sage@newdream.net>
Subject: Re: Questions about bucket algorithm and bucket choose
Date: Mon, 16 Apr 2012 14:29:13 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1204161425180.31853@cobra.newdream.net>
References: <CALwGbPKqXyubH1O-cBoYm-LaJ86LR3QOzzd=mYyL8HESx1+13g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:35778 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752828Ab2DPV3Q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Apr 2012 17:29:16 -0400
In-Reply-To: <CALwGbPKqXyubH1O-cBoYm-LaJ86LR3QOzzd=mYyL8HESx1+13g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?6IOh54Ca5qOu?= <softrank.net@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Sun, 15 Apr 2012,  wrote:
> Hi everyone.
> 
> One question is about performance of bucket algorithms, it seems that
> on every aspect, straw bucket is at least not worse than list bucket.
> So does it mean we shall always use straw bucket instead of list
> bucket?

Well, list on average will calculate a hash for 1/2 of the items, while 
straw always does every item.  That said, we use straw by default for all 
buckets.  As long as there is _some_ hierarchy, the individual buckets 
don't get too big, and CRUSH is so cheap anyway that it doesn't really 
matter... especially when compared to the cost of moving data due to a 
less-than-optimal remapping.
 
> I was browsing branch tree of ceph to trace back earlier versions of
> the implementation. I noticed that crush_uniform_bucket_choose has
> been significantly changed. I read the comment which said the original
> method (seems to be described in the thesis) is not random enough and
> has some bad behavior, but I don't know what kind of bad behavior is
> that. For what reason a random permutation is a better choice?

If I remember correctly, the problem was that it would favor certain nodes 
when there were too many or certain patterns of failures within the 
bucket (I don't remember the details).  The original algorithmw as 
supposed to give you a random permutation too, but it didn't always do 
that.

I think that code is also used as a fallback if the sampling fails to 
return a good value after too many tries.

This will be one of the things we look at in a month or two when we 
take a careful look at CRUSH.

sage
