From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.58 released
Date: Tue, 5 Mar 2013 11:07:23 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1303051106370.28558@cobra.newdream.net>
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

It's been two weeks and v0.58 is baked. Notable changes since v0.57 
include:

 * mon: rearchitected to utilize single instance of paxos and a key/value
   store (Joao Luis)
 * librbd: fixed some locking issues with flatten (Josh Durgin)
 * rbd: udevadm settle on map/unmap to avoid various races (Dan Mick)
 * osd: move pg info, log into leveldb (== better performance) (David
   Zafman)
 * osd: fix pg log trimming (avoids memory bloat on degraded clusters)
 * osd: fixed bug in journal checksums (Sam Just)
 * osd: verify snap collections on startup (Sam Just)
 * ceph-disk-prepare/activate: support for dm-crypt (Alexandre Marangone)
 * ceph-disk-prepare/activate: support for sysvinit, directories or
   partitions (not full disks)
 * msgr: fixed race in connection reset
 * msgr: fix comparison of IPv6 addresses (fixes monitor bringup via
   ceph-deploy, chef)
 * radosgw: fix object copy onto self (Yehuda Sadeh)
 * radosgw: ACL grants in headers (Caleb Miles)
 * radosgw: ability to listen to fastcgi via a port (Guilhem Lettron)
 * mds: new encoding for all data types (to allow forward/backward
   compatbility) (Greg Farnum)
 * mds: fast failover between MDSs (enforce unique mds names)
 * crush: ability to create, remove rules via CLI
 * many many cleanups (Danny Al-Gaaf)
 * buffer unit testing (Loic Dachary)
 * fixed log rotation (Gary Lowell)

Also, although it is not part of the ceph packages, I'd also like to call
out recent work on ceph-deploy, our new easy to use deployment tool:

 * ceph-deploy: support for Debian systems
 * ceph-deploy: new safety checks
 * ceph-deploy: support for dm-crypt on OSDs

There has also been a lot of work by Joe Buck and Noah Watkins on the
Hadoop integration. The libcephfs-java package is in good shape, and
they are very close to having a single .jar file to drop into a Hadoop
installation to run on top of CephFS.

With the release of v0.58 we've also frozen v0.59, which will get two
weeks of QA before it is released.

You can get v0.58 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.58.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
