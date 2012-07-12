From: Sage Weil <sage@inktank.com>
Subject: outstanding branches
Date: Thu, 12 Jul 2012 09:16:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1207120910060.693@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46332 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755191Ab2GLQQO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 12 Jul 2012 12:16:14 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id CB04A80481
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 09:16:13 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A4E0180481
	for <ceph-devel@vger.kernel.org>; Thu, 12 Jul 2012 09:16:13 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

These branches need some attention:

- wip-mon-mkfs

Avoid doing rm -rf (literally) during ceph-mon --mkfs.  Do it in vstart.sh 
and mkcephfs instead.

- wip-omap-comparison

Eleanor is using this.  It should probbaly just go in master... Sam?

- wip-2650

rgw: don't override subuser perm mask if perm not specified

Just needs to be merged into master, probably Stable/next too... Yehuda?

- wip-rbd-locking

This is in flux as Yehuda is converting the OSD support into a generic 
class.

- wip-2504

rgw: use multiple notification objects

Should this be merged with a default of 1 (to cooperate with previous 
code)?


These are probably on hold for the time being:

- wip-rados-bench4

On hold while Mike finishes chunky scrub... probably 0.51?

- wip-auth

Cleaning up 'rbd map' options to be consistent with everythign else.  Misc 
keyring handling cleanup.  New auth configuration options, negotiation, 
etc.  This needs some significant review and testing.  
