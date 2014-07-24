From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 8/8] rbd: take snap_id into account when reading in parent info
Date: Thu, 24 Jul 2014 12:42:49 +0400
Message-ID: <1406191369-6746-9-git-send-email-ilya.dryomov@inktank.com>
References: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35307 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934274AbaGXInQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Jul 2014 04:43:16 -0400
Received: by mail-lb0-f174.google.com with SMTP id c11so2009779lbj.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 Jul 2014 01:43:15 -0700 (PDT)
Received: from localhost ([109.110.66.237])
        by mx.google.com with ESMTPSA id e5sm3884765laf.3.2014.07.24.01.43.14
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 24 Jul 2014 01:43:14 -0700 (PDT)
In-Reply-To: <1406191369-6746-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

If we are mapping a snapshot, we must read in the parent_overlap value
of that snapshot instead of that of the base image.  Not doing so may
in particular result in us returning zeros instead of user data:

    # cat overlap-snap.sh
    #!/bin/bash
    rbd create --size 10 --image-format 2 foo
    FOO_DEV=$(rbd map foo)
    dd if=/dev/urandom of=/dev/rbd0 bs=1M &>/dev/null
    echo "Base image"
    dd if=$FOO_DEV bs=1 count=16 skip=$(((4 << 20) - 8)) 2>/dev/null | xxd
    rbd snap create foo@snap
    rbd snap protect foo@snap
    rbd clone foo@snap bar
    rbd snap create bar@snap
    BAR_DEV=$(rbd map bar@snap)
    echo "Snapshot"
    dd if=$BAR_DEV bs=1 count=16 skip=$(((4 << 20) - 8)) 2>/dev/null | xxd
    rbd resize --allow-shrink --size 4 bar
    echo "Snapshot after base image resize"
    dd if=$BAR_DEV bs=1 count=16 skip=$(((4 << 20) - 8)) 2>/dev/null | xxd

    # ./overlap-snap.sh
    Base image
    0000000: e781 e33b d34b 2225 6034 2845 a2e3 36ed  ...;.K"%`4(E..6.
    Snapshot
    0000000: e781 e33b d34b 2225 6034 2845 a2e3 36ed  ...;.K"%`4(E..6.
    Resizing image: 100% complete...done.
    Snapshot after base image resize
    0000000: e781 e33b d34b 2225 0000 0000 0000 0000  ...;.K"%........

Even though bar@snap was taken with the old bar parent_overlap (8M),
reads from bar@snap beyond the new bar parent_overlap (4M) return
zeroes.  Fix it.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 drivers/block/rbd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index c4606987e9d1..cbc89fa9a677 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4020,7 +4020,7 @@ static int rbd_dev_v2_parent_info(struct rbd_device *rbd_dev)
 		goto out_err;
 	}
 
-	snapid = cpu_to_le64(CEPH_NOSNAP);
+	snapid = cpu_to_le64(rbd_dev->spec->snap_id);
 	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
 				"rbd", "get_parent",
 				&snapid, sizeof (snapid),
-- 
1.7.10.4

