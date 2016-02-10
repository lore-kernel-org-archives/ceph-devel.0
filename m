From: Sage Weil <sweil@redhat.com>
Subject: v10.0.3 released
Date: Wed, 10 Feb 2016 14:40:46 -0500 (EST)
Message-ID: <alpine.DEB.2.11.1602101439530.4289@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-537954595-1455133249=:4289"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51677 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752701AbcBJTk1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 10 Feb 2016 14:40:27 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-537954595-1455133249=:4289
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT

This is the fourth development release for Jewel. Several big pieces have 
been added this release, including BlueStore (a new backend for OSD to 
replace FileStore), many ceph-disk fixes, a new CRUSH tunable that 
improves mapping stability, a new librados object enumeration API, and a 
whole slew of OSD and RADOS optimizations.

Note that, due to general developer busyness, we aren¢t building official 
release packages for this dev release. You can fetch autobuilt gitbuilder 
packages from the usual location (http://gitbuilder.ceph.com).

Notable Changes
---------------

        http://ceph.com/releases/v10-0-3-released/

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* For packages, see http://ceph.com/docs/master/install/get-packages#add-ceph-development
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
--8323329-537954595-1455133249=:4289--
