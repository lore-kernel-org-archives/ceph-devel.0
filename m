From: Sage Weil <sage@newdream.net>
Subject: v0.38 released
Date: Thu, 10 Nov 2011 21:14:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111102113260.27241@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33006 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107Ab1KKFOX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Nov 2011 00:14:23 -0500
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4786BBCAEB
	for <ceph-devel@vger.kernel.org>; Thu, 10 Nov 2011 21:14:23 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 17C20BCAEB
	for <ceph-devel@vger.kernel.org>; Thu, 10 Nov 2011 21:14:23 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's a week delayed, but v0.38 is ready.  The highlights:

 * osd: some peering refactoring
 * osd: 'replay' period is per-pool (now only affects fs data pool)
 * osd: clean up old osdmaps
 * osd: allow admin to revert lost objects to prior versions (or delete)
 * mkcephfs: generate reasonable crush map based on 'host' and 'rack' 
   fields in [osd.NN] sections of ceph.conf
 * radosgw: bucket index improvements
 * radosgw: improved swift support
 * rbd: misc command line tool fixes
 * debian: misc packaging fixes (including dependency breakage on upgrades)
 * ceph: query daemon perfcounters via command line tool

The big upcoming items for v0.39 are RBD layering (image cloning), further 
improvements to radosgw's Swift support, and some monitor failure recovery 
and bootstrapping improvements.  We're also continuing work on the 
automation bits that the Chef cookbooks and Juju charms will use, and a 
Crowbar barclamp was also just posted on github.  Several patches are 
still working their way into libvirt and qemu to improve support for RBD 
authentication.

You can get v0.38 from the usual places:

 * Git at git://github.com/NewDreamNetwork/ceph.git
 * Tarball at http://ceph.newdream.net/download/ceph-0.38.tar.gz
 * For Debian/Ubuntu packages see http://ceph.newdream.net/docs/latest/ops/install/mkcephfs/#installing-the-packages
 * For RPMs see https://build.opensuse.org/project/show?project=home%3Ahmacht%3Astorage

sage
