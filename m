From: Sage Weil <sweil@redhat.com>
Subject: Re: crush multipick anomaly
Date: Mon, 13 Feb 2017 19:16:18 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702131913070.7782@piezo.novalocal>
References: <alpine.DEB.2.11.1701260122190.6539@piezo.novalocal> <3554101b-4d10-e46b-93b0-f74794258f2e@dachary.org> <alpine.DEB.2.11.1702131417070.7782@piezo.novalocal> <3486c5b8-1d50-5762-c84a-8d1fcecaa775@dachary.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1224397778-1487013379=:7782"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55922 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751972AbdBMTQV (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 13 Feb 2017 14:16:21 -0500
In-Reply-To: <3486c5b8-1d50-5762-c84a-8d1fcecaa775@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1224397778-1487013379=:7782
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: 8BIT

On Mon, 13 Feb 2017, Loic Dachary wrote:
> Hi Sage,
> 
> I wrote a little program to show where objects are moving when a new disk is added (disk 10 below) and it looks like this:
> 
>         00     01     02     03     04     05     06     07     08     09     10 
> 00:      0     14     17     14     19     23     13     22     21     20   1800 
> 01:     12      0     11     13     19     19     15     10     16     17   1841 
> 02:     17     27      0     17     15     15     13     19     18     11   1813 
> 03:     14     17     15      0     23     11     20     15     23     17   1792 
> 04:     14     18     16     25      0     27     13      8     15     16   1771 
> 05:     19     16     22     25     13      0      9     19     21     21   1813 
> 06:     18     15     21     17     10     18      0     10     18     11   1873 
> 07:     13     17     22     13     16     17     14      0     25     12   1719 
> 08:     23     20     16     17     19     18     11     12      0     18   1830 
> 09:     14     20     15     17     12     16     17     11     13      0   1828 
> 10:      0      0      0      0      0      0      0      0      0      0      0 
> 
> before:  20164  19990  19863  19959  19977  20004  19926  20133  20041  19943      0 
> after:   18345  18181  18053  18170  18200  18190  18040  18391  18227  18123  18080 
> 
> 
> Each line shows how many objects moved from a given disk to the others 
> after disk 10 was added. Most objects go to the new disk and around 1% 
> go to each other disks. The before and after lines show how many objects 
> are mapped to each disk. They all have the same weight and it's using 
> replica 2 and straw2. Does that look right ?

Hmm, that doesn't look right.  This is what the CRUSH.straw2_reweight unit 
test is there to validate: that data on moves to or from the device whose 
weight changed.

It also follows from the straw2 algorithm itself: each possible choice 
gets a 'straw' length derived only from that item's weight (and other 
fixed factors, like the item id and the bucket id), and we select the max 
across all items.  Two devices whose weights didn't change will have the 
same straw lengths, and the max between them will not change.  It's only 
possible that the changed item's straw length changed and wasn't max and 
now is (got longer) or was max and now isn't (got shorter).

sage


> 
> Cheers
> 
> On 02/13/2017 03:21 PM, Sage Weil wrote:
> > On Mon, 13 Feb 2017, Loic Dachary wrote:
> >> Hi,
> >>
> >> Dan van der Ster reached out to colleagues and friends and Pedro 
> >> López-Adeva Fernández-Layos came up with a well written analysis of the 
> >> problem and a tentative solution which he described at : 
> >> https://github.com/plafl/notebooks/blob/master/replication.ipynb
> >>
> >> Unless I'm reading the document incorrectly (very possible ;) it also 
> >> means that the probability of each disk needs to take in account the 
> >> weight of all disks. Which means that whenever a disk is added / removed 
> >> or its weight is changed, this has an impact on the probability of all 
> >> disks in the cluster and objects are likely to move everywhere. Am I 
> >> mistaken ?
> > 
> > Maybe (I haven't looked closely at the above yet).  But for comparison, in 
> > the normal straw2 case, adding or removing a disk also changes the 
> > probabilities for everything else (e.g., removing one out of 10 identical 
> > disks changes the probability from 1/10 to 1/9).  The key property that 
> > straw2 *is* able to handle is that as long as the relative probabilities 
> > between two unmodified disks does not change, then straw2 will avoid 
> > moving any objects between them (i.e., all data movement is to or from 
> > the disk that is reweighted).
> > 
> > sage
> > 
> > 
> >>
> >> Cheers
> >>
> >> On 01/26/2017 04:05 AM, Sage Weil wrote:
> >>> This is a longstanding bug,
> >>>
> >>> 	http://tracker.ceph.com/issues/15653
> >>>
> >>> that causes low-weighted devices to get more data than they should. Loic's 
> >>> recent activity resurrected discussion on the original PR
> >>>
> >>> 	https://github.com/ceph/ceph/pull/10218
> >>>
> >>> but since it's closed and almost nobody will see it I'm moving the 
> >>> discussion here.
> >>>
> >>> The main news is that I have a simple adjustment for the weights that 
> >>> works (almost perfectly) for the 2nd round of placements.  The solution is 
> >>> pretty simple, although as with most probabilities it tends to make my 
> >>> brain hurt.
> >>>
> >>> The idea is that, on the second round, the original weight for the small 
> >>> OSD (call it P(pick small)) isn't what we should use.  Instead, we want 
> >>> P(pick small | first pick not small).  Since P(a|b) (the probability of a 
> >>> given b) is P(a && b) / P(b),
> >>>
> >>>  P(pick small | first pick not small)
> >>>  = P(pick small && first pick not small) / P(first pick not small)
> >>>
> >>> The last term is easy to calculate,
> >>>
> >>>  P(first pick not small) = (total_weight - small_weight) / total_weight
> >>>
> >>> and the && term is the distribution we're trying to produce.  For exmaple, 
> >>> if small has 1/10 the weight, then we should see 1/10th of the PGs have 
> >>> their second replica be the small OSD.  So
> >>>
> >>>  P(pick small && first pick not small) = small_weight / total_weight
> >>>
> >>> Putting those together,
> >>>
> >>>  P(pick small | first pick not small)
> >>>  = P(pick small && first pick not small) / P(first pick not small)
> >>>  = (small_weight / total_weight) / ((total_weight - small_weight) / total_weight)
> >>>  = small_weight / (total_weight - small_weight)
> >>>
> >>> This is, on the second round, we should adjust the weights by the above so 
> >>> that we get the right distribution of second choices.  It turns out it 
> >>> works to adjust *all* weights like this to get hte conditional probability 
> >>> that they weren't already chosen.
> >>>
> >>> I have a branch that hacks this into straw2 and it appears to work 
> >>> properly for num_rep = 2.  With a test bucket of [99 99 99 99 4], and the 
> >>> current code, you get
> >>>
> >>> $ bin/crushtool -c cm.txt --test --show-utilization --min-x 0 --max-x 40000000 --num-rep 2
> >>> rule 0 (data), x = 0..40000000, numrep = 2..2
> >>> rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
> >>>   device 0:             19765965        [9899364,9866601]
> >>>   device 1:             19768033        [9899444,9868589]
> >>>   device 2:             19769938        [9901770,9868168]
> >>>   device 3:             19766918        [9898851,9868067]
> >>>   device 6:             929148  [400572,528576]
> >>>
> >>> which is very close for the first replica (primary), but way off for the 
> >>> second.  With my hacky change,
> >>>
> >>> rule 0 (data), x = 0..40000000, numrep = 2..2
> >>> rule 0 (data) num_rep 2 result size == 2:       40000001/40000001
> >>>   device 0:             19797315        [9899364,9897951]
> >>>   device 1:             19799199        [9899444,9899755]
> >>>   device 2:             19801016        [9901770,9899246]
> >>>   device 3:             19797906        [9898851,9899055]
> >>>   device 6:             804566  [400572,403994]
> >>>
> >>> which is quite close, but still skewing slightly high (by a big less than 
> >>> 1%).
> >>>
> >>> Next steps:
> >>>
> >>> 1- generalize this for >2 replicas
> >>> 2- figure out why it skews high
> >>> 3- make this work for multi-level hierarchical descent
> >>>
> >>> sage
> >>>
> >>> --
> >>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >>> the body of a message to majordomo@vger.kernel.org
> >>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>
> >> -- 
> >> Loïc Dachary, Artisan Logiciel Libre
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>
> 
> -- 
> Loïc Dachary, Artisan Logiciel Libre
> 
--8323329-1224397778-1487013379=:7782--
