From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.70 released
Date: Sat, 5 Oct 2013 21:10:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310052105350.20017@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Another development release is out. Our timing on these has been slightly 
erratic. As a result, this one has a bit less stuff than 0.69 did or 0.71 
will. The highlights are some rgw and mon fixes, and the architecture 
detection for enabling the optimized Intel CRC32c code is now working 
(which is nice: it's about 8x faster than the generic code!). This is one 
minor librados API fix; librados users should check the release notes.

Notable changes include:

 * mon: a few 'ceph mon add' races fixed (command is now idempotent) (Joao 
   Luis)
 * crush: fix name caching
 * rgw: fix a few minor memory leaks (Yehuda Sadeh)
 * ceph: improve parsing of CEPH_ARGS (Benoit Knecht)
 * mon: avoid rewriting full osdmaps on restart (Joao Luis)
 * crc32c: fix optimized crc32c code (it now detects arch support 
   properly)
 * mon: fix 'ceph osd crush reweight ...' (Joao Luis)
 * osd: revert xattr size limit (fixes large rgw uploads)
 * mds: fix heap profiler commands (Joao Luis)
 * rgw: fix inefficient use of std::list::size() (Yehuda Sadeh)

For more information, please see the complete release notes:

 * http://ceph.com/docs/master/release-notes/#v0-70

You can get v0.70 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.70.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
