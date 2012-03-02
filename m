From: Sage Weil <sage@newdream.net>
Subject: The git repositories have moved!
Date: Fri, 2 Mar 2012 11:10:47 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021100210.6413@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43895 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913Ab2CBTKs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 14:10:48 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 40FDABC802
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 11:10:48 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1DEB5BC802
	for <ceph-devel@vger.kernel.org>; Fri,  2 Mar 2012 11:10:48 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We've moved all of the github stuff to

	 github.com/ceph

(from github.com/NewDreamNetwork).  That makes the URLs something like

	 github.com/ceph/ceph.git
	 github.com/ceph/ceph-client.git
	 github.com/ceph/teuthology.git
	...

Unfortunately there is no redirect from the old URL, so you'll need to 
update things manually.  That usually is something like

	 git remote set-url origin git@github.com:ceph/ceph.git

(if you are a github user), or

	 git remote set-url origin git://github.com/ceph/ceph.git

if you cloned anonymously.

Sorry for the hassle, but in the long run this will be less confusing and 
less painful than those freakin' caps in NewDreamNetwork.

sage
