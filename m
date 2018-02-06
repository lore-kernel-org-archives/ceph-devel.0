From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: question about fuse_disable_pagecache
Date: Tue, 6 Feb 2018 05:55:05 +0100 (CET)
Message-ID: <112905846.2630949.1517892905113.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.211.110]:41428 "EHLO
        mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750751AbeBFFCr (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Feb 2018 00:02:47 -0500
Received: from localhost (localhost [127.0.0.1])
        by mailpro.odiso.net (Postfix) with ESMTP id 6CA231F2FE9A
        for <ceph-devel@vger.kernel.org>; Tue,  6 Feb 2018 05:55:05 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
        by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 9Js8Svx6IlLl for <ceph-devel@vger.kernel.org>;
        Tue,  6 Feb 2018 05:55:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mailpro.odiso.net (Postfix) with ESMTP id 541361F2FEB1
        for <ceph-devel@vger.kernel.org>; Tue,  6 Feb 2018 05:55:05 +0100 (CET)
Received: from mailpro.odiso.net ([127.0.0.1])
        by localhost (mailpro.odiso.net [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id x9S4bBRd60M3 for <ceph-devel@vger.kernel.org>;
        Tue,  6 Feb 2018 05:55:05 +0100 (CET)
Received: from mailpro.odiso.net (mailpro.odiso.net [10.1.31.111])
        by mailpro.odiso.net (Postfix) with ESMTP id 417981F2FEB0
        for <ceph-devel@vger.kernel.org>; Tue,  6 Feb 2018 05:55:05 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi,

I have a question about this commit

https://github.com/ceph/ceph/pull/5521/commits/0f11ec237d4692d313a038ed61aa07a3f40555ba#diff-bf87beacb5e3b3ff3ade7ac4a8332d20

which introduce "fuse_disable_pagecache" option

commit description is
"In ceph-fuse case,
there are two caches, one is in ceph-fuse, another one is in kernel.
We can't disable/enable the kernel cache dynamically. So adding an
config option to completely disable kernel cache."

and

-    if (cfuse->client->cct->_conf->fuse_use_invalidate_cb)
-    fi->keep_cache = 1;

+#if FUSE_VERSION >= FUSE_MAKE_VERSION(2, 8)
+    if (cfuse->client->cct->_conf->fuse_disable_pagecache)
+      fi->direct_io = 1;
+    else if (cfuse->client->cct->_conf->fuse_use_invalidate_cb)
+      fi->keep_cache = 1;
+#endif


So, does it disable both caches ? (fuse cache(keep_cache=0) and host cache (direct_io=1).

Isn't it possible to have direct_io = 0 and keep_cache = 1 at the same time ?

If I understand, fuse_use_invalidate_cb is to be able to invalidate fuse cache.

Regards,

Alexandre.

