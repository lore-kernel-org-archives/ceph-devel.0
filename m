From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH 3/3] debian: move fuse-utils dep to ceph-fuse, add ceph-client-tools to ceph recommends
Date: Mon,  2 Aug 2010 13:32:45 +0200
Message-ID: <1280748765-21794-3-git-send-email-thomas@chaschperli.ch>
References: <1280748765-21794-1-git-send-email-thomas@chaschperli.ch>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.muellerit.ch ([92.51.129.153]:54076 "EHLO
	mail.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752788Ab0HBLd1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 07:33:27 -0400
Received: from mail.muellerit.ch ([127.0.0.1])
	by localhost (mail.muellerit.ch [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4qVriEUSeQ5S for <ceph-devel@vger.kernel.org>;
	Mon,  2 Aug 2010 13:33:21 +0200 (CEST)
Received: from gargelblaster.mit.local (80-219-106-215.dclient.hispeed.ch [80.219.106.215])
	by mail.muellerit.ch (Postfix) with ESMTPSA id 7485310BEC004
	for <ceph-devel@vger.kernel.org>; Mon,  2 Aug 2010 13:33:21 +0200 (CEST)
In-Reply-To: <1280748765-21794-1-git-send-email-thomas@chaschperli.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Thomas Mueller <thomas@chaschperli.ch>


Signed-off-by: Thomas Mueller <thomas@chaschperli.ch>
---
 debian/control |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/debian/control b/debian/control
index 38d4fac..46cfda2 100644
--- a/debian/control
+++ b/debian/control
@@ -8,7 +8,7 @@ Standards-Version: 3.8.4
 Package: ceph
 Architecture: any
 Depends: ${shlibs:Depends}, ${misc:Depends}, libedit2, hdparm, binutils
-Recommends: fuse-utils, ceph-fuse, libceph1, librados1, libcrush1, btrfs-tools
+Recommends: ceph-client-tools, libceph1, librados1, libcrush1, btrfs-tools
 Description: distributed storage and file system
  Ceph is a distributed storage and network file system designed to provide
  excellent performance, reliability, and scalability.
@@ -30,6 +30,7 @@ Description: debugging symbols for ceph
 Package: ceph-fuse
 Architecture: any
 Depends: ${shlibs:Depends}, ${misc:Depends}, libfuse2
+Recommends: fuse-utils
 Suggests: ceph
 Description: FUSE-based client for the Ceph distributed file system
  Ceph is a distributed network file system designed to provide
-- 
1.7.1

