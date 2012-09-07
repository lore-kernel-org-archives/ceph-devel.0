From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/9] rbd: rearrange initialization sequence
Date: Fri, 07 Sep 2012 10:39:26 -0500
Message-ID: <504A152E.4000905@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:65255 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752804Ab2IGPj3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 11:39:29 -0400
Received: by ieje11 with SMTP id e11so5251270iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 08:39:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This fifth series rearranges the order of a bunch of steps that
occur during initialization of a new rbd device structure.  It
consists almost entirely of simple movements of code, but it
significantly separates updating a device's snapshot list from
registering devices for newly-found snapshots (which will be
for the benefit of format 2 image initialization).

It is available as branch "wip-rbd-review-4" on the ceph-client git
repository, and is based on the branch "wip-rbd-review-3".

    https://github.com/ceph/ceph-client/tree/wip-rbd-review-4

					-Alex

[PATCH 1/9]  d58dd5e rbd: assign header name later
[PATCH 2/9]  c8fd9cf rbd: defer registering snapshot devices
[PATCH 3/9]  bf469fa rbd: call set_snap() before snap_devs_update()
[PATCH 4/9]  1ee626d rbd: read the header before registering device
[PATCH 5/9]  f05c12d rbd: defer setting device id
[PATCH 6/9]  8b8b8b7 rbd: call rbd_init_disk() sooner
[PATCH 7/9]  f1194c2 rbd: drop dev registration check for new snap
[PATCH 8/9]  345936d rbd: set initial capacity in rbd_init_disk()
[PATCH 9/9]  527bbdd rbd: set up watch before announcing disk
