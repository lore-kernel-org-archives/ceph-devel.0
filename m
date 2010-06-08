From: Sage Weil <sage@newdream.net>
Subject: Re: ceph, slow (cheap) and fast (expensive) storage?
Date: Tue, 8 Jun 2010 11:03:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1006081051520.15202@cobra.newdream.net>
References: <4C0E1BAC.8070306@wpkg.org> <huldph$fmu$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44818 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755061Ab0FHSCr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Jun 2010 14:02:47 -0400
In-Reply-To: <huldph$fmu$1@dough.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thomas Mueller <thomas@chaschperli.ch>
Cc: ceph-devel@vger.kernel.org

On Tue, 8 Jun 2010, Thomas Mueller wrote:
> I would not expect to be the fast (expensive) storage to be that faster 
> in a ceph cluster. if you get enough cheap storage nodes it will scale 
> with the amount of disks/nics as the date is striped among all the nodes 
> (osd's). But this is just my speculation.
> 
> if you have some amount storage nodes and you are on GigE you will hit 
> the ethernet limit on the client faster than anything else. 

You can also think of "fast" and "slow" in terms of the ratio of io 
bandwidth to capacity on each individual device.  For example you can use 
lots of SATA disks in parallel to get more IOPs and throughput, but the 
platters will be mostly empty.  It's often a question of how much total 
data you have and how much IO to it you need to serve. 

Of course, there are also absolute performance considerations (SSD read 
latencies are lower than a disk), so both factors should be considered.

sage
