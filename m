From: huang jun <hjwsm1989@gmail.com>
Subject: write and read error handling problems
Date: Wed, 10 Aug 2011 20:11:07 +0800
Message-ID: <CABAwU-ao6=DfMEeJZLZnYniVnzs+Gp7BYLoGv-36oUUPCR77Qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41974 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab1HJMLI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Aug 2011 08:11:08 -0400
Received: by vxi9 with SMTP id 9so753817vxi.19
        for <ceph-devel@vger.kernel.org>; Wed, 10 Aug 2011 05:11:07 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

hi,all
About OSD read ops, if osd got errors, it just return,
that may lead memory leak. we patched it.
diff --git a/src/osd/ReplicatedPG.cc b/src/osd/ReplicatedPG.cc
index 2ab21bb..21fbca7 100644
--- a/src/osd/ReplicatedPG.cc
+++ b/src/osd/ReplicatedPG.cc
@@ -588,8 +588,18 @@ void ReplicatedPG::do_op(MOSDOp *op)
     obc->ondisk_read_unlock();
   }

-  if (result == -EAGAIN)
+  if (result == -EAGAIN) {
+    delete ctx;
     return;
+  }
please have a check!

So i'm confused about the Error handling strategy of write/read
operations in OSD.
If the ceph just return when encountered errors, pass the work to client?
Let's take an example of writing files. Client send request to write 4MB file,
and OSD first write the osd journal, then return commit msg to Client.
But, if the write file op was interrupted by the borken disk sector or
other errors, that means write ops failed. What does the OSD going to
do? Replay it from the former writen journal item? or other methods?

thanks!
