From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/3] rbd: hide some snapshot info details
Date: Fri, 07 Sep 2012 14:22:53 -0500
Message-ID: <504A498D.30708@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:57143 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751342Ab2IGTW4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 15:22:56 -0400
Received: by iahk25 with SMTP id k25so3525092iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 12:22:56 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Just three odds-and-ends patches in this seventh series before the
next series (which does all the real work of adding support for rbd
image format 2).

The patches rearrange the code that gets information about particular
snapshots so it hides the details of which format the underlying image
uses.

It is available as branch "wip-rbd-review-7" on the ceph-client git
repository, and is based on the branch "wip-rbd-review-6".

    https://github.com/ceph/ceph-client/tree/wip-rbd-review-7

					-Alex

[PATCH 1/3]  6a763d5 rbd: don't use index in __rbd_add_snap_dev()
[PATCH 2/3]  5652941 rbd: add an rbd features field
[PATCH 3/3]  79ae7ee rbd: encapsulate code that gets snapshot info
