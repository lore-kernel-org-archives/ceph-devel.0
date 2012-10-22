From: Joe Buck <jbbuck@gmail.com>
Subject: Re: Proposed change to vstart.sh
Date: Mon, 22 Oct 2012 08:13:37 -0700
Message-ID: <508562A1.2040106@gmail.com>
References: <508469CE.3000502@gmail.com> <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080308040001040500090509"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36400 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754155Ab2JVPT3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Oct 2012 11:19:29 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so2003549pad.19
        for <ceph-devel@vger.kernel.org>; Mon, 22 Oct 2012 08:19:28 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1210211434320.26885@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------080308040001040500090509
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Updated version of the diff with the -X flag used to turn cephX off, -x 
to turn it on (for historical consistency) and an updated help output 
that reflects this change. CephX is on by default.

I figured I'd send this out independent of the issues around vstart 
working when cephX is off getting sorted out.

-Joe Buck


On 10/21/2012 02:35 PM, Sage Weil wrote:
> On Sun, 21 Oct 2012, Joe Buck wrote:
>> It looks like vstart.sh does not work without authx enabled. Given that, I'd
>> propose to change the default to having cephx be enabled and then use the -x
>> flag to disable cephx.
>>
>> Interestingly enough, the help output for vstart.sh already states that the -x
>> flag disables authx (which is not the case at present, but is after this patch
>> is applied).
>>
>> I've attached a patch to vstart that 1) changes the mention of authx to cephx
>> for consistency and 2) defaults vstart.sh to using cephx with the -x flag now
>> serving to disable cephx.
> Sounds like a good change, but let's make -x do nothing and -X disable
> cephx, so that existing habitual typing of -x doesn't lead to failure.
>
> Also, we should fix the auth none usage at some point.  :)
>
> sage


--------------080308040001040500090509
Content-Type: text/x-patch;
 name="vstart.sh.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vstart.sh.diff"

diff --git a/src/vstart.sh b/src/vstart.sh
index 7aaad49..0b24e44 100755
--- a/src/vstart.sh
+++ b/src/vstart.sh
@@ -21,7 +21,7 @@ ip=""
 nodaemon=0
 smallmds=0
 overwrite_conf=1
-cephx=0
+cephx=1 #turn cephx on by default
 
 MON_ADDR=""
 
@@ -43,7 +43,8 @@ usage=$usage"\t--nodaemon: use ceph-run as wrapper for mon/osd/mds\n"
 usage=$usage"\t--smallmds: limit mds cache size\n"
 usage=$usage"\t-m ip:port\t\tspecify monitor address\n"
 usage=$usage"\t-k keep old configuration files\n"
-usage=$usage"\t-x disable authx\n"
+usage=$usage"\t-x enable cephx (on by default)\n"
+usage=$usage"\t-X disable cephx\n"
 usage=$usage"\t-o config\t\t add extra config parameters to mds section\n"
 
 usage_exit() {
@@ -117,7 +118,10 @@ case $1 in
 	    shift
 	    ;;
     -x )
-	    cephx=1
+	    cephx=1 # this is on be default, flag exists for historical consistency
+	    ;;
+    -X )
+	    cephx=0
 	    ;;
     -k )
 	    overwrite_conf=0

--------------080308040001040500090509--
