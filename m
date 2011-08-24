From: Sage Weil <sage@newdream.net>
Subject: libvirt rbd storage pool
Date: Wed, 24 Aug 2011 11:15:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1108241110450.20147@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42627 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752697Ab1HXSKR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2011 14:10:17 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A675CBC7A1
	for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2011 11:15:18 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 88915BC7A1
	for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2011 11:15:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I pushed a branch to git://ceph.newdream.net/git/libvirt.git 
(wip-rbd-storage-pool) with the beginnings of an implementation for a 
libvirt storage pool backed by a ceph pool.  This'll eventually let you 
browse, create, remove images via the libvirt tools and (presumably) via 
the virt-manager gui.

There's also a ticket open for this feature, 
	http://tracker.newdream.net/issues/1422

sage
