From: Joao Eduardo Luis <joao@suse.de>
Subject: Re: Ceph release cadence
Date: Wed, 6 Sep 2017 18:52:33 +0100
Message-ID: <aaefa68b-8221-8e4b-e27a-c2dda2b008f0@suse.de>
References: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56079 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750807AbdIFRwg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 6 Sep 2017 13:52:36 -0400
In-Reply-To: <alpine.DEB.2.11.1709061523170.16664@piezo.novalocal>
Content-Language: en-GB
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, ceph-devel@vger.kernel.org, ceph-maintainers@ceph.com, ceph-users@ceph.com

On 09/06/2017 04:23 PM, Sage Weil wrote:
> * Keep even/odd pattern, but force a 'train' model with a more regular
> cadence
> 
>    + predictable schedule
>    - some features will miss the target and be delayed a year

Personally, I think a predictable schedule is the way to go. Two major 
reasons come to mind:

1. Developers are actually aware of what the cut-off date is, and will 
plan accordingly; and,

2. Downstreams will have a better notion of when the next release is to 
be expected, and plan accordingly.

However, a one year wait for a release may be a can of worms waiting to 
be opened. Even though it would ideally provide us a lot more time to 
merge stuff and test it, there's also the downside that some stuff may 
be pushed further and further down the line, and eventually merged just 
before the window closes.

For that, I'd argue having an intermediate (staging?) release could be 
helpful, but I fear it would not be anything more than any other 
dev-release. Therefore, if we stick to a one-year cadence, let's have 
frequent dev-releases.

I would also like to argue for a hard cut-off date considerably before 
major holiday seasons. Because no one really wants to be dealing with 
bugs or releasing software while a considerable portion of developers 
are away.

Additionally,

> * Drop the odd releases, but relax the "must upgrade through every LTS" to
> allow upgrades across 2 versions (e.g., luminous -> mimic or luminous ->
> nautilus).  Shorten release cycle (~6-9 months).

I can be on board with this too. As long as we have a very clear cut-off 
date regardless.

   -Joao
