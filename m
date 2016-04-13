From: Sage Weil <sage@redhat.com>
Subject: v10.1.2 Jewel release candidate release
Date: Wed, 13 Apr 2016 18:02:59 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604131753570.31812@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:49953 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751944AbcDMWDD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Apr 2016 18:03:03 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com, ceph-maintainers@ceph.com, ceph-announce@ceph.com

Hi everyone,

The third (and likely final) Jewel release candidate is out.  We have a 
very small number of remaining blocker issues and a bit of final polish 
before we publish Jewel 10.2.0, probably next week.

There are no known issues with this release that are serious enough to 
warn about here.  Greg is adding some CephFS checks so that admins don't 
accidentally start using less-stable features, there is a pending OSD 
startup check to ensure that the OSD's underlying fs can handle the 
configured max object name length, and there are a few bug to squash with 
the new rgw replication configuration process.  Otherwise, it's looking 
pretty good!

This is your last chance to some deployment testing before the final 
release.

Draft release notes are here:

        http://docs.ceph.com/docs/master/release-notes/

Thanks!
sage
