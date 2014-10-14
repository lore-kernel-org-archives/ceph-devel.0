From: Sage Weil <sage@inktank.com>
Subject: v0.80.7 Firefly released
Date: Tue, 14 Oct 2014 14:45:45 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1410141444240.5718@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:38652 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbaJNVpp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Oct 2014 17:45:45 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

This release fixes a few critical issues with v0.80.6, particularly
with clusters running mixed versions.

We recommend that all v0.80.x Firefly users upgrade to this release.

Notable Changes
---------------

* osd: fix invalid memory reference in log trimming (#9731 Samuel Just)
* osd: fix use-after-free in cache tiering code (#7588 Sage Weil)
* osd: remove bad backfill assertion for mixed-version clusters (#9696 
  Samuel Just)

For more detailed information, see

* http://docs.ceph.com/docs/master/_downloads/v0.80.7.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.80.7.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
