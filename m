From: Sage Weil <sage@newdream.net>
Subject: Re: Disk utilisation
Date: Mon, 21 Jun 2010 09:02:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006210852560.27038@cobra.newdream.net>
References: <7F0D01755BF855478E2847A50C09FA4DD1A0A94DF4@HERMES8.ds.leeds.ac.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51268 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757152Ab0FUQB5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 21 Jun 2010 12:01:57 -0400
In-Reply-To: <7F0D01755BF855478E2847A50C09FA4DD1A0A94DF4@HERMES8.ds.leeds.ac.uk>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christopher McLean <C.J.McLean@leeds.ac.uk>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

On Mon, 21 Jun 2010, Christopher McLean wrote:
> Hi,
> 
> Going to cut to the chase on this. I'm pretty sure that this is not the 
> correct place to ask, but the IRC channel is quiet and we can find no 
> other sources of information - sorry in advance!
> 
> we've been hunting for some stats on ceph, notably disk utilisation e.g. 
> given 3 servers providing 100Gb each to the cluster, how much useable 
> space would be available after management/redundancy overheads? Can't 
> find anything of relevance online. needing the info for a comparative 
> study into costs for deploying ceph
> 
> any help/pointers/references would be of great help!

Generally speaking, you need to account for 2x replication, btrfs 
overhead, cosd overhead (contents of $osd_data/current/meta directory), 
and the pseudorandom distribution.

The last one is the trickiest.  Because data is placed based on a hash, 
there will be some natural variance is osd utilization, which will depend 
on the total number of objects and osds.  There is a facility in crush to 
adjust the distribution to correct for that natural variance, but ceph 
isn't using it yet.

I would probably allow for 10% utilization variance for a smallish cluster 
and maybe another 10% for the rest to be safe.  Something along the lines 
of total_disk * .8 / replication_level?  You generally shouldn't fill any 
file system beyond 80% or 90% anyway and expect it to perform well.

sage
