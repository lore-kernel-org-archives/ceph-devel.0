From: Sage Weil <sage@redhat.com>
Subject: v0.94.7 Hammer released
Date: Fri, 13 May 2016 10:21:51 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1605131020340.20416@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-474563023-1463149311=:20416"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40219 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbcEMOVh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 May 2016 10:21:37 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-474563023-1463149311=:20416
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE

This Hammer point release fixes several minor bugs. It also includes a=20
backport of an improved =A1ceph osd reweight-by-utilization=A2 command for=
=20
handling OSDs with higher-than-average utilizations.

We recommend that all hammer v0.94.x users upgrade.

For more detailed information, see the release announcement at

=09http://ceph.com/releases/v0-94-7-hammer-released/

or the complete changelog at

=09http://docs.ceph.com/docs/master/_downloads/v0.94.6.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-0.94.7.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-dep=
loy
--8323329-474563023-1463149311=:20416--
