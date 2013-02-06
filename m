From: Alexandre Oliva <oliva@gnu.org>
Subject: silence logrotate some more
Date: Wed, 06 Feb 2013 15:27:13 -0200
Message-ID: <ormwvhnyj2.fsf@livre.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:41877 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab3BFRgy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 12:36:54 -0500
Received: from freie (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r16HRIWB015799
	for <ceph-devel@vger.kernel.org>; Wed, 6 Feb 2013 17:27:20 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I was getting email with logrotate error output from =E2=80=9Cwhich invoke-=
rc.d=E2=80=9D
on systems without an invoke-rc.d.  This patch silences it.


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=logrotate-silence-which-stderr.patch

Silence stderr from which when running logrotate

From: Alexandre Oliva <oliva@gnu.org>

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/logrotate.conf |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/src/logrotate.conf b/src/logrotate.conf
index 9af3104..c443eed 100644
--- a/src/logrotate.conf
+++ b/src/logrotate.conf
@@ -4,13 +4,16 @@
     compress
     sharedscripts
     postrotate
-        if which invoke-rc.d > /dev/null && [ -x `which invoke-rc.d` ]; then
+        if which invoke-rc.d > /dev/null 2>&1 && 
+	   [ -x `which invoke-rc.d` ]; then
             invoke-rc.d ceph reload >/dev/null
-        elif which service > /dev/null && [ -x `which service` ]; then
+        elif which service > /dev/null 2>&1 && 
+	     [ -x `which service` ]; then
             service ceph reload >/dev/null
         fi
         # Possibly reload twice, but depending on ceph.conf the reload above may be a no-op
-        if which initctl > /dev/null && [ -x `which initctl` ]; then
+        if which initctl > /dev/null 2>&1 && 
+	   [ -x `which initctl` ]; then
             # upstart reload isn't very helpful here:
             #   https://bugs.launchpad.net/upstart/+bug/1012938
             for type in mon osd mds; do

--=-=-=
Content-Type: text/plain



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
