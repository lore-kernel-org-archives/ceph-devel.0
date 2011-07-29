From: Sage Weil <sage@newdream.net>
Subject: userland nfs server
Date: Fri, 29 Jul 2011 09:15:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1107290914290.21698@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53305 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865Ab1G2QLy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2011 12:11:54 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id E2B6ABC69F
	for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2011 09:15:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id BFDDCBC69F
	for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2011 09:15:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Has anyone looked at Genesha?

	http://sourceforge.net/apps/trac/nfs-ganesha/

In principle it would probably be pretty straightforward to wire that up 
to libceph and avoid the kernel NFS server for reexporting ceph via NFS...

sage
