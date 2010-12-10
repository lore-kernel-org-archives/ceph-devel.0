From: john@brightbox.co.uk
Subject: [PATCH] debian: add libcrypto++-dev dependency, remove openssl dependency
Date: Fri, 10 Dec 2010 18:23:44 +0000
Message-ID: <1292005424-3821-1-git-send-email-john@brightbox.co.uk>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp181.iad.emailsrvr.com ([207.97.245.181]:60381 "EHLO
	smtp181.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752342Ab0LJSbr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Dec 2010 13:31:47 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Leach <john@brightbox.co.uk>

From: John Leach <john@brightbox.co.uk>

Signed-off-by: John Leach <john@brightbox.co.uk>
---
 debian/control |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/debian/control b/debian/control
index bc1247f..12e735d 100644
--- a/debian/control
+++ b/debian/control
@@ -4,8 +4,7 @@ Priority: optional
 Homepage: http://ceph.newdream.net/
 Vcs-Git: git://ceph.newdream.net/git/ceph.git
 Vcs-Browser: http://ceph.newdream.net/git/?p=ceph.git;a=summary
-Maintainer: Laszlo Boszormenyi (GCS) <gcs@debian.hu>
-Uploaders: Sage Weil <sage@newdream.net>
+Maintainer: Sage Weil <sage@newdream.net>
 Build-Depends: debhelper (>= 6.0.7~), autotools-dev, autoconf, automake, cdbs, libfuse-dev, libboost-dev, libedit-dev, libcrypto++-dev, libtool, libexpat1-dev, libfcgi-dev, libatomic-ops-dev, libgoogle-perftools-dev, pkg-config, libgtkmm-2.4-dev
 Standards-Version: 3.9.1
 
-- 
1.7.1

