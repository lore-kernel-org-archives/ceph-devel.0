From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH] debian: ceph-cfuse: move ceph from Recommends to Suggests
Date: Thu, 29 Jul 2010 15:02:07 +0200
Message-ID: <4C517BCF.9050504@chaschperli.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from trillian.muellerit.ch ([83.169.22.129]:34901 "EHLO
	trillian.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756810Ab0G2NCO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 29 Jul 2010 09:02:14 -0400
Received: from trillian.muellerit.ch ([127.0.0.1])
	by localhost (trillian.muellerit.ch [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ey5nMCfivcvL for <ceph-devel@vger.kernel.org>;
	Thu, 29 Jul 2010 15:02:08 +0200 (CEST)
Received: from [192.168.32.117] (cust.dyn.95-152-98-129.swisscomdata.ch [95.152.98.129])
	by trillian.muellerit.ch (Postfix) with ESMTPSA id 5B13A19C803F
	for <ceph-devel@vger.kernel.org>; Thu, 29 Jul 2010 15:02:08 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

  on a standalone fuse client ceph serverside is not needed. if it's 
"Recommended" the default behaviour is to install it too. Move it to 
"Suggests" that it's not installed by default if one installs just 
ceph-fuse.

from debian policy:
Suggests:
This is used to declare that one package may be more useful with one or 
more others. Using this field tells the packaging system and the user 
that the listed packages are related to this one and can perhaps enhance 
its usefulness, but that installing this one without them is perfectly 
reasonable.

- Thomas


diff --git a/debian/control b/debian/control
index 622242d..a1db488 100644
--- a/debian/control
+++ b/debian/control
@@ -30,7 +30,7 @@ Description: debugging symbols for ceph
  Package: ceph-fuse
  Architecture: any
  Depends: ${shlibs:Depends}, ${misc:Depends}, libfuse2
-Recommends: ceph
+Suggests: ceph
  Description: FUSE-based client for the Ceph distributed file system
   Ceph is a distributed network file system designed to provide
   excellent performance, reliability, and scalability.  This is a


