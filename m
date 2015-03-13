From: Sage Weil <sage@newdream.net>
Subject: Re: Localized reads (RADOS/RBD)
Date: Fri, 13 Mar 2015 16:26:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1503131623310.30090@cobra.newdream.net>
References: <531034849-1426286330-cardhu_decombobulator_blackberry.rim.net-1702012346-@b15.c5.bise7.blackberry>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36662 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625AbbCMX0g (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Mar 2015 19:26:36 -0400
In-Reply-To: <531034849-1426286330-cardhu_decombobulator_blackberry.rim.net-1702012346-@b15.c5.bise7.blackberry>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Charles 'Boyo <charlesboyo@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 13 Mar 2015, Charles 'Boyo wrote:
> Hello all.
> 
> When, if ever, will Ceph clients have the ability to prefer certain 
> OSDs/hosts over others?
> 
> I am running 3 replica pools across 3 data centers connected by 
> relatively narrow links. Writes have to travel out anyway but I'd prefer 
> to keep reads local.
> 
> The thinking is that since all writes are synchronous across all 
> replicas, it should be okay to read from a secondary that is nearer, 
> faster or lightly loaded instead of reaching out to the primary at all 
> times.
> 
> Can this be done with a CRUSH tweak?
> Any ideas?

All of the logic to do this is in place on the client side, including the 
ability to choose teh replica closest to the client based on distance 
within the CRUSH hierarchy (based on nearest shared ancestor).

What's missing is some additional work on the OSD side to make sure that 
these reads are safe when they race with writes or (I believe) when the 
cluster us undergoing some sort of rebalancing.  There are a few tickets 
in the tracker for these issues.

The first step to track them down would be to extend teh ceph_test_rados 
tool to issue reads to replicas, and then to issue racing reads and 
writes.  With the testing tools in place we can build some confidence that 
our fixes our correctly and that we've addressed all the issues...

sage

