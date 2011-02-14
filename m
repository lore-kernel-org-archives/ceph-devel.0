From: Sage Weil <sage@newdream.net>
Subject: librados api cleanup
Date: Mon, 14 Feb 2011 15:00:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1102141453450.20210@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36877 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099Ab1BNW6x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Feb 2011 17:58:53 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 88CD4BC728
	for <ceph-devel@vger.kernel.org>; Mon, 14 Feb 2011 15:00:08 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 67DD9BC728
	for <ceph-devel@vger.kernel.org>; Mon, 14 Feb 2011 15:00:08 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There are a few problems with the current librados api (at least the C 
bindings).  The main one is that there is an implicit assumption that you 
can only interact with a single cluster from the same process.  
rados_initalize() takes argc/argv, allowing you to pass in configuration 
options and/or a config file location, and it is assume that is the 
cluster that is referenced when you open up a pool.

Beyond that, there are some cosmetic issues with function naming, argument 
ordering, and so forth.  If we're going to fix the main problem and break 
compatibility, we should take the opportunity to clean up the rest.  And 
make the change sooner rather than later to minimize the pain.

See http://tracker.newdream.net/issues/801 and the librados_api branch in 
ceph.git.

In order to make it really work the way it looks, though, we need to 
identiy and eliminate as many remaining instances of common static 
variables.  Currently, for example, the configuration state is static 
(in this case, shared between clusters).  For things like 
debugging/logging, that's fine, but for other options it can be 
problematic.

Are there other problems that people have run into?  How important are 
these issues?  At the very lease we can stick this stuff on the long term 
roadmap.

sage

