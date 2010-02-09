From: Josef Bacik <josef@redhat.com>
Subject: [PATCH] CEPH: fix manpages so they are only installed
	once
Date: Tue, 9 Feb 2010 10:18:03 -0500
Message-ID: <20100209151802.GA10045@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ceph-devel>
List-Post: <mailto:ceph-devel@lists.sourceforge.net>
List-Help: <mailto:ceph-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ceph-devel>,
	<mailto:ceph-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ceph-devel-bounces@lists.sourceforge.net
To: ceph-devel@lists.sourceforge.net
List-Id: ceph-devel.vger.kernel.org

While creating a spec file for CEPH, rpmbuild was complaining because make
install was copying the manpages in, and then copying them in again.  This is
because man_MANS and dist_man_MANS are supposed to be two seperate lists that do
not overlap.  So make install would install all the man pages in the man_MANS
list and the dist_man_MANS list.  This patch kills the dist_man_MANS thing to
keep this from happening.  This made rpmbuild happy, which makes me happy :).
Thanks,

Signed-off-by: Josef Bacik <josef@redhat.com>
---
 man/Makefile.am |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/man/Makefile.am b/man/Makefile.am
index 56bc6e1..c3e139f 100644
--- a/man/Makefile.am
+++ b/man/Makefile.am
@@ -17,5 +17,3 @@ man_MANS = \
 	mount.ceph.8 \
 	radosgw.8 \
 	radosgw_admin.8
-
-dist_man_MANS = $(man_MANS)
\ No newline at end of file
-- 
1.6.2.5


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
