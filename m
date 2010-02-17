From: Sage Weil <sage@newdream.net>
Subject: v0.19 released
Date: Wed, 17 Feb 2010 14:47:31 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1002171440270.10839@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-294301310-1266446851=:10839"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-294301310-1266446851=:10839
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

The v0.19 release is finally here.  The focus this past cycle was on=20
stability and the disk format, and things have improved greatly in that=20
area.  Our plan is to make any future disk format changes roll forward, so=
=20
that users won=E2=80=99t need to rebuild their file systems.  The protocol =
has=20
also grown feature bits that so it is at least possible to make protocol=20
changes transparent; whether we do so or not will depend on the severity=20
of the change and cost of maintaining compatibility.

Overall, things are looking good.  If you've been standing on the=20
sidelines waiting for something more stable to test, now is a good time to=
=20
try things out.  There are some lingering OSD performance problems (see=20
below), and we are still a long ways off from something we would recommend=
=20
for use in a production environment, but otherwise this release is looking=
=20
pretty good for evaluation purposes.

Changes since v0.18 include:

    * Stabilized disk format, with feature bits
    * Wire protocol feature bits
    * structure encoding versioning throughout
    * msgr: code simplification, cleanup, bug fixes
    * truncation fixes
    * debian: packaging improvements
    * rados: pool deletion, misc fixes
    * osd: recovery fixes, journaling fixes
    * lots of bug fixes (osd, mds, client)

On the kernel client side of things,

    * Support for Kerberos-like =E2=80=98cephx=E2=80=99 authentication
    * sync/directio read/write bug fixes (multiple client access to a=20
      single file)
    * writeback congestion control
    * mds ops interruptible (with control-c)
    * lots of code cleanup
    * lots of bug fixes

Notably, there are major revisions underway with the way the storage=20
daemon cosd interacts with btrfs, and these are sufficiently intrusive and=
=20
untested that they did not make it into this release.  They should be in=20
v0.20.  That means that OSD performance is still not great in v0.19.  (So=
=20
far performance with the new code is much much better.)

The primary focus areas for v0.20 will be

    * OSD performance and btrfs interface changes
    * Clustered MDS

Relevant URLs:

    * Direct download at http://ceph.newdream.net/download/ceph-0.19.tar.gz
    * For Debian packages see http://ceph.newdream.net/wiki/Debian

Enjoy!
sage
--557981400-294301310-1266446851=:10839
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&reg; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs 
proactively, and fine-tune applications for parallel performance. 
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
--557981400-294301310-1266446851=:10839
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ceph-devel mailing list
Ceph-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ceph-devel

--557981400-294301310-1266446851=:10839--
