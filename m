From: Sage Weil <sage@newdream.net>
Subject: Re: A issue in straw2 , maybe it`s not a problem
Date: Mon, 3 Aug 2015 10:31:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1508031022060.17225@cobra.newdream.net>
References: <CAA-rZjaWe-6K7BOjT3RmqVvnoBNjheuX5xphyMY+KTGSR+PELg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43060 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754821AbbHCRbT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Aug 2015 13:31:19 -0400
In-Reply-To: <CAA-rZjaWe-6K7BOjT3RmqVvnoBNjheuX5xphyMY+KTGSR+PELg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chen kael <chenji.bupt@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Mon, 3 Aug 2015, chen kael wrote:
> Hi,everyone
> 
>     recently,I want to migrate our on-line cluster from straw to
> straw2,because if I add or remove some osds,too much objects are to be
> replaced than it should be.
> 
>     I have a confusing in using straw2, because straw2 should have a
> character that if an item's weight was adjusted up or down, mappings
> would either
> move to or from the adjusted item, but never between other unmodified
> items in the bucket.
> 
>     However after I do the test below , I still find pgs move from
> unmodified items,I am not sure whether this is normal.

It is normal.  It's not really straw2's fault (it's doing what it 
should) but an artifact of the way CRUSH works.  See below...

>         old                                        new
> CRUSH rule 0 x 759 [5,2,1]                CRUSH rule 0 x 759 [0,4,3]

What CRUSH actually does for the old map is:

 - with r=0 we pick 5 (ok)
 - with r=1 we get 5 (dup, try again)
 - with r=2 we get 5 (dup, try again)
 - with r=3 we get 2 (ok)
 - with r=4 we get 5 (dup, try again)
 - with r=5 we get 1 (ok)
 -> [5,2,1]

When we do the new map, it's luckier:

 - with r=0 we pick 0 (ok)   (was 5 before)
 - with r=1 we pick 4 (ok)   (was 5 before)
 - with r=2 we pick 3 (ok)   (was 5 before)
 -> [0,4,3]

For any given draw (r= value), we will follow the rule that item either 
stays the same or switches to or from the reweighted item (5).  But for 
anything later in the sequence we may be at high values of r because we've 
had to retry (due to dups, or OSDs being marked out), and any change 
earlier in the sequence may mean that we have a different number of 
retries.  Here, positions 2 and 3 were r=3 and r=5 because of dups, but 
those don't happen with the new map and those positions are r=1 and r=2.  

Note that straw2's promise remains true, though: for r=0, 1, and 2, the 
value switches away from 5 but no non-5 value changes.  If we had 
num_rep=6, we would have seen the new map still choose 2 for r=3 
and 1 for r=5 (although they would have landed in different positions).

> Conclusion:
> 
> If the osd.5 is the primary osd,or second osd in a pg, then other osd
> behind osd.5 are still possible to be switched out,Is this what straw2
> really want achieve?

Correct.  It's not ideal, but I don't think it's avoidable, because it is 
not an independent decision process for every position of the sequence... 
our choice is constrained to items that we haven't chosen before.

sage
