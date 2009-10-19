From: Sage Weil <sage@newdream.net>
Subject: v0.17 released
Date: Mon, 19 Oct 2009 16:08:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0910191607530.24087@cobra.newdream.net>
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

We've released v0.17.  This is mainly bug fixes and some monitor 
improvements.  Changes since v0.16 include:

    * kclient: fix >1 mds mdsmap decoding
    * kclient: fix mon subscription renewal
    * osdmap: fix encoding bug (and resulting kclient crash)
    * msgr: simplified policy, failure model, code
    * mon: less push, more pull
    * mon: clients maintain single monitor session, requests and replies 
      are routed by the cluster
    * mon cluster expansion works (see Monitor cluster expansion)
    * osd: fix pgid parsing bug (broke restarts on clusters with 10 osds 
      or more)

The other change with this release is that the kernel code is no longer 
bundled with the server code; it lives in a separate git tree.

sage

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
