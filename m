From: Joe Buck <jbbuck@gmail.com>
Subject: Proposed change to vstart.sh
Date: Sun, 21 Oct 2012 14:31:58 -0700
Message-ID: <508469CE.3000502@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020804090403040406040401"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:43788 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754574Ab2JUVb6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 21 Oct 2012 17:31:58 -0400
Received: by mail-da0-f46.google.com with SMTP id n41so1053716dak.19
        for <ceph-devel@vger.kernel.org>; Sun, 21 Oct 2012 14:31:57 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020804090403040406040401
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

It looks like vstart.sh does not work without authx enabled. Given that, 
I'd propose to change the default to having cephx be enabled and then 
use the -x flag to disable cephx.

Interestingly enough, the help output for vstart.sh already states that 
the -x flag disables authx (which is not the case at present, but is 
after this patch is applied).

I've attached a patch to vstart that 1) changes the mention of authx to 
cephx for consistency and 2) defaults vstart.sh to using cephx with the 
-x flag now serving to disable cephx.

Best,
-Joe Buck

--------------020804090403040406040401
Content-Type: text/x-patch;
 name="vstart.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vstart.diff"

diff --git a/src/vstart.sh b/src/vstart.sh
index 7aaad49..b23b83a 100755
--- a/src/vstart.sh
+++ b/src/vstart.sh
@@ -21,7 +21,7 @@ ip=""
 nodaemon=0
 smallmds=0
 overwrite_conf=1
-cephx=0
+cephx=1 #turn cephx on by default
 
 MON_ADDR=""
 
@@ -43,7 +43,7 @@ usage=$usage"\t--nodaemon: use ceph-run as wrapper for mon/osd/mds\n"
 usage=$usage"\t--smallmds: limit mds cache size\n"
 usage=$usage"\t-m ip:port\t\tspecify monitor address\n"
 usage=$usage"\t-k keep old configuration files\n"
-usage=$usage"\t-x disable authx\n"
+usage=$usage"\t-x disable cephx\n"
 usage=$usage"\t-o config\t\t add extra config parameters to mds section\n"
 
 usage_exit() {
@@ -117,7 +117,7 @@ case $1 in
 	    shift
 	    ;;
     -x )
-	    cephx=1
+	    cephx=0
 	    ;;
     -k )
 	    overwrite_conf=0

--------------020804090403040406040401--
