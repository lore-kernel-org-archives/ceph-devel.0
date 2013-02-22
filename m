From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: OSD memory usage
Date: Fri, 22 Feb 2013 15:26:16 -0500
Message-ID: <201302222026.r1MKQGQI022115@ayesha.phys.virginia.edu>
Reply-To: bkw1a@ayesha.phys.virginia.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:57177 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101Ab3BVU0R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Feb 2013 15:26:17 -0500
Received: from ayesha.phys.virginia.edu (localhost [127.0.0.1])
	by ayesha.phys.virginia.edu (8.14.4/8.14.4) with ESMTP id r1MKQGQI022115
	for <ceph-devel@vger.kernel.org>; Fri, 22 Feb 2013 15:26:16 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

	I was having trouble with OSDs crashing under ceph 0.56.2
(CentoOS, 64-bit, installed from rpms, using the "elrepo" kernel),
so I eagerly installed 0.56.3.  Since then, I've been having a lot
of trouble getting the OSDs running, either because of previous
crashes or because of some change in 0.56.3.

	What's happening now is that the OSD processes are using
so much memory that the machines start swapping, and eventually
die.  Today, I tried systematically starting up a few OSDs at
a time and watching memory usage.  The processes climb pretty
quickly up to 2-3 GB in RSIZE.  If I let them run for a while and
then restart them, I find that they tend to settle into an RSIZE
of about 1.5 GB.  Unfortunately, I don't seem to have any records
of how big these processes were under 0.56.2, but this is way
too big to fit into the memory available, when I start up all of
the OSD processes.  My impression was that the sizes used to
be well under 1 GB  when the cluster was idle.

	Is there anything I can do to reduce the memory
footprint of ceph-osd?

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


