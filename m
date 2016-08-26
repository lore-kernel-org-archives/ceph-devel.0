From: Sage Weil <sweil@redhat.com>
Subject: bluestore blobs
Date: Fri, 26 Aug 2016 17:51:57 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608261747440.24244@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57964 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751643AbcHZR7b (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 Aug 2016 13:59:31 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: allen.samuels@sandisk.com
Cc: ceph-devel@vger.kernel.org

Hi Allen,

The "blobs must be confined to a extent map shard" rule is still somewhat 
unsatisfying to me.  There's another easy possibility, though: we 
allow blobs to span extent map shards, and when they do, we stuff them 
directly in the onode.  The number of such blobs will always be small 
(no more than the number of extent map shards), so I don't think size is a 
concern.  And we'll always already have them loaded up when we bring any 
particular shard in, so we don't need to worry about any additional 
complexity around paging them in.  And we avoid the slightly annoying cut 
points on compressed extents when they cross such boundaries.

This also avoids some of the tuning practicalities that were annoying me 
(does a global config option control where the enforced cut points are?  
what happens if that changes on an existing store?)

sage
