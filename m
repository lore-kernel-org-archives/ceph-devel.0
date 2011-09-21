From: Sage Weil <sage@newdream.net>
Subject: v0.35 released
Date: Wed, 21 Sep 2011 13:41:58 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1109211340000.22692@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40232 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750711Ab1IUUl7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2011 16:41:59 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id A7BA8BC783
	for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2011 13:41:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 81D26BC783
	for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2011 13:41:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

WARNING: There is a disk format change in this release that requires a bit 
of extra care to upgrade safely.  Please see below.

Notable changes since v0.34 include:

 * osd: large collections of objects are pre-hashed into directories
 * radosgw: pools are preallocated
 * librbd: asynchronous api for many operations
 * rbd: show progress for long-running operations
 * rados export: parallelized, much faster
 * collectd: track historical health
 * teuthology: valgrind support
 * teuthology: improved osd thrashing

The big change this time around is the way the OSD is storing objects on 
the local machine.  When directories of objects get large, they are 
'pre-hashed' into subdirectories.  This is necessary groundwork that will 
facilitate splitting and merging of PGs when pools grow or shrink 
dramatically in size.  There is an on disk format change to do this, so a 
bit of care is needed to upgrade.

Please follow this basic procedure:

 1. Make sure all PGs are healthy ('ceph pg stat' should show everything 
    'active+clean').

 2. Upgrade the monitors to the new version.

 3. Upgrade everything else (OSDs, MDSs, etc.).  Please note that when 
    cosd starts for the first time it will convert the existing data, so 
    it may take longer than you're used to. We've done a lot of testing
    to make sure this works properly, but there are some awkward changes 
    that make it difficult to test every scenario.  If you have important 
    data in your cluster, make a backup before upgrading.

Where to get v0.35:

 * Git at git://github.com/NewDreamNetwork/ceph.git
 * Tarball at http://ceph.newdream.net/downloads/ceph-0.35.tar.gz
 * For Debian/Ubuntu packages see http://ceph.newdream.net/wiki/Debian

