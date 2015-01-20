From: Ilya Dryomov <idryomov@redhat.com>
Subject: [PATCH 0/3] rbd: parent_overlap == 0 fixes
Date: Tue, 20 Jan 2015 15:41:06 +0300
Message-ID: <1421757669-38796-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:35437 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbbATMt5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jan 2015 07:49:57 -0500
Received: by mail-we0-f171.google.com with SMTP id u56so36982957wes.2
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jan 2015 04:49:56 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

Hello,

This series fixes what turned out to be an old (v3.10-v3.11) bug, which
can cause things like http://tracker.ceph.com/issues/10352.  Most of
the damage was brought by 3b5cf2a2f174 ("rbd: clean up a few things in
the refresh path") which went into v3.11, but v3.10 wasn't fully OK
either.

Thanks,

                Ilya


Ilya Dryomov (3):
  rbd: fix rbd_dev_parent_get() when parent_overlap == 0
  rbd: drop parent_ref in rbd_dev_unprobe() unconditionally
  rbd: do not treat standalone as flatten

 drivers/block/rbd.c | 55 +++++++++++++++++------------------------------------
 1 file changed, 17 insertions(+), 38 deletions(-)

-- 
1.9.3

