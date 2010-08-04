From: Takuya ASADA <syuu@dokukino.com>
Subject: usage message of rados is wrong
Date: Wed, 4 Aug 2010 17:48:17 +0900
Message-ID: <AANLkTik-shCam-OsLqi0RnxB7RgPCoPU=8-5mJuMDftY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36563 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754207Ab0HDIsi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 4 Aug 2010 04:48:38 -0400
Received: by wwj40 with SMTP id 40so6180545wwj.1
        for <ceph-devel@vger.kernel.org>; Wed, 04 Aug 2010 01:48:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

I think it better to fix usage message like following patch, unless
you'll support -i and -o, that's currently not available on the
code(but on the message).

syuu

diff --git a/src/rados.cc b/src/rados.cc
index 268f14f..57deec6 100644
--- a/src/rados.cc
+++ b/src/rados.cc
@@ -44,8 +44,8 @@ void usage()
   cerr << "   df          -- show per-pool and total usage\n\n";

   cerr << "Pool commands:\n";
-  cerr << "   get objname -- fetch object\n";
-  cerr << "   put objname -- write object\n";
+  cerr << "   get objname [outfile] -- fetch object\n";
+  cerr << "   put objname [infile] -- write object\n";
   cerr << "   rm objname  -- remove object\n";
   cerr << "   ls          -- list objects in pool\n\n";
   cerr << "   chown 123   -- change the pool owner to auid 123\n";
@@ -69,9 +69,6 @@ void usage()
   cerr << "   -s name\n";
   cerr << "   --snap name\n";
   cerr << "        select given snap name for (read) IO\n";
-  cerr << "   -i infile\n";
-  cerr << "   -o outfile\n";
-  cerr << "        specify input or output file (for certain commands)\n";
   exit(1);
 }
