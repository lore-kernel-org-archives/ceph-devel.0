From: Loic Dachary <loic@dachary.org>
Subject: Proposal for a CRUSH collision fallback
Date: Sun, 7 May 2017 20:45:42 +0200
Message-ID: <af0b13a9-cb6c-fccf-c80a-52a15ed8a328@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:50882 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751295AbdEGWNh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sun, 7 May 2017 18:13:37 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by slow1-d.mail.gandi.net (Postfix) with ESMTP id CEDDE47E1B8
        for <ceph-devel@vger.kernel.org>; Sun,  7 May 2017 20:45:46 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

When choosing the second replica, crush_bucket_choose picks an item and crush_choose_{indep,firstn} checks if it has already been chosen for the first replica. If so, it is discarded as a collision[1], r is modified and another attempt is made to get a different item. If no value is found after choose_tries attempt, the mapping is incomplete.

Another way to do the same would be that crush_bucket_choose / bucket_straw2_choose[2] ignores the items that have already been chosen. It could be done by looping over the list but that would mean N (number of replicas) lookups for each item.

The current implementation is optimized for the cases where collisions are rare. However, when the weights of the items are two order of magnitude appart or more, choose_tries has to be set to a very large value (more than 1000) for the mapping to succeed. In practice that is not a problem as it is unlikely that a host is 100 times bigger than another host ;-)

When fixing an uneven distribution[3], CRUSH weights are sometime set to values with that kind of difference (1 against 100) to compensate for the probability bias and/or a small number of samples. For instance when there are 5 hosts with weights 5 1 1 1 1, modifying the weight set fails. It goes as far as 8.9, 0.01, 0.01, 0.01, 0.01 with choose_tries 2000. The value of choose_tries has to be increased a lot for a gain that is smaller and smaller and the CPU usage goes up. In this situation, an alternative implementation of the CRUSH collision seems a good idea.

Instead of failing after choose_tries attempts, crush_bucket_choose could be called with the list of already chosen items and loop over them to ensure none of them are candidate. The result will always be correct but the implementation more expensive. The default choose_tries could even be set to a lower value (19 instead of 50 ?) since it is likely more expensive to handle 30 more collisions rather than looping over each item already selected.

What do you think ?

Cheers

P.S. Note that even in this border case modifying the weights to 7.1, 0.5, 0.5, 0.4, 0.4 significantly improves the distribution (twice better instead of ten times better). Only it cannot do better because it hits a limitation of the current CRUSH implementation. But it looks like it is not too difficult to fix.


[1] https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L541
[2] https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L332
[3] http://marc.info/?l=ceph-devel&m=149407691823750&w=2
-- 
Loïc Dachary, Artisan Logiciel Libre
