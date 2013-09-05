From: Mark Kirkwood <mark.kirkwood@catalyst.net.nz>
Subject: Re: Ceph-deploy (git from today) fails to create osd on host that
 does not have a mon
Date: Thu, 05 Sep 2013 18:27:46 +1200
Message-ID: <52282462.9030305@catalyst.net.nz>
References: <52281D10.9090507@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050903080104040007000504"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:48948 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756660Ab3IEG1v (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 5 Sep 2013 02:27:51 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id AF108678D1
	for <ceph-devel@vger.kernel.org>; Thu,  5 Sep 2013 18:27:47 +1200 (NZST)
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L8blFkqRphCu for <ceph-devel@vger.kernel.org>;
	Thu,  5 Sep 2013 18:27:46 +1200 (NZST)
Received: from [IPv6:2404:130:0:1000:222:4dff:fe88:a586] (unknown [IPv6:2404:130:0:1000:222:4dff:fe88:a586])
	(Authenticated sender: mark.kirkwood)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 8CDEB678C1
	for <ceph-devel@vger.kernel.org>; Thu,  5 Sep 2013 18:27:46 +1200 (NZST)
In-Reply-To: <52281D10.9090507@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------050903080104040007000504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/13 17:56, Mark Kirkwood wrote:
>
>
> [ceph_deploy.osd][DEBUG ] Preparing cluster ceph disks 
> ceph2:/dev/vdb:/dev/vdc
> [ceph_deploy.osd][INFO  ] Distro info: Ubuntu 12.04 precise
> [ceph_deploy.osd][DEBUG ] Deploying osd to ceph2
> [ceph2][INFO  ] write cluster configuration to /etc/ceph/{cluster}.conf
> [ceph2][INFO  ] keyring file does not exist, creating one at: 
> /var/lib/ceph/bootstrap-osd/ceph.keyring
> [ceph2][INFO  ] create mon keyring file
> [ceph2][ERROR ] Traceback (most recent call last):
> [ceph2][ERROR ]   File 
> "/home/markir/develop/python/ceph-deploy/ceph_deploy/util/decorators.py", 
> line 10, in inner
> [ceph2][ERROR ]   File 
> "/home/markir/develop/python/ceph-deploy/ceph_deploy/osd.py", line 14, 
> in write_keyring
> [ceph2][ERROR ] NameError: global name 'key' is not defined
>

The attached patch seems to fix it.

Cheers

Mark

--------------050903080104040007000504
Content-Type: text/x-patch;
 name="osd.py.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="osd.py.diff"

diff --git a/ceph_deploy/osd.py b/ceph_deploy/osd.py
index 4cf0b0a..178f737 100644
--- a/ceph_deploy/osd.py
+++ b/ceph_deploy/osd.py
@@ -48,7 +48,7 @@ def create_osd(conn, logger, cluster, key):
             pid=conn.modules.os.getpid(),
             )
 
-        def write_keyring(tmp, path):
+        def write_keyring(tmp, path, key):
             """ create mon keyring file """
             # file() doesn't let us control access mode from the
             # beginning, and thus would have a race where attacker can
@@ -67,7 +67,7 @@ def create_osd(conn, logger, cluster, key):
             os.rename(tmp, path)
 
         with remote(conn, logger, write_keyring) as remote_func:
-            remote_func(tmp, path)
+            remote_func(tmp, path, key)
 
     return check_call(
         conn,

--------------050903080104040007000504--
