From: Sage Weil <sweil@redhat.com>
Subject: v0.94.1 Hammer released
Date: Mon, 13 Apr 2015 09:10:14 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1504130847250.15431@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56695 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604AbbDMQKU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 13 Apr 2015 12:10:20 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-announce@ceph.com, ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

This bug fix release fixes a few critical issues with CRUSH.  The most 
important addresses a bug in feature bit enforcement that may prevent 
pre-hammer clients from communicating with the cluster during an upgrade.  
This only manifests in some cases (for example, when the 'rack' type is in 
use in the CRUSH map, and possibly other cases), but for safety we 
strongly recommend that all users use 0.94.1 instead of 0.94 when 
upgrading.

There is also a fix in the new straw2 buckets when OSD weights are 0.

We recommend that all v0.94 users upgrade.

Notable changes
---------------

* crush: fix divide-by-0 in straw2 (#11357 Sage Weil)
* crush: fix has_v4_buckets (#11364 Sage Weil)
* osd: fix negative degraded objects during backfilling (#7737 Guang Yang)

For more detailed information, see the complete changelog at

  http://docs.ceph.com/docs/master/_downloads/v0.94.1.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.94.1.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy


