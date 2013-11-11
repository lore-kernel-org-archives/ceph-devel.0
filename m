From: Ketor D <d.ketor@gmail.com>
Subject: [PATCH]ceph:init-ceph can't start osds after using mkcephfs created cluster
Date: Mon, 11 Nov 2013 19:44:47 +0800
Message-ID: <CAM9_UU9RJouy7X0A296neNC_Jdm29tEra7aGb-GHFEuq9yrikw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f171.google.com ([209.85.217.171]:44904 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752967Ab3KKLpT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Nov 2013 06:45:19 -0500
Received: by mail-lb0-f171.google.com with SMTP id x18so3380915lbi.30
        for <ceph-devel@vger.kernel.org>; Mon, 11 Nov 2013 03:45:17 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Hi Sage:
        We always use mkcephfs to create out ceph cluster. Before
0.72, all is ok.
But in 0.72, we found the osds can't start up useing "service ceph -a
start". After viewing the init-ceph.in script , I found that a return
value errro caused osds can't startup.And if we modifiy a little code
like 0.67.4 do, the osds can startup.

         Regards!

Here is the patch:

Signed-off-by: Ketor D <d.ketor@gmail.com>
---
diff --git "a/src/init-ceph.in" "b/src/init-ceph.in"
index 7399abb..cf2eaa6 100644
--- "a/src/init-ceph.in"
+++ "b/src/init-ceph.in"
@@ -331,7 +331,8 @@ for name in $what; do
  -- \
  $id \
  ${osd_weight:-${defaultweight:-1}} \
- $osd_location"
+ $osd_location \
+ || :"
  fi
     fi
