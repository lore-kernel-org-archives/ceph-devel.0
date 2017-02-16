From: Sage Weil <sage@newdream.net>
Subject: Re: Staggered failing of OSDs and mon_osd_down_out_subtree_limit
Date: Thu, 16 Feb 2017 14:27:30 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702161426360.7782@piezo.novalocal>
References: <432482903.10105.1487240412669@ox.pcextreme.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:41624 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932075AbdBPO1d (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 16 Feb 2017 09:27:33 -0500
In-Reply-To: <432482903.10105.1487240412669@ox.pcextreme.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 16 Feb 2017, Wido den Hollander wrote:
> Hi,
> 
> I'm looking to implement a additional config setting which goes together 
> with mon_osd_down_out_subtree_limit.
> 
> In this case I have 'mon_osd_down_out_subtree_limit' set to 'host' to 
> prevent a whole host from being marked as out when it fails.
> 
> I ran in to the situation where not all OSDs failed at the same time, 
> but staggered. The disk controller was giving issues and slowly on OSD 
> after the other started to fail. This meant that they were not all being 
> marked as out in the same window of mon_osd_down_out_interval (3600), 
> but after that.
> 
> When the whole host fails at once none of the OSDs are marked as out. 
> This is very easy to reproduce on VMs. Just stop the OSDs on by one with 
> a interval in between.
> 
> Only the last OSD was not marked as out since that meant the whole 
> subtree would be marked as out.
> 
> I am thinking of mon_osd_down_out_subtree_max_osd
> 
> The default would be zero, but anything greater then zero would mean the 
> MON would check if there are not already X OSDs out in the same subtree 
> before marking it as out.
> 
> It would log to clog with a WRN message saying it will not mark these 
> OSDs as out since it would go over the limit of OSDs inside that 
> subtree.
> 
> Does this sound like a sane thing to implement?

Sounds sane to me!

sage
