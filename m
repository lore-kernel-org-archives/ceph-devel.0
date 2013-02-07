From: Yasuhiro Ohara <yasu@soe.ucsc.edu>
Subject: init.d script dirty hack
Date: Thu, 07 Feb 2013 12:27:21 -0800 (PST)
Message-ID: <20130207.122721.55387722.yasu@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Thu_Feb__7_12_27_21_2013_247)--"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f51.google.com ([209.85.210.51]:43975 "EHLO
	mail-da0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759364Ab3BGU2q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Feb 2013 15:28:46 -0500
Received: by mail-da0-f51.google.com with SMTP id n15so1391753dad.24
        for <ceph-devel@vger.kernel.org>; Thu, 07 Feb 2013 12:28:45 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

----Next_Part(Thu_Feb__7_12_27_21_2013_247)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit


Hi,

I know that Ceph is going to use more sophisticated version of
start-up mechanisms, but in case if anyone is interested,
here I share my tweak on the Ceph's init.d script.

We're using Fedora and it switched to systemd from upstart.
Ceph does not seem to support systemd yet, so I needed to use
the old init.d script.

Since I wanted to use a different name in the configuration file,
such as node-1, node-2 (set as a DNS alias using CNAME),
instead of the real hostname such as 'saturn' and 'jupiter',
I made a few modifications to the script.
The modifications work like this: acquire the IP address
by the reverse DNS lookup using 'dig' command,
and if the IP addresses from both the hostname of the host
and the hostname from the configuration are identical,
overwrite 'hostname' variable to the one from the configuration file.

Also, system start up mechanism nowadays seems work in parallel:
we may not have the hostname properly set yet when the init script issued.
So I made a sleep cycle in the script.

regards,
Yasu


----Next_Part(Thu_Feb__7_12_27_21_2013_247)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="ceph_common.sh.patch"

--- ceph_common.sh.bak	2013-02-04 18:03:20.338241517 -0800
+++ 2013-02-05-ceph-sysvinit/ceph_common.sh	2013-02-05 15:54:20.118944232 -0800
@@ -38,6 +38,10 @@
 	echo "$0: use a proper short hostname (hostname -s), not 'localhost', in $conf section $type.$id; skipping entry"
 	return 1
     fi
+    if [ "$hostname" = "localhost" ]; then
+	echo "$0: hostname has not yet been set for this host; skip"
+	return 1
+    fi
     ssh=""
     rootssh=""
     sshdir=$PWD
@@ -50,6 +54,17 @@
 	return 1
     fi
 
+    domain=`hostname | sed -e 's/^[a-z]\+\.//'`
+    dig="dig +noall +answer"
+    gopt='IN[[:space:]]A'
+    hostnameaddr=`$dig $hostname.$domain | grep $gopt | awk '{print $5;}'`
+    hostaddr=`$dig $host.$domain | grep $gopt | awk '{print $5;}'`
+    # echo "ceph-init: $domain : $hostaddr = $hostnameaddr ?\n"
+    if [ ! -z "$hostnameaddr" ] && [ "$hostaddr" = "$hostnameaddr" ]; then
+        hostname=$host
+        echo "OVERRIDE hostname: $hostname\n"
+    fi
+
     if [ "$host" != "$hostname" ]; then
 	# skip, unless we're starting remote daemons too
 	if [ $allhosts -eq 0 ]; then

----Next_Part(Thu_Feb__7_12_27_21_2013_247)--
Content-Type: Text/X-Patch; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="etc-init.d-ceph.patch"

--- etc-init.d-ceph.bak	2013-02-05 16:05:56.246138380 -0800
+++ 2013-02-05-ceph-sysvinit/etc-init.d-ceph	2013-02-05 16:07:30.586927312 -0800
@@ -34,6 +34,17 @@
     exit
 }
 
+waitsec=5
+while [ `hostname -s` = "localhost" ]; do
+    echo "$0: hostname not yet, sleeping $waitsec seconds."
+    sleep "$waitsec"
+    waitsec=`expr $waitsec \* 2`
+    if [ $waitsec -gt 30 ]; then
+        echo "$0: hostname not yet, give up."
+        exit
+    fi
+done
+
 . $LIBDIR/ceph_common.sh
 
 EXIT_STATUS=0

----Next_Part(Thu_Feb__7_12_27_21_2013_247)----
