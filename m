From: Nathan Cutler <ncutler@suse.cz>
Subject: OSD journal sizing
Date: Thu, 22 Sep 2016 22:02:54 +0200
Message-ID: <90b637e7-8cac-ab6e-2363-65eb83760c2d@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44837 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933737AbcIVUDB (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 22 Sep 2016 16:03:01 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 83830ABDB
        for <ceph-devel@vger.kernel.org>; Thu, 22 Sep 2016 20:02:54 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've been researching OSD journals lately, and just realized something 
that's not particularly nice.

SSDs are getting bigger and bigger. It's typical for customers to use 
e.g. a 500GB SSD for their journals. If the OSDs themselves are on 
spinners, there is no use in having journals bigger than 10GB because 
the 7200 RPMs impose a hard ceiling on throughput that spinners can achieve.

Now, SSDs need wear-leveling to avoid premature failure. If only a small 
region of the SSD is partitioned/used, users may fear (regardless of the 
reality, whatever it may be) that this small region will be "pummeled to 
death" by Ceph and cause the expensive SSD to fail prematurely.

I *thought* this could be addressed by creating the journal partitions 
large enough to fill the entire disk and using the "osd journal size" 
parameter to limit how much disk capacity is actually used for 
journaling, but now I just noticed that the "osd journal size" parameter 
"is ignored if the journal is a block device, and the entire block 
device is used."

And while working on http://tracker.ceph.com/issues/16878 it occurred to 
me that large journals are not getting tested much. Is that a valid 
assumption?

Next week I plan to attempt to make a reproducer for the bug, and then 
try to come up with a patch to fix it. Any ideas/pointers, either here 
or in the tracker, would be appreciated.

-- 
Nathan Cutler
Software Engineer Distributed Storage
SUSE LINUX, s.r.o.
Tel.: +420 284 084 037
