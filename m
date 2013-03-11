From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Estimating OSD memory requirements (was Re: stuff for v0.56.4)
Date: Mon, 11 Mar 2013 11:10:30 -0400
Message-ID: <201303111510.r2BFAUcx011721@ayesha.phys.virginia.edu>
References: <alpine.DEB.2.00.1303071326430.17054@cobra.newdream.net>
Reply-To: bkw1a@ayesha.phys.virginia.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:51678 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753130Ab3CKPKc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 11:10:32 -0400
In-reply-to: Your message of "Thu, 07 Mar 2013 13:27:18 PST."
             <alpine.DEB.2.00.1303071326430.17054@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

sage@inktank.com said:
> On Thu, 7 Mar 2013, Bryan K. Wright wrote:
> 
> sage@inktank.com said:
> > - pg log trimming (probably a conservative subset) to avoid memory bloat 
> 
> Anything that reduces the size of OSD processes would be appreciated.
> You can probably do this with just
>  log max recent = 1000
> By default it's keeping 100k lines of logs in memory, which can eat a lot  of
> ram (but is great when debugging issues).

	Thanks for the tip about "log max recent".  I've made this 
change, but it doesn't seem to significantly reduce the size of the 
OSD processes.

	In general, are there some rules of thumb for estimated the
memory requirements for OSDs?  I see processes blow up to 8gb of 
resident memory sometimes.  If I need to allow for that much memory
per OSD process, I may have to just walk away from ceph.

	Does the memory usage scale with the size of the disks?
I've been trying to run 12 OSDs with 12 2TB disks on a single box.
Would I be better off (memory-usage-wise) if I RAIDed the disks
together and used a single OSD process?

	Thanks for any advice.

					Bryan


-- 
========================================================================
Bryan Wright              |"If you take cranberries and stew them like 
Physics Department        | applesauce, they taste much more like prunes
University of Virginia    | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901|			
(434) 924-7218            |         bryan@virginia.edu
========================================================================


