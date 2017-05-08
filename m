From: Sage Weil <sweil@redhat.com>
Subject: Re: Proposal for a CRUSH collision fallback
Date: Mon, 8 May 2017 03:09:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1705080304000.3646@piezo.novalocal>
References: <af0b13a9-cb6c-fccf-c80a-52a15ed8a328@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1270176900-1494212971=:3646"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33803 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbdEHDJc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sun, 7 May 2017 23:09:32 -0400
In-Reply-To: <af0b13a9-cb6c-fccf-c80a-52a15ed8a328@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1270176900-1494212971=:3646
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Sun, 7 May 2017, Loic Dachary wrote:
> Hi Sage,
> 
> When choosing the second replica, crush_bucket_choose picks an item and 
> crush_choose_{indep,firstn} checks if it has already been chosen for the 
> first replica. If so, it is discarded as a collision[1], r is modified 
> and another attempt is made to get a different item. If no value is 
> found after choose_tries attempt, the mapping is incomplete.
> 
> Another way to do the same would be that crush_bucket_choose / 
> bucket_straw2_choose[2] ignores the items that have already been chosen. 
> It could be done by looping over the list but that would mean N (number 
> of replicas) lookups for each item.
> 
> The current implementation is optimized for the cases where collisions 
> are rare. However, when the weights of the items are two order of 
> magnitude appart or more, choose_tries has to be set to a very large 
> value (more than 1000) for the mapping to succeed. In practice that is 
> not a problem as it is unlikely that a host is 100 times bigger than 
> another host ;-)
> 
> When fixing an uneven distribution[3], CRUSH weights are sometime set to 
> values with that kind of difference (1 against 100) to compensate for 
> the probability bias and/or a small number of samples. For instance when 
> there are 5 hosts with weights 5 1 1 1 1, modifying the weight set 
> fails. It goes as far as 8.9, 0.01, 0.01, 0.01, 0.01 with choose_tries 
> 2000. The value of choose_tries has to be increased a lot for a gain 
> that is smaller and smaller and the CPU usage goes up. In this 
> situation, an alternative implementation of the CRUSH collision seems a 
> good idea.
> 
> Instead of failing after choose_tries attempts, crush_bucket_choose 
> could be called with the list of already chosen items and loop over them 
> to ensure none of them are candidate. The result will always be correct 
> but the implementation more expensive. The default choose_tries could 
> even be set to a lower value (19 instead of 50 ?) since it is likely 
> more expensive to handle 30 more collisions rather than looping over 
> each item already selected.
> 
> What do you think ?

I think this direction is promising!  The problem is that I think it's not 
quite as simple as you suggest, since you may be choosing over multiple 
levels of a hierarchy.  If the weight tree is something like

      4
    /   \
   2     2
  / \   / \
 1   1 1   1
 a   b c   d

and you chose a, then yes, if you get back into the left branch you can 
filter it out of the straw2 selections.  And num_rep is usually small so 
that won't be expensive.  But you also need the first choice at the top 
level of the hierarchy to weight the left *tree* with 1 instead of 2.

I think this could be done by adjusting the hierarchical weights as you go 
(and I think one of Adam's early passes at the multipick problem did 
something similar), but it's a bit more complex.

It seems worth pursuing, though!

And dynamically doing this only after the first N 'normal' attempts fail 
seems like a good way to avoid slowing down the common path (no 
collisions).  I suspect the optimal N is probably closer to 5 than 19, 
though?

sage


> 
> Cheers
> 
> P.S. Note that even in this border case modifying the weights to 7.1, 
> 0.5, 0.5, 0.4, 0.4 significantly improves the distribution (twice better 
> instead of ten times better). Only it cannot do better because it hits a 
> limitation of the current CRUSH implementation. But it looks like it is 
> not too difficult to fix.
> 
> 
> [1] https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L541
> [2] https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L332
> [3] http://marc.info/?l=ceph-devel&m=149407691823750&w=2
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
> 
--8323329-1270176900-1494212971=:3646--
