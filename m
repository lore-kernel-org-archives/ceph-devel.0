From: Wido den Hollander <wido@42on.com>
Subject: Re: OSD journal sizing
Date: Thu, 22 Sep 2016 22:09:36 +0200 (CEST)
Message-ID: <286736255.4752.1474574976512@ox.pcextreme.nl>
References: <90b637e7-8cac-ab6e-2363-65eb83760c2d@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp01.mail.pcextreme.nl ([109.72.87.137]:46890 "EHLO
        smtp01.mail.pcextreme.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934268AbcIVUJk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Sep 2016 16:09:40 -0400
In-Reply-To: <90b637e7-8cac-ab6e-2363-65eb83760c2d@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, ceph-devel@vger.kernel.org


> Op 22 september 2016 om 22:02 schreef Nathan Cutler <ncutler@suse.cz>:
> 
> 
> I've been researching OSD journals lately, and just realized something 
> that's not particularly nice.
> 
> SSDs are getting bigger and bigger. It's typical for customers to use 
> e.g. a 500GB SSD for their journals. If the OSDs themselves are on 
> spinners, there is no use in having journals bigger than 10GB because 
> the 7200 RPMs impose a hard ceiling on throughput that spinners can achieve.
> 
> Now, SSDs need wear-leveling to avoid premature failure. If only a small 
> region of the SSD is partitioned/used, users may fear (regardless of the 
> reality, whatever it may be) that this small region will be "pummeled to 
> death" by Ceph and cause the expensive SSD to fail prematurely.
> 

You are making the wrong assumption here. If you take a brand-new SSD which has never been written to and you create just a few small 10GB partitions the SSD's controller will know that all other cells are still unused.

Using wear-leveling it will reallocate cells internally. You will not be hammering the same cells over and over.

Bigger SSDs simply have a longer lifespan.

You can use just a fraction of the disk by using partitions, or use hdparm to set HPA (Host Protected Area) where you "shrink" the SSD.

The SSD will present itself as a 50GB SSD for example while it is a 500GB SSD.

Using hdparm you can also reset a SSD by telling it to reset ALL it's cells back to zero. That way the wear-leveling is also reset.

Fyi, this information mainly comes from working with Intel DC SSDs.

Wido

> I *thought* this could be addressed by creating the journal partitions 
> large enough to fill the entire disk and using the "osd journal size" 
> parameter to limit how much disk capacity is actually used for 
> journaling, but now I just noticed that the "osd journal size" parameter 
> "is ignored if the journal is a block device, and the entire block 
> device is used."
> 
> And while working on http://tracker.ceph.com/issues/16878 it occurred to 
> me that large journals are not getting tested much. Is that a valid 
> assumption?
> 
> Next week I plan to attempt to make a reproducer for the bug, and then 
> try to come up with a patch to fix it. Any ideas/pointers, either here 
> or in the tracker, would be appreciated.
> 
> -- 
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
