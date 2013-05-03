From: Sage Weil <sage@inktank.com>
Subject: sysvinit script vs ceph-deploy, chef
Date: Thu, 2 May 2013 18:01:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305021754250.10494@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55795 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752609Ab3ECBBI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 2 May 2013 21:01:08 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DC41C8044B
	for <ceph-devel@vger.kernel.org>; Thu,  2 May 2013 18:01:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id B9E838044B
	for <ceph-devel@vger.kernel.org>; Thu,  2 May 2013 18:01:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The upstart scripts have also updated the OSD's position in the CRUSH map 
by default on startup.  This is part of the hotplugging capability that 
lets you move drives around between hosts, and also moves the burden away 
from chef and ceph-deploy when adding OSDs.

We forgot to add the parallel capability to the sysvinit script, which is 
what legacy clusters use, and what is used on Debian and RHEL/CentOS.  
That prevents ceph-deploy from fully bringing up OSDs (they are added to 
the cluster but not the CRUSH map).

wip-sysvinit makes it all match the upstart behavior, but old clusters 
will now have the osd position update to be under a node host=`hostname` 
on startup.  By default.  You can turn this off by setting 'osd crush 
update on start = false'.  it's always default to true, but never done 
anything for sysvinit (and legacy mkcephfs)-based clusters.

Alternatively, we could maek ceph-deploy and chef users now enable that 
explicitly, and make the default false.  That means *thsoe* users have to 
change their configs.

Or, we could make it try to magically detect what kind of user you are and 
behave accordingly.  This strikes me as dangerous.

Right now I'm leaning toward a prominent warning that on upgrade, any 
legacy clusters that don't put the osds under a node host=`hostname` need 
to add that optoin to avoid having their CRUSH map modfiied.

Thoughts?
sage

