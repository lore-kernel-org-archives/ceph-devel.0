From: CC Lien <cc_lien@tcloudcomputing.com>
Subject: [PATCH] mkcephfs: Fix wrong maxosd when OSD ids are random ordered in
	ceph.conf
Date: Tue, 29 Jun 2010 22:29:11 +0800
Message-ID: <AANLkTimunpW727r2xM0itVW6iHRIxKTuYLK4kBHCsF3Z@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48222 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754445Ab0F2O3O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Jun 2010 10:29:14 -0400
Received: by pvc7 with SMTP id 7so148384pvc.19
        for <ceph-devel@vger.kernel.org>; Tue, 29 Jun 2010 07:29:11 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi

I got a trouble that mkcephfs will have wrong "maxosd" when you have
ceph.conf with OSD ids in random order like:

[osd2]
...
[osd0]
...
[osd1]
...

In this case, you will got "2" for the "maxosd", instead of 3.
After adding a sort, the problem seems solved.


Cheers,
CC Lien

Signed-off-by: CC Lien <cc_lien@tcloudcomputing.com>
---
 src/mkcephfs.in |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/mkcephfs.in b/src/mkcephfs.in
index 2edaad1..3cad4cf 100644
--- a/src/mkcephfs.in
+++ b/src/mkcephfs.in
@@ -110,7 +110,7 @@ if echo $what | grep -q mon0 ; then
     # build osdmap
     osdmap="/tmp/osdmap.$$"
     if [ -z "$numosd" ]; then
-	maxosd=`$CCONF -c $conf -l osd | egrep -v '^osd$' | tail -1 | cut -c 4-`
+	maxosd=`$CCONF -c $conf -l osd | egrep -v '^osd$' | cut -c 4- | sort
-n | tail -1`
 	numosd=$(($maxosd + 1))
 	echo max osd in $conf is $maxosd, num osd is $numosd
     fi
-- 
1.7.0.4
