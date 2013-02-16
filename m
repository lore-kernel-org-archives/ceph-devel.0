From: Alexandre Oliva <oliva@gnu.org>
Subject: Re: mds crashes upon access to some snapshotted files
Date: Sat, 16 Feb 2013 15:00:42 -0200
Message-ID: <orfw0wry6d.fsf@livre.home>
References: <ortxpcs9h5.fsf@livre.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from linux-libre.fsfla.org ([208.118.235.54]:59265 "EHLO
	linux-libre.fsfla.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753662Ab3BPRFV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 16 Feb 2013 12:05:21 -0500
Received: from freie (home.lxoliva.fsfla.org [172.31.160.22])
	by linux-libre.fsfla.org (8.14.3/8.14.3/Debian-9.1ubuntu1) with ESMTP id r1GH5GBN002118
	for <ceph-devel@vger.kernel.org>; Sat, 16 Feb 2013 17:05:17 GMT
In-Reply-To: <ortxpcs9h5.fsf@livre.home> (Alexandre Oliva's message of "Sat,
	16 Feb 2013 10:56:38 -0200")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--=-=-=

On Feb 16, 2013, Alexandre Oliva <oliva@gnu.org> wrote:

> I suppose this might be the result of some filesystem corruption, but I
> have some files in my ceph tree that, when accessed, crash the mds.

Here's another patch from my mds crash avoidance series.

With it, instead of a crash, I get a message like this in the mds log:

  2013-02-16 13:49:16.360480 7f0e7a0f1700  0 mds.0.cache  hmm, 82 is not the first in old_inodes; 2 is


--=-=-=
Content-Type: text/x-diff
Content-Disposition: inline; filename=mds-relax-p-not-first-assert.patch

mds: relax p-not-first assert within first>last

From: Alexandre Oliva <oliva@gnu.org>

Instead of crashing, just warn about p not being the initial entry in
old_inodes.

Signed-off-by: Alexandre Oliva <oliva@gnu.org>
---
 src/mds/MDCache.cc |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/mds/MDCache.cc b/src/mds/MDCache.cc
index 58a8b8a..32faf396 100644
--- a/src/mds/MDCache.cc
+++ b/src/mds/MDCache.cc
@@ -1763,7 +1763,13 @@ void MDCache::project_rstat_frag_to_inode(nest_info_t& rstat, nest_info_t& accou
 	first = p->second.first;
 	if (first > last) {
 	  dout(10) << " oldest old_inode is [" << first << "," << p->first << "], done." << dendl;
-	  assert(p == pin->old_inodes.begin());
+	  if (p != pin->old_inodes.begin())
+	    dout(0) << " hmm, " << p->first
+		    << " is not the first in old_inodes; "
+		    << (pin->old_inodes.begin() != pin->old_inodes.end()
+			? pin->old_inodes.begin()->first
+			: snapid_t (CEPH_NOSNAP))
+		    << " is" << dendl;
 	  break;
 	}
 	if (p->first > last) {

--=-=-=



-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer

--=-=-=--
