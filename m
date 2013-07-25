From: Sage Weil <sage@inktank.com>
Subject: blueprint: osd: ceph on zfs
Date: Thu, 25 Jul 2013 16:53:44 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307251649540.32741@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40449 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753586Ab3GYXxo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jul 2013 19:53:44 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 55EC28004F
	for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 16:53:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 1F4C78004F
	for <ceph-devel@vger.kernel.org>; Thu, 25 Jul 2013 16:53:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

http://wiki.ceph.com/01Planning/02Blueprints/Emperor/osd:_ceph_on_zfs

We've done some preliminary testing and xattr debugging that allows 
ceph-osd to run on zfsforlinux using the normal writeahead journaling mode 
(the same mode used for xfs and ext4).  However, we aren't doing anything 
special to take advantage of zfs's capabilities.

This session would go over what is needed to make parallel journaling work 
(which would leverage zfs snapshots).  I would also like to have a 
discussion about whether other longer-term possibilities, such as storing 
objects directly using the DMU, make sense given what ceph-osd's 
ObjectStore interface really needs.  It might also be an appropriate time 
to visit whether other snapshotting linux filesystems (like nilfs2) would 
fit well into any generalization of the filestore code that comes out of 
this effort.

If anybody is interested in this, please add yourself to the interested 
parties section (or claim ownership) of this blueprint!


