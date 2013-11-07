From: Sage Weil <sage@inktank.com>
Subject: cache tier blueprint (part 2)
Date: Thu, 7 Nov 2013 06:56:34 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311070653290.17943@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42327 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751824Ab3KGO4f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Nov 2013 09:56:35 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: greg@inktank.com, ceph-devel@vger.kernel.org

I typed up what I think is remaining for the cache tier work for firefly.  
Greg, can you take a look?  I'm most likely missing a bunch of stuff here.

 http://wiki.ceph.com/01Planning/02Blueprints/Emperor/rados_cache_pool_(part_2)

This will be one of the meatier sessions at the upcoming CDS.  There will 
be a fair bit of work not just on the OSD side but also in building 
testing tools that exercise and validate the functionality, here, that 
may be a great way for a new contributer to get involved and help out.

sage
