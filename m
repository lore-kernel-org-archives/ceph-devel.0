From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: OSD memory usage
Date: Thu, 28 Feb 2013 13:57:44 -0500
Message-ID: <201302281857.r1SIvikH000790@ayesha.phys.virginia.edu>
Reply-To: bkw1a@ayesha.phys.virginia.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:50431 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752805Ab3B1S5q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Feb 2013 13:57:46 -0500
Received: from ayesha.phys.virginia.edu (localhost [127.0.0.1])
	by ayesha.phys.virginia.edu (8.14.4/8.14.4) with ESMTP id r1SIvikH000790
	for <ceph-devel@vger.kernel.org>; Thu, 28 Feb 2013 13:57:45 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi folks,

	I've been looking into my problem with OSDs that use
up a lot of memory.  Let running, I've seen them swell to 
over 8 GB of resident memory.  I'd really like to have some
way of limiting the maximum memory footprint of an OSD.
Is there a knob to do this?

	I've just today recompiled ceph-osd with tcmalloc
turned on, so I could do some memory profiling.  (The RPMS
from ceph.com don't have it turned on.)  Here's an example
of what I see from pprof:

http://ayesha.phys.virginia.edu/~bryan/junk2.pdf

Any suggestions would be appreciated.

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


