From: Phil Carns <carns@mcs.anl.gov>
Subject: minor file journal size bug
Date: Mon, 14 Jun 2010 10:19:42 -0400
Message-ID: <4C163A7E.6060701@mcs.anl.gov>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030909010704030202060109"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailhost.anl.gov ([130.202.113.50]:60909 "EHLO mailhost.anl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755146Ab0FNOoc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 14 Jun 2010 10:44:32 -0400
Received: from mailhost.anl.gov (mailhost.anl.gov [130.202.113.50])
	by localhost.anl.gov (Postfix) with ESMTP id 82E2647
	for <ceph-devel@vger.kernel.org>; Mon, 14 Jun 2010 09:19:44 -0500 (CDT)
Received: from zimbra.anl.gov (zimbra.anl.gov [130.202.101.12])
	by mailhost.anl.gov (Postfix) with ESMTP id 7D16F42
	for <ceph-devel@vger.kernel.org>; Mon, 14 Jun 2010 09:19:44 -0500 (CDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.anl.gov (Postfix) with ESMTP id 65F3819E00B9
	for <ceph-devel@vger.kernel.org>; Mon, 14 Jun 2010 09:19:44 -0500 (CDT)
Received: from zimbra.anl.gov ([127.0.0.1])
	by localhost (zimbra.anl.gov [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id X3cIEfnJDP+n for <ceph-devel@vger.kernel.org>;
	Mon, 14 Jun 2010 09:19:44 -0500 (CDT)
Received: from [192.168.0.104] (adsl-66-176-61.asm.bellsouth.net [98.66.176.61])
	by zimbra.anl.gov (Postfix) with ESMTP id 2ACA919E006E
	for <ceph-devel@vger.kernel.org>; Mon, 14 Jun 2010 09:19:44 -0500 (CDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030909010704030202060109
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I ran into a minor problem when configuring the ObjectStore to use a 
file journal that was 10 gigabytes in size (osd_journal_size = 10240).  
The osd_journal_size configuration parameter is an integer.  This would 
normally be fine since the units are in megabytes, but it can overflow 
when bit shifted in FileJournal.cc.  This causes the journal to fall 
back to trying to detect a raw block device journal.

I've attached a small patch that fixes the problem for me, but there is 
probably a cleaner way to do it.

thanks,
-Phil



--------------030909010704030202060109
Content-Type: text/x-patch;
 name="ceph-0.20.2-journal-size-overflow.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="ceph-0.20.2-journal-size-overflow.patch"

diff -Naupr ceph-0.20.2/src/os/FileJournal.cc ceph-0.20.2-patched/src/os/FileJournal.cc
--- ceph-0.20.2/src/os/FileJournal.cc	2010-05-26 18:52:59.000000000 -0500
+++ ceph-0.20.2-patched/src/os/FileJournal.cc	2010-06-14 08:54:22.416230668 -0500
@@ -58,8 +58,8 @@ int FileJournal::_open(bool forwrite, bo
   max_size = st.st_size;
   block_size = st.st_blksize;
 
-  if (create && max_size < (g_conf.osd_journal_size << 20)) {
-    uint64_t newsize = g_conf.osd_journal_size << 20;
+  if (create && max_size < (((uint64_t)g_conf.osd_journal_size) << 20)) {
+    uint64_t newsize = ((uint64_t)g_conf.osd_journal_size) << 20;
     dout(10) << "_open extending to " << newsize << " bytes" << dendl;
     r = ::ftruncate(fd, newsize);
     if (r == 0)

--------------030909010704030202060109--
