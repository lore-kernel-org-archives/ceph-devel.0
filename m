From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: =?UTF-8?q?=5BPATCH=5D=20fix=20ceph=20osd=20create=20help?=
Date: Thu, 16 Aug 2012 12:56:32 +0200
Message-ID: <1345114592-3395-1-git-send-email-danny.kukawka@bisect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51493 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755254Ab2HPK4e (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Thu, 16 Aug 2012 06:56:34 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Danny Kukawka <dkukawka@suse.de>

Change ceph osd create <osd-id> to ceph osd create <uuid>, since this
is what the command is really doing.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 doc/control.rst          |    4 ++--
 src/test/cli/ceph/help.t |    2 +-
 src/tools/ceph.cc        |    2 +-
 3 Dateien ge=C3=A4ndert, 4 Zeilen hinzugef=C3=BCgt(+), 4 Zeilen entfer=
nt(-)

diff --git a/doc/control.rst b/doc/control.rst
index 677ab78..19c976e 100644
--- a/doc/control.rst
+++ b/doc/control.rst
@@ -142,9 +142,9 @@ Create a cluster snapshot. ::
=20
 Mark an OSD as lost. This may result in permanent data loss. Use with =
caution. ::
=20
-	$ ceph osd create [<id>]
+	$ ceph osd create [<uuid>]
=20
-Create a new OSD. If no ID is given, a new ID is automatically selecte=
d
+Create a new OSD. If no UUID is given, a new UUID is automatically sel=
ected
 if possible. ::
=20
 	$ ceph osd rm [<id>...]
diff --git a/src/test/cli/ceph/help.t b/src/test/cli/ceph/help.t
index 16667a5..47e5b38 100644
--- a/src/test/cli/ceph/help.t
+++ b/src/test/cli/ceph/help.t
@@ -43,7 +43,7 @@
     ceph osd crush set <osd-id> <name> <weight> [<loc1> [<loc2> ...]]
     ceph osd crush move <bucketname> <loc1> [<loc2> ...]
     ceph osd crush reweight <name> <weight>
-    ceph osd create [<osd-id>]
+    ceph osd create [<uuid>]
     ceph osd rm <osd-id> [<osd-id>...]
     ceph osd lost [--yes-i-really-mean-it]
     ceph osd reweight <osd-id> <weight>
diff --git a/src/tools/ceph.cc b/src/tools/ceph.cc
index caa338c..b82be10 100644
--- a/src/tools/ceph.cc
+++ b/src/tools/ceph.cc
@@ -86,7 +86,7 @@ static void usage()
   cout << "  ceph osd crush set <osd-id> <name> <weight> [<loc1> [<loc=
2> ...]]\n";
   cout << "  ceph osd crush move <bucketname> <loc1> [<loc2> ...]\n";
   cout << "  ceph osd crush reweight <name> <weight>\n";
-  cout << "  ceph osd create [<osd-id>]\n";
+  cout << "  ceph osd create [<uuid>]\n";
   cout << "  ceph osd rm <osd-id> [<osd-id>...]\n";
   cout << "  ceph osd lost [--yes-i-really-mean-it]\n";
   cout << "  ceph osd reweight <osd-id> <weight>\n";
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
