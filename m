From: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Subject: Unique bug in ceph start script
Date: Mon, 22 Apr 2013 17:06:12 +0200
Message-ID: <20130422150612.GA22006@upset.ux.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="7JfCtLOvnd9MIVvH"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:37150 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752607Ab3DVPQT (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 11:16:19 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hallo,

I think I have found a bug in the ceph-0.56.4 start script concerning
the following code section in src/init-ceph.in:

212     if [ "$host" = "$hostname" ]; then
213         cur_conf=$conf
214     else
215         unique=`dd if=/dev/urandom bs=16 count=1 2>/dev/null | md5sum | awk '{print $1}'`
216         if echo $pushed_to | grep -v -q " $host "; then
217             scp -q $conf $host:/tmp/ceph.conf.$unique
218             trap "ssh $host rm /tmp/ceph.conf.$unique" EXIT
219             pushed_to="$pushed_to $host "
220         fi
221         cur_conf="/tmp/ceph.conf.$unique"
222     fi
223     cmd="$cmd -c $cur_conf"

Explanation:
If there are more than one OSD instances configured for remote host
"abc", the ceph configuration with a random file name will be copied
to host "abc" and the pushed_to variable will be set. 

Next time, if there is another OSD instance for remote host "abc",
the pushed_to variable is already set and therefore _no_ new ceph
configuration file will be copied to host "abc". That's OK but
nevertheless a new random file name will be created in line 215/221
and will be used in line 223. This leads to an error because the
new configuration file name is unknown on host "abc".

The appended patch fixes this misbehavior.

With best regards,
Andreas Friedrich
----------------------------------------------------------------------
FUJITSU
Fujitsu Technology Solutions GmbH
Heinz-Nixdorf-Ring 1, 33106 Paderborn, Germany
Tel: +49 (5251) 525-1512
Fax: +49 (5251) 525-321512
Email: andreas.friedrich@ts.fujitsu.com
Web: ts.fujitsu.com
Company details: de.ts.fujitsu.com/imprint
----------------------------------------------------------------------

--7JfCtLOvnd9MIVvH
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="unique-init.patch"

diff -urN a/src/init-ceph.in b/src/init-ceph.in
--- a/src/init-ceph.in	2013-03-25 18:59:06.000000000 +0100
+++ b/src/init-ceph.in	2013-04-22 16:34:02.000000000 +0200
@@ -212,8 +212,8 @@
     if [ "$host" = "$hostname" ]; then
 	cur_conf=$conf
     else
-	unique=`dd if=/dev/urandom bs=16 count=1 2>/dev/null | md5sum | awk '{print $1}'`
 	if echo $pushed_to | grep -v -q " $host "; then
+	    unique=`dd if=/dev/urandom bs=16 count=1 2>/dev/null | md5sum | awk '{print $1}'`
 	    scp -q $conf $host:/tmp/ceph.conf.$unique
 	    trap "ssh $host rm /tmp/ceph.conf.$unique" EXIT
 	    pushed_to="$pushed_to $host "

--7JfCtLOvnd9MIVvH--
