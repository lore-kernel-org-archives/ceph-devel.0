From: Thomas Mueller <thomas@chaschperli.ch>
Subject: [PATCH] add files to .gitignore
Date: Fri, 30 Jul 2010 08:19:53 +0200
Message-ID: <1280470793-6360-1-git-send-email-thomas@chaschperli.ch>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.muellerit.ch ([92.51.129.153]:54169 "EHLO
	mail.muellerit.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab0G3GUH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 30 Jul 2010 02:20:07 -0400
Received: from mail.muellerit.ch ([127.0.0.1])
	by localhost (mail.muellerit.ch [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zsv6xIgHl39X for <ceph-devel@vger.kernel.org>;
	Fri, 30 Jul 2010 08:19:55 +0200 (CEST)
Received: from gargelblaster.mit.local (zux221-125-110.adsl.green.ch [81.221.125.110])
	by mail.muellerit.ch (Postfix) with ESMTPSA id ACB9F792402E
	for <ceph-devel@vger.kernel.org>; Fri, 30 Jul 2010 08:19:55 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Thomas Mueller <thomas@chaschperli.ch>

add generated files to gitignore.


Signed-off-by: Thomas Mueller <thomas@chaschperli.ch>
---
 .gitignore |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 0858c08..1f1ee4a 100644
--- a/.gitignore
+++ b/.gitignore
@@ -49,3 +49,9 @@ testkeys
 testmsgr
 testrados
 testradospp
+ceph.spec
+compile
+config.guess
+config.sub
+libtool
+ltmain.sh
-- 
1.7.1

