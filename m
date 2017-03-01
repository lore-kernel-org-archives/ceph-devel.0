From: Sage Weil <sweil@redhat.com>
Subject: Re: documenting crush tunables & rule step set_*
Date: Wed, 1 Mar 2017 00:38:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1703010031490.25760@piezo.novalocal>
References: <5d566eae-660d-8975-453b-c8c9cac820b0@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46960 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751446AbdCAAij (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 28 Feb 2017 19:38:39 -0500
In-Reply-To: <5d566eae-660d-8975-453b-c8c9cac820b0@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, 1 Mar 2017, Loic Dachary wrote:
> Hi Sage,
> 
> While reading the implementation and the commits related to crush 
> tunables & rule step set_* I got the impression that vary_r[1] 
> introduced early 2014 is a better solution than local_fallback_tries 
> etc. [2] introduced around 2012. Both are helping to select an 
> alternative item when there is a collision.

Yeah, although if memory serves local_fallback_tries was part of the 
original CRUSH code. The problem with the local retry was that it skews 
data toward drives that are close to an 'out' drive in the hierarchy.  
I.e., if you have 12-drive server and mark one of them out, the other 11 
get most of the data instead.  That's clearly not optimal, which is why 
that local retries now defaults to 0.  (Caleb figured this out when he was 
doing his analysis back in 2012 or 2013.)
 
> If that's not the case I'll try to research the motivation to set 
> local_fallback_retries = 1 instead of the default value 0 it has in 
> tunables since bobtail[3]. And although nothing forbids using 
> local_fallback_tries = 1 & vary_r = 1, it looks like the vary_r 
> implementation did not take into account that combination.

Yeah; the assumption is that local fallback tries should never be used 
except for compatibility with old maps with old tunables.

I honestly don't remember exactly what motivated me to do the local 
fallback.. I think it seemed intuitive at the time, but in retrospect is 
not a good idea.

The vary_r was added to address a different specific issue: when using 
chooseleaf, we do the first level choice (say, a rack) and then 
recursively pick a disk nested beneath it.  The problem was that we'd 
collide in the second choice (disk), increment r, and try again... but if 
we picked the same rack the recursive call to choose a disk would use the 
original r value and inevitabl collide again.

Chooseleaf was introduced after fallback_local_tries, so the motivation 
was different...

sage
