From: Noah Watkins <jayhawk@cs.ucsc.edu>
Subject: [PATCH] vstart: use absolute path for keyring
Date: Fri, 13 Jul 2012 17:01:15 -0700
Message-ID: <EAE9FF3D-13E6-46CB-8D2F-31AE0C1D583A@cs.ucsc.edu>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:60962 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756590Ab2GNABS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 13 Jul 2012 20:01:18 -0400
Received: by obbuo13 with SMTP id uo13so5614626obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 13 Jul 2012 17:01:18 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Stores absolute path to the generated keyring so that tests running in
other directories (e.g. src/java/test) can simply reference the
generated ceph.conf.
---
 src/vstart.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/vstart.sh b/src/vstart.sh
index 1a5cf68..f6dece3 100755
--- a/src/vstart.sh
+++ b/src/vstart.sh
@@ -22,7 +22,7 @@ MON_ADDR=""
 
 conf="ceph.conf"
 
-keyring_fn="keyring"
+keyring_fn="$PWD/keyring"
 osdmap_fn="/tmp/ceph_osdmap.$$"
 monmap_fn="/tmp/ceph_monmap.$$"
 
@@ -271,7 +271,7 @@ EOF
                        cat <<EOF >> $conf
 
 [client]
-        keyring = keyring
+        keyring = $keyring_fn
 
 [mds]
 $DAEMONOPTS
-- 
1.7.5.4

