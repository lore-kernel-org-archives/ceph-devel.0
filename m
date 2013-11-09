From: Sage Weil <sage@inktank.com>
Subject: HSM
Date: Sat, 9 Nov 2013 00:33:41 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1311090027210.8192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58768 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3KIIdm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Nov 2013 03:33:42 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DCCF080068
	for <ceph-devel@vger.kernel.org>; Sat,  9 Nov 2013 00:33:41 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id DA87180068
	for <ceph-devel@vger.kernel.org>; Sat,  9 Nov 2013 00:33:41 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The latest Lustre just added HSM support:

	http://archive.hpcwire.com/hpcwire/2013-11-06/lustre_scores_business_class_upgrade_with_hsm.html

Here is a slide deck with some high-level detail:
	
	https://jira.hpdd.intel.com/secure/attachment/13185/Lustre_HSM_Design.pdf

Is anyone familiar with the interfaces and requirements of the file system 
itself?  I don't know much about how these systems are implemented, but I 
would guess there are relatively lightweight requirements on the fs (ceph 
mds in our case) to keep track of file state (online or archived 
elsewhere).  And some hooks to trigger migrations?

If anyone is interested in this area, I would be happy to help figure out 
how to integrate things cleanly!

sage
