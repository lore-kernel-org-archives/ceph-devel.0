From: Sage Weil <sage@inktank.com>
Subject: argonaut stable update coming shortly
Date: Fri, 4 Jan 2013 20:56:02 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301042052090.15430@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40059 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755054Ab3AEE4D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 4 Jan 2013 23:56:03 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id BB97480068
	for <ceph-devel@vger.kernel.org>; Fri,  4 Jan 2013 20:56:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 7F9D580068
	for <ceph-devel@vger.kernel.org>; Fri,  4 Jan 2013 20:56:02 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We recently identified a bug in the way the OSD is marking its commits 
on XFS or ext4 (well, anything not btrfs) that could lead data loss in the 
event of power loss or a kernel panic.  We're doing some final testing and 
will have a v0.48.3argonaut package available by Monday.  If you like, 
you can get the fix before that from the autobuilders by grabbing the 
'stable' branch; see 

 http://ceph.com/docs/master/install/debian/#add-development-testing-packages

sage



