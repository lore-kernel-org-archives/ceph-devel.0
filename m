From: Sage Weil <sage@inktank.com>
Subject: v0.67.1 Dumpling released
Date: Sat, 17 Aug 2013 08:43:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308170839520.14208@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55536 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753509Ab3HQPnU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 17 Aug 2013 11:43:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

This is a bug fix release for Dumpling that resolves a problem with the 
librbd python bindings (triggered by OpenStack) and a hang in librbd when 
caching is disabled.  OpenStack users are encouraged to upgrade.  No other 
serious bugs have come up since v0.67 came out earlier this week.

Notable changes:

 * librados, librbd: fix constructor for python bindings with certain 
   usages (in particular, that used by OpenStack)
 * librados, librbd: fix aio_flush wakeup when cache is disabled
 * librados: fix locking for aio completion refcounting
 * fixes 'ceph --admin-daemon ...' command error code on error
 * fixes 'ceph daemon ... config set ...' command for boolean config 
   options.

For more detailed information, see the complete release notes and 
changelog:

 * http://ceph.com/docs/master/release-notes/#v0-67-1-dumpling
 * http://ceph.com/docs/master/_downloads/v0.67.1.txt

You can download v0.67.1 Dumpling from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.67.1.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm


 



 
