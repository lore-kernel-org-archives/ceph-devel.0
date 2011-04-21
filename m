From: Sage Weil <sage@newdream.net>
Subject: quick update
Date: Wed, 20 Apr 2011 21:55:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104202151020.14154@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53815 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751363Ab1DUEzx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Apr 2011 00:55:53 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 3DB18BC7EF
	for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2011 21:55:53 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 20AABBC7EF
	for <ceph-devel@vger.kernel.org>; Wed, 20 Apr 2011 21:55:53 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We started a new 'next' branch that will become v0.27 at the end of the 
week.  The 0.27 cycle work can be found at
	http://tracker.newdream.net/projects/1/issues?sort=position
There's also a pile of clustered MDS fixes Greg has been working on that 
mostly landed in 0.27.

We're shooting for 2 weeks for 0.28.  The main items are rgw fixes, a 
libceph cleanup, and a refactor of the OSD peering/recovery code to make 
it more understandable and (presumably) less buggy.

A couple of our devs will be at the openstack developer summit so next 
week may be a bit slow...

sage
