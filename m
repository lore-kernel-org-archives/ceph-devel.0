From: Alexandre Oliva <oliva@gnu.org>
Subject: [bug #1435] fix loss of dir layout info on mds restart
Date: Tue, 19 Feb 2013 15:44:20 -0300
Message-ID: <or38wsgn3v.fsf@livre.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:35472 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933292Ab3BSSom (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Feb 2013 13:44:42 -0500
Received: from freie (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r1JIidea009603
	for <ceph-devel@vger.kernel.org>; Tue, 19 Feb 2013 18:44:40 GMT
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=

Here's a fix for bug 1435.  The MDS didn't recover default_layout for
subdirs from dir entries encoded in the parent dir, so layout policies
could be lost upon MDS restart if they didn't happen to be encoded in
some other change still present in the MDS journal.


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=cdir-fetch-recover-dir-layout.patch

Fix restoring dir layouts from dir entries

From: Alexandre Oliva <oliva@gnu.org>

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mds/CDir.cc |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/mds/CDir.cc b/src/mds/CDir.cc
index 4b1d3ef..e5a147d 100644
--- a/src/mds/CDir.cc
+++ b/src/mds/CDir.cc
@@ -1566,6 +1566,16 @@ void CDir::_fetched(bufferlist &bl, const string& want_dn)
 	  // symlink?
 	  if (in->is_symlink()) 
 	    in->symlink = symlink;
+	  else if (in->is_dir()) {
+	    default_file_layout dfl;
+	    memset(&dfl, 0, sizeof(dfl));
+	    // FIXME: this should be properly encoded
+	    if (memcmp (&dfl.layout, &in->inode.layout, sizeof(dfl)) != 0) {
+	      in->default_layout = new default_file_layout;
+	      memcpy (&in->default_layout->layout,
+		      &in->inode.layout, sizeof(dfl));
+	    }
+	  }
 	  
 	  in->dirfragtree.swap(fragtree);
 	  in->xattrs.swap(xattrs);

--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
