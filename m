From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: Slow ceph fs performance
Date: Mon, 29 Oct 2012 11:08:25 -0400
Message-ID: <201210291508.q9TF8P18020879@ayesha.phys.virginia.edu>
References: <alpine.DEB.2.00.1210040823250.23556@cobra.newdream.net>
 <201210041554.q94FsdHG021382@ayesha.phys.virginia.edu>
 <CAPYLRzh=xCNWeHyLVpcJH3Vzy1PeBCkaibXNSQO2L7_=g64Ufw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:55202 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab2J2PI2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Oct 2012 11:08:28 -0400
In-reply-to: <CAPYLRzh=xCNWeHyLVpcJH3Vzy1PeBCkaibXNSQO2L7_=g64Ufw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: bryan@virginia.edu, ceph-devel@vger.kernel.org


greg@inktank.com said:
> Eeek, I was going through my email backlog and came across this thread again.
> Everything here does look good; the data distribution etc is pretty
> reasonable. If you're still testing, we can at least get a rough idea of the
> sorts of IO the OSD is doing by looking at the perfcounters out of the admin
> socket: ceph --admin-daemon /path/to/socket perf dump (I believe the default
> path is /var/run/ceph/ceph-osd.*.asok)

Hi Greg,

	Thanks for your help.  I've been experimenting with other things,
so the cluster has a different arrangement now, but the performance
seems to be about the same.  I've now broken down the RAID arrays into
JBOD disks, and I'm running one OSD per disk, recklessly ignoring
the warning about syncfs being missing.  (Performance doesn't seem
any better or worse than it was before when rsyncing a large directory
of small files.)  I've also added another osd node into the mix, with
a different disk controller.

	For what it's worth, here are "perf dump" outputs for a
couple of OSDs running on the old and new hardware, respectively:

http://ayesha.phys.virginia.edu/~bryan/perf.osd.200.txt
http://ayesha.phys.virginia.edu/~bryan/perf.osd.100.txt

If you could take a look at them and let me know if you see
anything enlightening, I'd really appreciate it.

					Thanks,
					Bryan

-- 
========================================================================
Bryan Wright              |"If you take cranberries and stew them like 
Physics Department        | applesauce, they taste much more like prunes
University of Virginia    | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901|			
(434) 924-7218            |         bryan@virginia.edu
========================================================================


