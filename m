From: Sage Weil <sweil@redhat.com>
Subject: [PATCH] MAINTAINERS: remove myself as ceph co-maintainer
Date: Mon, 20 Apr 2020 13:44:25 +0000 (UTC)
Message-ID: <alpine.DEB.2.21.2004201343420.29831@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23380 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726081AbgDTNoi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Apr 2020 09:44:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 804E2190A7A4
        for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2020 13:44:28 +0000 (UTC)
Received: from [10.3.128.3] (unknown [10.3.128.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0FCEA58
        for <ceph-devel@vger.kernel.org>; Mon, 20 Apr 2020 13:44:27 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Jeff, Ilya, and Dongsheng are doing all of the Ceph maintainance
these days.

Signed-off-by: Sage Weil <sage@redhat.com>
---
 MAINTAINERS | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b816a453b10e..7a691c8fc76d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3937,7 +3937,6 @@ F:        arch/powerpc/platforms/cell/
 CEPH COMMON CODE (LIBCEPH)
 M:     Ilya Dryomov <idryomov@gmail.com>
 M:     Jeff Layton <jlayton@kernel.org>
-M:     Sage Weil <sage@redhat.com>
 L:     ceph-devel@vger.kernel.org
 S:     Supported
 W:     http://ceph.com/
@@ -3949,7 +3948,6 @@ F:        net/ceph/
 
 CEPH DISTRIBUTED FILE SYSTEM CLIENT (CEPH)
 M:     Jeff Layton <jlayton@kernel.org>
-M:     Sage Weil <sage@redhat.com>
 M:     Ilya Dryomov <idryomov@gmail.com>
 L:     ceph-devel@vger.kernel.org
 S:     Supported
@@ -14096,7 +14094,6 @@ F:      drivers/media/radio/radio-tea5777.c
 
 RADOS BLOCK DEVICE (RBD)
 M:     Ilya Dryomov <idryomov@gmail.com>
-M:     Sage Weil <sage@redhat.com>
 R:     Dongsheng Yang <dongsheng.yang@easystack.cn>
 L:     ceph-devel@vger.kernel.org
 S:     Supported
-- 
2.24.1
