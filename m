From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: [PATCH] Add line break after add_key() failure message.
Date: Thu, 21 Jul 2011 05:28:26 -0300
Message-ID: <oraac882c5.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:60314 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751690Ab1GUI2d (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Jul 2011 04:28:33 -0400
Received: from freie.oliva.athome.lsd.ic.unicamp.br (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p6L8SUtC021952
	for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 05:28:31 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie.oliva.athome.lsd.ic.unicamp.br (8.14.4/8.14.4) with ESMTP id p6L8SSQv005344
	for <ceph-devel@vger.kernel.org>; Thu, 21 Jul 2011 05:28:28 -0300
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
---
 src/common/secret.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/common/secret.c b/src/common/secret.c
index f90f478..158343e 100644
--- a/src/common/secret.c
+++ b/src/common/secret.c
@@ -66,7 +66,7 @@ static int add_secret_to_kernel(const char *secret, const char *key_name)
   serial = add_key("ceph", key_name, payload, sizeof(payload), KEY_SPEC_USER_KEYRING);
   if (serial < 0) {
     ret = -errno;
-    fprintf(stderr, "error adding secret to kernel, key name %s: %s", key_name, strerror(-ret));
+    fprintf(stderr, "error adding secret to kernel, key name %s: %s.\n", key_name, strerror(-ret));
   }
 
   return ret;
-- 
1.7.4.4

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
