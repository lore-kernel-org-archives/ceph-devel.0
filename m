From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: set last_piece in ceph_msg_data_pages_cursor_init() correctly
Date: Fri,  8 Aug 2014 15:18:27 +0400
Message-ID: <1407496707-11641-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:63230 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbaHHLSc (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 Aug 2014 07:18:32 -0400
Received: by mail-la0-f45.google.com with SMTP id ty20so4510235lab.18
        for <ceph-devel@vger.kernel.org>; Fri, 08 Aug 2014 04:18:31 -0700 (PDT)
Received: from localhost ([109.110.66.143])
        by mx.google.com with ESMTPSA id q2sm1403143lah.8.2014.08.08.04.18.29
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 08 Aug 2014 04:18:29 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Determining ->last_piece based on the value of ->page_offset + length
is incorrect because length here is the length of the entire message.
->last_piece set to false even if page array data item length is <=
PAGE_SIZE, which results in invalid length passed to
ceph_tcp_{send,recv}page() and causes various asserts to fire.

    # cat pages-cursor-init.sh
    #!/bin/bash
    rbd create --size 10 --image-format 2 foo
    FOO_DEV=$(rbd map foo)
    dd if=/dev/urandom of=$FOO_DEV bs=1M &>/dev/null
    rbd snap create foo@snap
    rbd snap protect foo@snap
    rbd clone foo@snap bar
    # rbd_resize calls librbd rbd_resize(), size is in bytes
    ./rbd_resize bar $(((4 << 20) + 512))
    rbd resize --size 10 bar
    BAR_DEV=$(rbd map bar)
    # trigger a 512-byte copyup -- 512-byte page array data item
    dd if=/dev/urandom of=$BAR_DEV bs=1M count=1 seek=5

The problem exists only in ceph_msg_data_pages_cursor_init(),
ceph_msg_data_pages_advance() does the right thing.  The size_t cast is
unnecessary.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/messenger.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e51cad0db580..b2f571dd933d 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -901,7 +901,7 @@ static void ceph_msg_data_pages_cursor_init(struct ceph_msg_data_cursor *cursor,
 	BUG_ON(page_count > (int)USHRT_MAX);
 	cursor->page_count = (unsigned short)page_count;
 	BUG_ON(length > SIZE_MAX - cursor->page_offset);
-	cursor->last_piece = (size_t)cursor->page_offset + length <= PAGE_SIZE;
+	cursor->last_piece = cursor->page_offset + cursor->resid <= PAGE_SIZE;
 }
 
 static struct page *
-- 
1.7.10.4

