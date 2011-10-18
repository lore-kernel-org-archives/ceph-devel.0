From: Sage Weil <sage@newdream.net>
Subject: v0.37 released
Date: Tue, 18 Oct 2011 11:04:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110181102570.13665@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33661 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041Ab1JRSE6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Oct 2011 14:04:58 -0400
Received: from cobra.newdream.net (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 4DD10BC7A1
	for <ceph-devel@vger.kernel.org>; Tue, 18 Oct 2011 11:04:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by cobra.newdream.net (Postfix) with ESMTP id 30327BC7A1
	for <ceph-devel@vger.kernel.org>; Tue, 18 Oct 2011 11:04:58 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

v0.37 is ready.  Notable changes this time around:

 * radosgw: backend on-disk format changes
 * radosgw: improved logging
 * radosgw: package improvements (init script, fixed deps)
 * osd: bug fixes!
 * teuthology: btrfs testing

If you are currently storing data with radosgw, you will need to export 
your data and reimport it as the backend storage strategy has changed to 
improve scaling.

Other work not directly in the release includes work with the Chef 
cookbooks (will hit ceph-cookbooks.git soon), an RBD backend for Glance 
(OpenStack), and ongoing work improving the libvirt support for qemu/KVM + 
RBD.  We've also been fighting with the ceph.spec file to get something 
that will build on all of Fedora, RHEL/CentOS, openSUSE, and SLES (with 
mixed success).

You can get v0.37 from:

 * Git at git://github.com/NewDreamNetwork/ceph.git
 * Tarball at http://ceph.newdream.net/download/ceph-0.37.tar.gz
 * For Debian/Ubuntu packages see http://ceph.newdream.net/docs/latest/ops/install/mkcephfs/#installing-the-packages
 * For RPMs see https://build.opensuse.org/package/show?package=ceph&project=home%3Aliewegas
