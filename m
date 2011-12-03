From: Sage Weil <sage@newdream.net>
Subject: Re: OSD auto weights
Date: Sat, 3 Dec 2011 14:34:19 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1112031426180.29551@cobra.newdream.net>
References: <4EDA6D28.9060005@cs.ucsc.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:51325 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911Ab1LCWeU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 3 Dec 2011 17:34:20 -0500
In-Reply-To: <4EDA6D28.9060005@cs.ucsc.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@cs.ucsc.edu>
Cc: ceph-devel@vger.kernel.org

On Sat, 3 Dec 2011, Noah Watkins wrote:
> We have a cluster with disks that have large differences in performance. I
> noticed that wiki page on OSD auto weights
> (http://ceph.newdream.net/wiki/Osd_auto_weight), but it seems to have been
> last updated in 2008. Are there any developments in this area or recommended
> techniques for setting up weights?

It looks like the old code is mostly usable.  The basic idea is that the 
OSD provides the monitor with a weight when it joins the cluster.  On 
mkfs, ceph-osd times how long it takes to write 1 GB and calculates a 
weight based on that.  

The real problem is that the weights aren't normalized, so the calculation 
should be parameterized so that you can specify the expected 
performance that should be 1.0 and have anything less than that be 
proportionally smaller.  (Currently it adjusts the osdmap weight, which is 
in [0,1].)  Alternatively, it could adjust the crush weight, which will 
probably behave better in the long run.

If you just need to kludge something together to make this work now, I'd 
adjust the current code.  Long term, this should go in the osd addition 
code that will eventually by triggered (by chef or udev or an admin) when 
a new osd is added.  Then the process would look like:

 - identify the device(s) for the osd data, journal
 - benchmark it
 - allocate a new osd id (ceph osd create)
 - ceph-osd --mkfs
 - add osd to crush map with appropriate weight (based on benchmark results)
 - start ceph-osd

sage
