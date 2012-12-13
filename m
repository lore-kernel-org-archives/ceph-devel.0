From: Sage Weil <sage@inktank.com>
Subject: v0.55.1 is released
Date: Thu, 13 Dec 2012 09:11:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1212130905450.28742@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49483 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872Ab2LMRLw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 12:11:52 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 5635580060
	for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:11:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 2C10B80060
	for <ceph-devel@vger.kernel.org>; Thu, 13 Dec 2012 09:11:52 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There were some packaging and init script issues with v0.55, so a small 
point release is out.  It fixes a few odds and ends:

 * init-ceph: typo (new 'fs type' stuff was broken)
 * debian: fixed conflicting upstart and sysvinit scripts
 * auth: fixed default auth settings
 * osd: dropped some broken asserts
 * librbd: fix locking bug, race with 'flatten'

You can get this release from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.55.1.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
