From: Alex Elder <elder@inktank.com>
Subject: [PATCH 0/7] rbd: miscellaneous cleanups
Date: Fri, 26 Apr 2013 12:58:31 -0500
Message-ID: <517AC047.6060000@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:48438 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755929Ab3DZR6f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Apr 2013 13:58:35 -0400
Received: by mail-ie0-f182.google.com with SMTP id bn7so5227304ieb.41
        for <ceph-devel@vger.kernel.org>; Fri, 26 Apr 2013 10:58:35 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net. [71.195.31.37])
        by mx.google.com with ESMTPSA id s16sm4008019ign.4.2013.04.26.10.58.31
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 26 Apr 2013 10:58:34 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Another batch of patches.  This set is available in the
branch "review/wip-rbd-cleanup-2" in the ceph-client git
repository, which is based on "review/wip-rbd-cleanup-1".

These are all simple cleanups, no substantive changes.

					-Alex

[PATCH 1/7] rbd: make rbd spec names pointer to const
[PATCH 2/7] rbd: move stripe_unit and stripe_count into header
[PATCH 3/7] rbd: use rbd_warn(), not WARN_ON()
[PATCH 4/7] rbd: define rbd snap context routines
[PATCH 5/7] rbd: make rbd_dev_destroy() match rbd_dev_create()
[PATCH 6/7] rbd: rename rbd_dev_probe()
[PATCH 7/7] rbd: refactor rbd_dev_probe_update_spec()
