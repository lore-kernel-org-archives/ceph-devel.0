From: Sage Weil <sweil@redhat.com>
Subject: v10.0.2 released
Date: Thu, 14 Jan 2016 10:37:21 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1601141033010.21258@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51162 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754568AbcANPhR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 14 Jan 2016 10:37:17 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

This development release includes a raft of changes and improvements for 
Jewel. Key additions include CephFS scrub/repair improvements, an AIX and 
Solaris port of librados, many librbd journaling additions and fixes, 
extended per-pool options, and NBD driver for RBD (rbd-nbd) that allows 
librbd to present a kernel-level block device on Linux, multitenancy 
support for RGW, RGW bucket lifecycle support, RGW support for Swift 
static large objects (SLO), and RGW support for Swift bulk delete.

There are also lots of smaller optimizations and performance fixes going 
in all over the tree, particular in the OSD and common code.

Notable Changes
---------------

See

	http://ceph.com/releases/v10-0-2-released/

[I'd include the changelog here but I'm missing a oneliner that renders 
the rst in email-suitable form...]

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-10.0.2.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
