From: Sage Weil <sage@newdream.net>
Subject: Re: LRC has slower recovery than Jerasure
Date: Mon, 11 Sep 2017 20:49:36 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1709112048200.24068@piezo.novalocal>
References: <CAODUPsGPdZ7AL1nYpTP5OE8iqWpcgj=Durm_f_4C=y12tbmnYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46597 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750926AbdIKUtj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Sep 2017 16:49:39 -0400
In-Reply-To: <CAODUPsGPdZ7AL1nYpTP5OE8iqWpcgj=Durm_f_4C=y12tbmnYA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Oleg Kolosov <olekol@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 11 Sep 2017, Oleg Kolosov wrote:
> Hi,
> I'm working on a new implementation of a new erasure code. During my
> development, I began testing the performance of my code & ceph LRC
> plugin vs jerasure.
> When setting up a cluster with failure domain being only leaf cells
> (osd) I saw the expected behaviour - recovery of LRC is faster than
> jerasure.
> Next I divided my cluster into 5 hosts, each containing 8 osds, and
> placed each local group under a different host (using ruleset-steps).
> Jerasure still had osd as failure domain. At this point I noticed that
> LRC has slower recovery. I've tried a configuration of k=4, l=3 and
> total of 9 shards.
> 
> I don't think it's collisions in crush, since it shouldn't have such a
> heavy effect.
> My suspicion is some sort of a throttle. I've tried to set the following:
>          osd recovery max active = 500
>         osd recovery op priority = 32
> 
> But I didn't see any significant improvement.
> 
> Can you think of a reason LRC would recover slower than jerasure when
> it's constrained to domains as I've described?

I don't have a specific answer for you, but one thing to keep in mind 
is that even with LRC, recovery is driven by the primary: it will 
reconstruct the shard(s) on the primary (reading over the network) and 
then push them out to the OSDs that need them.  That means that the 
benefits of localizing recovery to a local group in LRC is only realized 
if the primary happens to be part of that group.

Perhaps that helps explain the behavior you're seeing?

sage

