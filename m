From: Sage Weil <sage@redhat.com>
Subject: v10.1.0 Jewel release candidate available
Date: Mon, 28 Mar 2016 11:28:14 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1603281029290.6074@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:34500 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404AbcC1P20 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 28 Mar 2016 11:28:26 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

Hi everyone,

The first release candidate for Jewel is now available!

Jewel is the next major release of Ceph, and will be the foundation for 
the next long-term stable release. There have been many major changes 
since the Infernalis (9.2.x) and Hammer (0.94.x) releases, and the upgrade 
process is non-trivial Please read these release notes carefully.

	http://docs.ceph.com/docs/master/release-notes/#v10-1-0-jewel-release-candidate

The packages are in the new Jewel repos, so you can install it as you 
would the eventual jewel release, e.g., with

	ceph-deploy install --stable jewel HOST

The upgrade tests are looking good, as are the general regression tests.  
We hope to have another release candidate or the final release out 
soon.

Packages for aarch64 will also be posted shortly!

Thanks!
sage
