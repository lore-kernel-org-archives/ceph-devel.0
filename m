From: Travis Rhoden <trhoden@gmail.com>
Subject: [ANN] ceph-deploy 1.5.25 released
Date: Tue, 26 May 2015 20:48:18 -0400
Message-ID: <CACkq2mosAGa+2CW4QeGXsU6m5_7HH-FiBZOe3=rrTd_A1WUrYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f170.google.com ([209.85.214.170]:32837 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364AbbE0Asj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 May 2015 20:48:39 -0400
Received: by obbnx5 with SMTP id nx5so87806968obb.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 May 2015 17:48:38 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>, ceph-announce@lists.ceph.com

Hi everyone,

This is announcing a new release of ceph-deploy that fixes a security
related issue, improves SUSE support, and improves support for RGW on
RPM systems.  ceph-deploy can be installed from ceph.com hosted repos
for Firefly, Giant, Hammer, and testing, and is also available on
PyPI.

Eagle-eyed readers may notice that there was not an announcement for
1.5.24 -- this was due to package build infrastructure issues that
prevented the creation of RPM and DEB packages.  By the time the
issues were resolved, 1.5.25 was imminent, so 1.5.24 packages were not
created even though 1.5.24 was available through PyPI.

Full changelog is available at [1], but here are the highlights for
both 1.5.25 and 1.5.24:

 - Fix CVE where 'ceph-deploy admin' command resulted in admin keyring
being pushed to remote nodes with world readable (0644) permissions.
 - Fix reference to package name "ceph-radosgw" on RPM systems
 - Fix possible truncated output of "ceph-deploy disk list"
 - More robust deployment of RGW on RPM systems

Please update!

Cheers,

 - Travis

[1] http://ceph.com/ceph-deploy/docs/changelog.html#id2
