From: Alexandre Oliva <oliva@gnu.org>
Subject: [PATCH] Fix typo in #undef in ceph-dencoder
Date: Tue, 17 Dec 2013 08:55:27 -0200
Message-ID: <ortxe7agrk.fsf@livre.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:47209 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab3LQLHI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 17 Dec 2013 06:07:08 -0500
Received: from freie.home (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.4/8.14.4/Debian-2ubuntu2) with ESMTP id rBHAts0Z009921
	for <ceph-devel@vger.kernel.org>; Tue, 17 Dec 2013 10:55:55 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=

I'm pretty sure I posted this long ago, but I don't see that it's made
it.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=dencoder-typo.patch

Fix typo in #undef in ceph-dencoder

From: Alexandre Oliva <oliva@gnu.org>

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/test/encoding/ceph_dencoder.cc |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/test/encoding/ceph_dencoder.cc b/src/test/encoding/ceph_dencoder.cc
index dbed6f5..690ef25 100644
--- a/src/test/encoding/ceph_dencoder.cc
+++ b/src/test/encoding/ceph_dencoder.cc
@@ -209,7 +209,7 @@ int main(int argc, const char **argv)
 #undef TYPEWITHSTRAYDATA
 #undef TYPE_FEATUREFUL
 #undef T_STR
-#undef T_STRRINGIFY
+#undef T_STRINGIFY
 
   vector<const char*> args;
   argv_to_vec(argc, argv, args);

--=-=-=


-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
