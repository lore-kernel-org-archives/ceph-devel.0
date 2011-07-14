From: Sage Weil <sage@newdream.net>
Subject: Re: crashed+peering PGs
Date: Thu, 14 Jul 2011 09:12:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107140911020.29636@cobra.newdream.net>
References: <CAO47_--LHXGjiByanZi+-v27b4BPsd5dXTrPbhw9HNYLHymeOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34231 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755404Ab1GNQJ1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Jul 2011 12:09:27 -0400
In-Reply-To: <CAO47_--LHXGjiByanZi+-v27b4BPsd5dXTrPbhw9HNYLHymeOA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

Hi Christian,

The scrub/repair stuff only works once the PG is active (and, I think, 
clean).  These PGs are stuck in peering.  They all seem to be [3,13], so 
can you

- set debug osd = 20, debug ms = 1 on those two osds
- ceph osd down 3

to kick osd3?  It'll mark itself back up and the peering will restart.  
Then zip of the resulting logs (on 3 and 13) so we can see where it's 
getting stuck.

Thanks!
sage


On Thu, 14 Jul 2011, Christian Brunner wrote:

> After running into some btrfs problems I reformated all my disks. I
> did this in sequence. After every host I waited for the recovery to
> complete.
> 
> At one point an osd on another host crashed, but I was able to restart
> ist quickly.
> 
> After that process, the cluster has 6 crashed+peering PGs:
> 
> pg v4992886: 3712 pgs: 3706 active+clean, 6 crashed+peering; 571 GB
> data, 565 GB used, 58938 GB / 59615 GB avail
> 
> When I try to scrub or repair the PGs, nothing happens:
> 
> $ ceph pg dump -o - | grep crashed
> pg_stat objects mip     degr    unf     kb      bytes   log
> disklog state   v       reported        up      acting  last_scrub
> 1.1ac   0       0       0       0       0       0       0       0
>  crashed+peering 0'0     5869'576        [3,13]  [3,13]  0'0
> 2011-07-13 17:04:30.221618
> 0.1ad   0       0       0       0       0       0       198     198
>  crashed+peering 3067'1194       5869'515        [3,13]  [3,13]
> 3067'1194       2011-07-13 17:04:29.221726
> 2.1ab   0       0       0       0       0       0       0       0
>  crashed+peering 0'0     5869'576        [3,13]  [3,13]  0'0
> 2011-07-13 17:04:31.222145
> 1.6c    0       0       0       0       0       0       0       0
>  crashed+peering 0'0     5869'577        [3,13]  [3,13]  0'0
> 2011-07-13 17:05:35.237286
> 0.6d    0       0       0       0       0       0       198     198
>  crashed+peering 3067'636        5869'516        [3,13]  [3,13]
> 3067'636        2011-07-13 17:05:34.237024
> 2.6b    0       0       0       0       0       0       0       0
>  crashed+peering 0'0     5869'577        [3,13]  [3,13]  0'0
> 2011-07-13 17:05:37.238474
> 
> $ ceph pg scrub 1.1ac
> 2011-07-14 13:51:20.975887 mon <- [pg,scrub,1.1ac]
> 2011-07-14 13:51:20.976564 mon2 -> 'instructing pg 1.1ac on osd3 to scrub' (0)
> 
> But I don't see any message with "ceph -w".
> 
> Is there anything else I can try?
> 
> Thanks,
> Christian
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
