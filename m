From: Alex Elder <elder@inktank.com>
Subject: [PATCH 00/11] rbd: another set of patches
Date: Fri, 07 Sep 2012 08:34:23 -0500
Message-ID: <5049F7DF.4020907@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62621 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753641Ab2IGNe1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Sep 2012 09:34:27 -0400
Received: by iahk25 with SMTP id k25so3197980iah.19
        for <ceph-devel@vger.kernel.org>; Fri, 07 Sep 2012 06:34:26 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The first set of patches has already been posted for review.

It is based on the current state of the ceph-client/testing
branch, and is available as branch "wip-rbd-review-1" on
the ceph-client git repository.

    https://github.com/ceph/ceph-client/tree/wip-rbd-review-1

Most of these have been reviewed, and I will not be re-posting
them here today.

					-Alex

[PATCH 01/11]  rbd: handle locking inside __rbd_client_find()
[PATCH 02/11]  rbd: don't over-allocate space for object prefix
[PATCH 03/11]  rbd: kill incore snap_names_len
[PATCH 04/11]  rbd: more cleanup in rbd_header_from_disk()
[PATCH 05/11]  rbd: move rbd_opts to struct rbd_device
[PATCH 06/11]  rbd: add read_only rbd map option
[PATCH 07/11]  rbd: kill notify_timeout option
[PATCH 08/11]  rbd: bio_chain_clone() cleanups
[PATCH 09/11]  rbd: drop needless test in rbd_rq_fn()
[PATCH 10/11]  rbd: check for overflow in rbd_get_num_segments()
[PATCH 11/11]  rbd: split up rbd_get_segment()


