From: Amon Ott <a.ott@m-privacy.de>
Subject: init script bug with multiple clusters
Date: Wed, 08 Apr 2015 11:58:17 +0200
Message-ID: <5524FBB9.9070300@m-privacy.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020802000101030202090205"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from www.m-privacy.de ([85.214.155.129]:60627 "EHLO www.m-privacy.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164AbbDHKEP (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 8 Apr 2015 06:04:15 -0400
Received: from localhost (localhost [127.0.0.1])
	by www.m-privacy.de (Postfix) with ESMTP id 81BD52400E1
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2015 11:58:25 +0200 (CEST)
Received: from www.m-privacy.de ([127.0.0.1])
 by localhost (www.m-privacy.de [127.0.0.1]) (maiad, port 10024) with ESMTP
 id 15273-04 for <ceph-devel@vger.kernel.org>;
 Wed,  8 Apr 2015 11:58:19 +0200 (CEST)
Received: from gw.compuniverse.de (f052212217.adsl.alicedsl.de [78.52.212.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by www.m-privacy.de (Postfix) with ESMTPSA id 615172400E0
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2015 11:58:19 +0200 (CEST)
Received: from [192.168.201.30] (tgham.compuniverse.de [192.168.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by gw.compuniverse.de (Postfix) with ESMTPS id 434198251C
	for <ceph-devel@vger.kernel.org>; Wed,  8 Apr 2015 11:58:18 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------020802000101030202090205
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hello Ceph!

The Ceph init script (src/init-ceph.in) creates pid files without
cluster names. This means that only one cluster can run at a time. The
solution is simple and works fine here, patch against 0.94 is attached.

Amon Ott
-- 
Dr. Amon Ott
m-privacy GmbH           Tel: +49 30 24342334
Werner-Voß-Damm 62       Fax: +49 30 99296856
12101 Berlin             http://www.m-privacy.de

Amtsgericht Charlottenburg, HRB 84946

Geschäftsführer:
 Dipl.-Kfm. Holger Maczkowsky,
 Roman Maczkowsky

GnuPG-Key-ID: 0x2DD3A649


--------------020802000101030202090205
Content-Type: text/x-patch;
 name="mprivacy-ceph-init.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mprivacy-ceph-init.diff"

--- ceph-0.93/src/init-ceph.in	2015-02-27 19:47:15.000000000 +0100
+++ ceph-0.93/src/init-ceph.in.mp	2015-04-07 13:29:47.127067864 +0200
@@ -227,7 +237,7 @@
 
     get_conf run_dir "/var/run/ceph" "run dir"
 
-    get_conf pid_file "$run_dir/$type.$id.pid" "pid file"
+    get_conf pid_file "$run_dir/$cluster-$type.$id.pid" "pid file"
 
     if [ "$command" = "start" ]; then
 	if [ -n "$pid_file" ]; then

--------------020802000101030202090205--
