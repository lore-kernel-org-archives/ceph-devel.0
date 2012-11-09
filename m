From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH] vstart: allow minimum pool size of one
Date: Thu, 8 Nov 2012 20:21:00 -0800
Message-ID: <CAPrxi583At7RnDfpF7nfXtmRn1gf1mB8MW8BrSvP8TNqy0ZhCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:52550 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab2KIEVB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 8 Nov 2012 23:21:01 -0500
Received: by mail-vb0-f46.google.com with SMTP id ff1so3505786vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 08 Nov 2012 20:21:00 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Sam Lang <sam.lang@inktank.com>

I needed this patch after some simple 1 OSD vstart environments
refused to allow clients to connect.

--

    A minimum pool size of 2 was introduced by 13486857cf. This sets the
    minimum to one so that basic vstart environments work.

    Signed-off-by: Noah Watkins <noahwatkins@gmail.com>

diff --git a/src/vstart.sh b/src/vstart.sh
index 4565efa..bdf02f3 100755
--- a/src/vstart.sh
+++ b/src/vstart.sh
@@ -290,6 +290,7 @@ if [ "$start_mon" -eq 1 ]; then
 [global]
         osd pg bits = 3
         osd pgp bits = 5  ; (invalid, but ceph should cope!)
+        osd pool default min size = 1
 EOF
                        [ "$cephx" -eq 1 ] && cat<<EOF >> $conf
         auth supported = cephx
