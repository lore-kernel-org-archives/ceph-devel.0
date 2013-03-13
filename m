From: "Bryan K. Wright" <bkw1a@ayesha.phys.virginia.edu>
Subject: Re: How to set the number of pgs when using mkcephfs?
Date: Wed, 13 Mar 2013 14:31:34 -0400
Message-ID: <201303131831.r2DIVYpx030967@ayesha.phys.virginia.edu>
Reply-To: bkw1a@ayesha.phys.virginia.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ayesha.phys.Virginia.EDU ([128.143.102.43]:39877 "EHLO
	ayesha.phys.virginia.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932346Ab3CMSbf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Mar 2013 14:31:35 -0400
Received: from ayesha.phys.virginia.edu (localhost [127.0.0.1])
	by ayesha.phys.virginia.edu (8.14.4/8.14.4) with ESMTP id r2DIVYpx030967
	for <ceph-devel@vger.kernel.org>; Wed, 13 Mar 2013 14:31:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi again,

	Sorry, I finally figured it out based on comments here:

	http://en.usenet.digipedia.org/thread/11905/7191/

"num_pgs = num_osds << osd_pg_bits".  Ah.  OK, so I can now 
adjust the number of placement groups by fiddling with 
"osd pg bits" in ceph.conf.

					Bryan

-- 
========================================================================
Bryan Wright              |"If you take cranberries and stew them like 
Physics Department        | applesauce, they taste much more like prunes
University of Virginia    | than rhubarb does."  --  Groucho 
Charlottesville, VA  22901|			
(434) 924-7218            |         bryan@virginia.edu
========================================================================


