From: Jesse Williamson <jwilliamson@suse.de>
Subject: Re: OSDMap / osd_state questions
Date: Tue, 4 Apr 2017 07:55:50 -0700 (PDT)
Message-ID: <alpine.LSU.2.20.1704040749250.19913@ancalagon.suse.de>
References: <alpine.LSU.2.20.1704030511540.12566@ancalagon.suse.de> <alpine.DEB.2.11.1704041408290.2999@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:41322 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753465AbdDDOzw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Apr 2017 10:55:52 -0400
In-Reply-To: <alpine.DEB.2.11.1704041408290.2999@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Squid Cybernetic <ceph-devel@vger.kernel.org>

On Tue, 4 Apr 2017, Sage Weil wrote:

>> First question: Can we get away with returning osd_state.size()?
>
> Nope!

Ok, that settles that! :-) Thanks!

>> Second, should the cached/memoized member variables set as a side-effect of
>> calc_num_osds() /ever/ be trusted if we don't call the method first?
>
> Nope!  We're careful to call it after decode() and apply_incremental(),
> which are basically the only two paths that modify OSDMap.

Thanks, good to know!

>> Perhaps a method basically doing this would be useful, along these lines?

[...]

> Maybe!  Since osd_state is a vector its all very fast.  Not sure that we
> are bulding a set<int> of up or down often enough to justify
> prebuilding it.  (It also consumes memory, and on big clusters
> we have lots of big OSDMaps in a cache that can't consume too much
> memory.)

Yes, it would definitely use quite a bit of extra memory, at least the 
size of the osd_state over again since we're making a copy. Maybe the only 
way that would make sense would be to track them seperately from "go", but 
then all the code touching osd_state would have to get more complicated. 
I'm just poking around in mon's status reporting, so it makes sense to to 
keep it local. Thanks!

WRT my other email, I'm indeed looking in a weird branch-- confusion 
unconfusifificated!

Appreciatively,

-Jesse
