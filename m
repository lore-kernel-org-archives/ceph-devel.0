From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Possible bug in src/Makefile.am
Date: Sun, 07 Jul 2013 17:15:23 +1200
Message-ID: <51D8F96B.5040902@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080203080308010108010804"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:52616 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab3GGFP2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 7 Jul 2013 01:15:28 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 5F02B6778B
	for <ceph-devel@vger.kernel.org>; Sun,  7 Jul 2013 17:15:24 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QxiuwIHW8wXi for <ceph-devel@vger.kernel.org>;
	Sun,  7 Jul 2013 17:15:23 +1200 (NZST)
Received: from [192.168.1.64] (122-60-64-230.jetstream.xtra.co.nz [122.60.64.230])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 5B8D26789A
	for <ceph-devel@vger.kernel.org>; Sun,  7 Jul 2013 17:15:23 +1200 (NZST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080203080308010108010804
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I noticed when building with prefix=/usr/local that the install step 
produced an usr/local/sbin hierarchy *under* /usr/local (i.e 
/usr/local/usr/local/sbin) with ceph_disk and friends (i.e 
ceph_sbin_SCRIPTS) therein. I am guessing that these should actually be 
installed in /usr/local/sbin (i.e prefix/sbin).

The attached patch does this.

Regards

Mark

--------------080203080308010108010804
Content-Type: text/x-patch;
 name="src-Makefile.am.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="src-Makefile.am.patch"

diff --git a/src/Makefile.am b/src/Makefile.am
index c1a7e80..21f30dd 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -28,7 +28,7 @@ bin_PROGRAMS =
 bin_DEBUGPROGRAMS =
 sbin_PROGRAMS =
 # like sbin_SCRIPTS but can be used to install to e.g. /usr/sbin
-ceph_sbindir = $(prefix)$(sbindir)
+ceph_sbindir = $(sbindir)
 ceph_sbin_SCRIPTS = \
 	ceph-disk \
 	ceph-disk-prepare \

--------------080203080308010108010804--
