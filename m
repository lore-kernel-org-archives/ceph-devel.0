From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH 2/3] debian: move utils rbd,rados,csyn to ceph-client-tools
Date: Mon,  2 Aug 2010 13:32:44 +0200
Message-ID: <1280748765-21794-2-git-send-email-thomas@chaschperli.ch>
References: <1280748765-21794-1-git-send-email-thomas@chaschperli.ch>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.muellerit.ch ([92.51.129.153]:54074 "EHLO
	mail.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152Ab0HBLdZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Aug 2010 07:33:25 -0400
Received: from mail.muellerit.ch ([127.0.0.1])
	by localhost (mail.muellerit.ch [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id NZp8GZaQAKJB for <ceph-devel@vger.kernel.org>;
	Mon,  2 Aug 2010 13:33:20 +0200 (CEST)
Received: from gargelblaster.mit.local (80-219-106-215.dclient.hispeed.ch [80.219.106.215])
	by mail.muellerit.ch (Postfix) with ESMTPSA id 2067510BEC002
	for <ceph-devel@vger.kernel.org>; Mon,  2 Aug 2010 13:33:20 +0200 (CEST)
In-Reply-To: <1280748765-21794-1-git-send-email-thomas@chaschperli.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Thomas Mueller <thomas@chaschperli.ch>


Signed-off-by: Thomas Mueller <thomas@chaschperli.ch>
---
 debian/ceph-client-tools.install |    6 ++++++
 debian/ceph.install              |    4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/debian/ceph-client-tools.install b/debian/ceph-client-tools.install
index 49b5dd5..205eb7c 100644
--- a/debian/ceph-client-tools.install
+++ b/debian/ceph-client-tools.install
@@ -1,2 +1,8 @@
 sbin/mount.ceph
+usr/bin/csyn
+usr/bin/rados
+usr/bin/rbd
+usr/share/man/man8/csyn.8
+usr/share/man/man8/rados.8
+usr/share/man/man8/rbd.8
 usr/share/man/man8/mount.ceph.8
diff --git a/debian/ceph.install b/debian/ceph.install
index c8c7a2a..d35e8b9 100644
--- a/debian/ceph.install
+++ b/debian/ceph.install
@@ -5,14 +5,11 @@ usr/bin/cclsinfo
 usr/bin/crushtool
 usr/bin/monmaptool
 usr/bin/osdmaptool
-usr/bin/csyn
 usr/bin/crun
 usr/bin/cmon
 usr/bin/cmds
 usr/bin/cosd
 usr/bin/cauthtool
-usr/bin/rados
-usr/bin/rbd
 usr/sbin/mkcephfs
 usr/lib/ceph/ceph_common.sh
 usr/lib/rados-classes/*
@@ -23,7 +20,6 @@ usr/share/man/man8/cmds.8
 usr/share/man/man8/cosd.8
 usr/share/man/man8/mkcephfs.8
 usr/share/man/man8/crun.8
-usr/share/man/man8/csyn.8
 usr/share/man/man8/crushtool.8
 usr/share/man/man8/osdmaptool.8
 usr/share/man/man8/monmaptool.8
-- 
1.7.1

