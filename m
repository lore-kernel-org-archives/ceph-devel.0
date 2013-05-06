From: Andreas Friedrich <andreas.friedrich@ts.fujitsu.com>
Subject: Request for ceph.conf environment extension
Date: Mon, 6 May 2013 11:18:22 +0200
Message-ID: <20130506091822.GA26022@upset.ux.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:32732 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752502Ab3EFJSp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 6 May 2013 05:18:45 -0400
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

we are using Infiniband instead of Ethernet for cluster interconnection.
Instead of IPoIB (IP-over-InfiniBand Protocol) we want to use SDP
(Sockets Direct Protocol) as a mid layer protocol.

To connect the Ceph daemons to SDP without changing the Ceph code, the
LD_PRELOAD mechanism can be used.

To enable the LD_PRELOAD mechanism for the Ceph daemons only, a little 
generic extension in the global section of /etc/ceph/ceph.conf would
be helpful, e.g.:

[global]
	environment = LD_PRELOAD=/usr/lib64/libsdp.so.1

The appending patch adds 5 lines in the Bobtail (0.56.6) init script.
The init script will then read the environment setting and - if present -
call the Ceph daemons with the preceding environment string.

With best regards
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

--jI8keyz6grp/JLjh
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="ceph-init-add-environment.patch"

--- a/src/init-ceph.in	2013-05-03 21:31:07.000000000 +0200
+++ b/src/init-ceph.in	2013-05-06 10:56:56.000000000 +0200
@@ -212,6 +212,12 @@
     # conf file
     cmd="$cmd -c $conf"
 
+    environment=""
+    get_conf environment '' 'environment'
+    if [ ! -z "$environment" ]; then
+        cmd="env $environment $cmd"
+    fi
+
     if echo $name | grep -q ^osd; then
 	get_conf osd_data "/var/lib/ceph/osd/ceph-$id" "osd data"
 	get_conf fs_path "$osd_data" "fs path"  # mount point defaults so osd data

--jI8keyz6grp/JLjh--
