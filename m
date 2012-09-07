From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/5]   rbd: code cleanup
Date: Fri, 07 Sep 2012 08:34:45 -0500
Message-ID: <5049F7F5.1070609@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:59151 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab2IGNer (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 09:34:47 -0400
Received: by ieje11 with SMTP id e11so4992675iej.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 06:34:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This second series consists of fairly simple bits of code cleanup.

It is available as branch "wip-rbd-review-2" on the ceph-client git
repository, and is based on the branch "wip-rbd-review-1".

    https://github.com/ceph/ceph-client/tree/wip-rbd-review-2

					-Alex

[PATCH 1/5]  a0f6877 rbd: define rbd_assert()
    This defines a new macro rbd_assert() that's used to express
    invariant properties assumed by the code.  If the property does
    not hold it triggers a BUG().  Everywhere that BUG_ON() had been
    used is replaced with an equivalent call to rbd_assert().
[PATCH 2/5]  a8aac82 rbd: rename rbd_id_get()
[PATCH 3/5]  12c5aa2 rbd: rename __rbd_init_snaps_header()
    These rename some symbols to align better with how their used.
[PATCH 4/5]  e8cb272 rbd: kill rbd_dev->q
[PATCH 5/5]  1557afc rbd: kill rbd_image_header->total_snaps
    These eliminate two struct fields, one which is unused and the
    other which is redundant and therefore not necessary.
