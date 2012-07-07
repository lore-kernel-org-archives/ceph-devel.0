From: Alex Elder <elder@inktank.com>
Subject: [ANNOUNCE] Linux 3.4 Ceph stable release branch
Date: Fri, 06 Jul 2012 19:12:09 -0500
Message-ID: <4FF77ED9.8030108@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:33261 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752853Ab2GGAMK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jul 2012 20:12:10 -0400
Received: by yenl2 with SMTP id l2so9123422yen.19
        for <ceph-devel@vger.kernel.org>; Fri, 06 Jul 2012 17:12:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

There is a new branch available at the Ceph client git repository,
which is located here:

    http://github.com/ceph/ceph-client.git

The branch is named "linux-3.4.4-ceph", and it is based on the
latest Linux 3.4.y stable release.

This "Ceph stable" branch contains ported bug fixes that have been
added to Ceph-related code (including rbd, libceph, and the ceph
file system) since the release of Linux 3.4.  Right now we have no
plans to port to any other kernels, but if there is enough demand
for it we can arrange to do so.

Commits in a Ceph stable branch will be submitted for inclusion in
future upstream stable releases, but until they are released there
they will be available on the Ceph git repository.

Our general plan going forward will be to create Ceph stable
branches only as required to ensure new critical bug fixes are
provided for older released kernels in a timely manner.

Once fixes in a Ceph stable branch have been incorporated into an
upstream stable Linux release, there will be no more need to
maintain the separate branch, so it will go away.

                                        -Alex

Note: the latest upstream stable Linux releases are published here:
    http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git
