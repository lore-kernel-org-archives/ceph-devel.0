From: Sage Weil <sage@inktank.com>
Subject: exposing tiers via librados
Date: Mon, 29 Sep 2014 14:54:38 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409291447330.19043@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49224 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335AbaI2Vyi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 17:54:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: adamcrume@gmail.com, ceph-devel@vger.kernel.org

I took another look at the pull request for exposing tiers via librados[1] 
and while it looks almost entirely correct, I'm not sure this is the 
approach we should take.  :( We expose all of this via the monitor API 
(json commands to rados_mon_command() for via cli/rest/etc), so it is 
awkward to replicate all of that via a low-level C API.

Intead, I think we should look to the minimal amount of metadata we need 
to expose in order to get the job done (in this case, know which pools to 
skip for the librbd check).  After chatting with Josh he suggests

 int64_t rados_get_base_tier(int64_t pool);

For a non-tiered pool, this would return pool.  For a tiered pool, it 
would return the pool that is logically associated with the data set... 
the one you should read/write from.

I *think* that's sufficiently general that is should be future-proof to 
whatever tiering changes we make later.  Is there any tiering use-case 
that would not be well-defined for?  Or, are there other general questions 
a librados-using app might be expected to need to know about tiering 
topology?  In general we want the tiering to be unnoticed by librados 
users.  Maybe whether we can expect a list_objects operation to return a 
complete set?  (This is one of the few portions of the librados API that 
isn't papered over by tiering, although I suppose it could be.)

sage


[1] https://github.com/ceph/ceph/pull/2552
