From: Loic Dachary <loic@dachary.org>
Subject: Adding / removing OSDs with weight set
Date: Fri, 26 May 2017 09:43:42 +0300
Message-ID: <e794a980-b701-a8b1-a2ee-b0f13bd23831@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:47072 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763310AbdEZGns (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 26 May 2017 02:43:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Sage,

If weight set are created and updated, either offline via "crush optimize" (possible now) or via a ceph-mgr task (hopefully in the future), adding and removing OSDs won't work via the ceph cli (CrushWrapper errors out on create_or_move_item which is what osd crush create-or-move needs, for instance).

Requiring a workflow where OSDs must be added to the crushmap instead of the usual ceph osd crush create-or-move is impractical. Instead, create_or_move_item should be modified to update the weight sets, if any. What we could not figure out a few weeks ago is which values make sense for a newly added OSD.

Assuming the weight set are updated via an incremental rebalancing process, I think the weight set of a new OSD should simply be zero for all positions and the target weight is set as usual. The next time the rebalancing process runs, it will set the weight set to the right value and backfilling will start. Or, if it proceeds incrementally, it will gradually increase the weight set until it reaches the optimal value. From the user perspective, the only difference is that backfilling does not happen right away, it has to wait for the next rebalancing update.

Preparing an OSD to be decomissionned can be done by setting the target weight to zero. The rebalancing process will (gradually or not) set the weight set to zero and all PGs will move out of the OSD.

What do you think ?

Cheers

-- 
Loïc Dachary, Artisan Logiciel Libre
