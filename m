From: David McBride <dwm37@cam.ac.uk>
Subject: =?UTF-8?B?VWJ1bnR1IDE0LjA0OiBQYWNrYWdpbmcgYnVnOiBVcGdyYWRlcyBmcm8=?=
 =?UTF-8?B?bSAwLjc5LTB1YnVudHUxIOKGkiAwLjgwLjEtMXRydXN0eSBmYWls?=
Date: Mon, 19 May 2014 20:56:01 +0100
Message-ID: <537A61D1.4040807@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:49292 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbaEST4H (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 May 2014 15:56:07 -0400
Received: from randall.csi.cam.ac.uk ([131.111.56.82]:60659)
	by ppsw-41.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.157]:587)
	with esmtpsa (PLAIN:dwm37) (TLSv1:DHE-RSA-AES128-SHA:128)
	id 1WmTfF-0004Gb-RD (Exim 4.82_3-c0e5623) for ceph-devel@vger.kernel.org
	(return-path <dwm37@cam.ac.uk>); Mon, 19 May 2014 20:56:01 +0100
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph-devel list <ceph-devel@vger.kernel.org>

Hi,

There appears to be a slightly gnarly packaging bug that prevents
upgrades from version 0.79.0ubuntu1, as supplied by Ubuntu 14.04
("Trusty"), to version 0.80.1-1trusty, as supplied under
https://ceph.com/debian-firefly/.

Specifically, the older version of the 'ceph' packages conflicts with
the newer 'ceph-common' package, and similarly the older version of the
'ceph-common' package conflicts with the newr 'ceph' one.

Attempting to update 'ceph' results in dpkg objecting with:

> dpkg: error processing archive /var/cache/apt/archives/ceph-common_0.80.1-1trusty_amd64.deb (--unpack):
>  trying to overwrite '/etc/ceph/rbdmap', which is also in package ceph 0.79-0ubuntu1

Similarly, attempting to update 'ceph-common' results in dpkg objecting
with:

> dpkg: error processing archive /var/cache/apt/archives/ceph_0.80.1-1trusty_amd64.deb (--unpack):
>  trying to overwrite '/usr/share/man/man8/ceph-rest-api.8.gz', which is also in package ceph-common 0.79-0ubuntu1

These are just the first conflicts that occur; it's conceivable there
are more.

Though this is not something I'm deeply familiar with, a first glance
suggests that a careful addition of "Replaces:" and "Breaks:" dependency
relations to the newer packages are necessary to suppress this error.

See also:

 https://www.debian.org/doc/debian-policy/ch-relationships.html#s-replaces

Kind regards,
David
-- 
David McBride <dwm37@cam.ac.uk>
Unix Specialist, University Information Services
