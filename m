From: Sage Weil <sage@inktank.com>
Subject: v0.48.2 argonaut update released
Date: Thu, 20 Sep 2012 09:52:18 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209200948180.8980@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46049 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347Ab2ITQwT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Sep 2012 12:52:19 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 13B8580060
	for <ceph-devel@vger.kernel.org>; Thu, 20 Sep 2012 09:52:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id D7AF480060
	for <ceph-devel@vger.kernel.org>; Thu, 20 Sep 2012 09:52:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

Another update to the stable "argonaut" series has been released.  This 
fixes a few important bugs in rbd and radosgw and includes a series of 
changes to upstart and deployment related scripts that will allow the 
upcoming 'ceph-deploy' tool to work with the argonaut release.

Upgrading:

 * The default search path for keyring files now includes 
   /etc/ceph/ceph.$name.keyring. If such files are present on your 
   cluster, be aware that by default they may now be used.
 * There are several changes to the upstart init files. These have not 
   been previously documented or recommended. Any existing users should 
   review the changes before upgrading.
 * The ceph-disk-prepare and ceph-disk-active scripts have been updated 
   significantly. These have not been previously documented or 
   recommended. Any existing users should review the changes before upgrading.

Notable changes include:

 * mkcephfs: fix keyring generation for mds, osd when default paths are 
   used
 * radosgw: fix bug causing occasional corruption of per-bucket stats
 * radosgw: workaround to avoid previously corrupted stats from going 
   negative
 * radosgw: fix bug in usage stats reporting on busy buckets
 * radosgw: fix Content-Range: header for objects bigger than 2 GB.
 * rbd: avoid leaving watch acting when command line tool errors out 
   (avoids 30s delay on subsequent operations)
 * rbd: friendlier use of pool/image options for import (old calling 
   convention still works)
 * librbd: fix rare snapshot creation race (could lose a snap when 
   creation is concurrent)
 * librbd: fix discard handling when spanning holes
 * librbd: fix memory leak on discard when caching is enabled
 * objecter: misc fixes for op reordering
 * objecter: fix for rare startup-time deadlock waiting for osdmap
 * ceph: fix usage
 * mon: reduce log noise about check_sub
 * ceph-disk-activate: misc fixes, improvements
 * ceph-disk-prepare: partition and format osd disks automatically
 * upstart: start everyone on a reboot
 * upstart: always update the osd crush location on start if specified in 
   the config
 * config: add /etc/ceph/ceph.$name.keyring to default keyring search path
 * ceph.spec: don't package crush headers

You can get this release from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.newdream.net/download/ceph-0.48.2.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.newdream.net/docs/master/install/debian
