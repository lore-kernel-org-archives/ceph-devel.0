From: Sage Weil <sage@newdream.net>
Subject: debian
Date: Tue, 2 Mar 2010 13:37:57 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1003021257250.27181@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sf.net
List-Id: ceph-devel.vger.kernel.org

The ceph.newdream.net debian repository is now being built with reprepro, 
and has been cleaned up some.  Your sources.list entries should look like

deb http://ceph.newdream.net/debian/ $dist $what

where $dist is lenny, squeeze, or sid (it shouldn't much matter, since the 
packages are identical aside from the build environment), and $what is 
either ceph-stable (last release) or ceph-unstable (recent git snapshot).

If you see any problems, let me know!
sage

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
