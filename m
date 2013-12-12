From: Sage Weil <sage@inktank.com>
Subject: v0.73 released
Date: Wed, 11 Dec 2013 16:18:16 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312111600040.27471@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:42614 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382Ab3LLASQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 11 Dec 2013 19:18:16 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users@ceph.com, ceph-devel@vger.kernel.org

This release, the first development release after emperor, includes many 
bug fixes and a few additional pieces of functionality. The first batch of 
larger changes will be landing in the next version, v0.74.

Notable changes:

 * ceph-crush-location: new hook for setting CRUSH location of osd daemons 
   on start
 * ceph-kvstore-tool: expanded command set and capabilities (Joao Eduardo 
   Luis)
 * ceph.spec: fix build dependency (Loic Dachary)
 * common: fix aligned buffer allocation (Loic Dachary)
 * doc: many many install doc improvements (John Wilkins)
 * mds: fix readdir end check (Zheng Yan)
 * mds: update old-format backtraces opportunistically (Zheng Yan)
 * misc cleanups from coverity (Xing Lin)
 * misc portability fixes (Noah Watkins, Christophe Courtaut, Alan Somers, 
   huanjun)
 * mon: 'osd dump' dumps pool snaps as array, not object (Dan Mick)
 * mon: allow debug quorum_{enter,exit} commands via admin socket
 * mon: prevent extreme changes in pool pg_num (Greg Farnum)
 * mon: take 'osd pool set ...' value as an int, not string (Joao Eduardo 
   Luis)
 * mon: trim MDSMaps (Joao Eduardo Luis)
 * osd: fix object_info_t encoding bug from emperor (****
 * rbd: add 'rbdmap' init script for mapping rbd images on book (Adam 
   Twardowski)
 * rgw: add 'status' command to sysvinit script (David Moreau Simard)
 * rgw: fix error setting empty owner on ACLs (Yehuda Sadeh)
 * rgw: optionally defer to bucket ACLs instead of object ACLs (Liam 
   Monahan)
 * rgw: support for password (instead of admin token) for keystone 
   authentication (Christophe Courtaut)
 * sysvinit, upstart: prevent both init systems from starting the same 
   daemons (Josh Durgin)

Ceph v0.73 can be found from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.72.tar.gz
 * For packages, see http://ceph.com/docs/master/install/get-packages/
 * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy/

