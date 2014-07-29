From: Sage Weil <sage@inktank.com>
Subject: v0.80.5 Firefly released
Date: Tue, 29 Jul 2014 12:34:13 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1407291232410.26502@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:53496 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751397AbaG2TeO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jul 2014 15:34:14 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com

This release fixes a few important bugs in the radosgw and fixes several 
packaging and environment issues, including OSD log rotation, systemd 
environments, and daemon restarts on upgrade.

We recommend that all v0.80.x Firefly users upgrade, particularly if they 
are using upstart, systemd, or radosgw.

Notable Changes
---------------

* ceph-dencoder: do not needlessly link to librgw, librados, etc. (Sage 
  Weil)
* do not needlessly link binaries to leveldb (Sage Weil)
* mon: fix mon crash when no auth keys are present (#8851, Joao Eduardo 
  Luis)
* osd: fix cleanup (and avoid occasional crash) during shutdown (#7981, 
  Sage Weil)
* osd: fix log rotation under upstart (Sage Weil)
* rgw: fix multipart upload when object has irregular size (#8846, Yehuda 
  Sadeh, Sylvain Munaut)
* rgw: improve bucket listing S3 compatibility (#8858, Yehuda Sadeh)
* rgw: improve delimited bucket listing (Yehuda Sadeh)
* rpm: do not restart daemons on upgrade (#8849, Alfredo Deza)

For more detailed information, see the complete changelog:

  http://ceph.com/docs/master/_downloads/v0.80.5.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.80.5.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
