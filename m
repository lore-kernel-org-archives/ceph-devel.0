From: Loic Dachary <ldachary@redhat.com>
Subject: Backporting stability fixes for ceph-disk
Date: Tue, 2 Feb 2016 12:53:58 +0700
Message-ID: <56B04476.5020203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48887 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752326AbcBBFyF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Feb 2016 00:54:05 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id D037C804EF
	for <ceph-devel@vger.kernel.org>; Tue,  2 Feb 2016 05:54:04 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Ken,

https://github.com/ceph/ceph/pull/6926 and https://github.com/ceph/ceph/pull/5999 fixed a number of stability problems related to the udev / ceph-disk / initsystem code path. I'm now convinced (after a few weeks with no surprising failures when running the ceph-disk teuthology suite) that we have something stable. I'm not saying all problems have been found and fixed. But at least we have something stable and repeatable to work with. I've used it as a based for a partial refactor of ceph-disk to support Bluestore ( https://github.com/ceph/ceph/pull/7218 ).

I think all stability fixes have been backported to infernalis ( https://github.com/ceph/ceph/pull/7001 etc. ). Unfortunately backporting to hammer can't be done by cherry-picking commits from https://github.com/ceph/ceph/pull/6926 and https://github.com/ceph/ceph/pull/5999. In hammer things go like this:

    * ceph-disk prepare
    * triggers a udev event
    * udev action runs ceph-disk activate
    * ceph-disk activate run ceph-osd via the init system

In infernalis Sage implemented an intermediate step so that the udev action does as little as possible:

   * ceph-disk prepare
   * triggers a udev event
   * udev action asynchronously delegates activation to the init system
   * the init system runs ceph-disk activate
   * ceph-disk activate run ceph-osd via the init system

This helps with stability because ceph-disk activate may trigger udev events, which is not recommended when running as a child process of a udev action and also because ceph-disk activate may take minutes to complete in some cases. Backporting this logic to hammer would require shipping new init files (ceph-disk unit for systemd for instance) and new udev rules (to call ceph-disk trigger instead of ceph-disk activate to add the delegation step).

The conservative approach to the problem would be to cherry-pick what we can ( https://github.com/dachary/ceph/commit/9dce05a8cdfc564c5162885bbb67a04ad7b95c5a for instance ) and document known side effects of ceph-disk instability so people know it's an annoyance but nothing destructive or blocking. In the worst case scenario, deactivating the udev rules and running ceph-disk prepare + ceph-disk activate manually or by writing a script that does things sequentially is a viable workaround.

The better approach would be to backport the udev / init system changes together with most of what ceph-disk is in infernalis. Not only would that solve the problems we know about, but it would give us a solid ground to fix future problems. It is unfortunately, IMHO, too much of a risk at this stage of the hammer release.

I'm quite conflicted about how to approach that in a sane way and your input would be most precious.

Cheers

