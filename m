From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.61.5 Cuttlefish update released
Date: Thu, 18 Jul 2013 09:45:40 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307180944270.7945@cobra.newdream.net>
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

We've prepared another update for the Cuttlefish v0.61.x series. This 
release primarily contains monitor stability improvements, although there 
are also some important fixes for ceph-osd for large clusters and a few 
important CephFS fixes. We recommend that all v0.61.x users upgrade.

 * mon: misc sync improvements (faster, more reliable, better tuning)
 * mon: enable leveldb cache by default (big performance improvement)
 * mon: new scrub feature (primarily for diagnostic, testing purposes)
 * mon: fix occasional leveldb assertion on startup
 * mon: prevent reads until initial state is committed
 * mon: improved logic for trimming old osdmaps
 * mon: fix pick_addresses bug when expanding mon cluster
 * mon: several small paxos fixes, improvements
 * mon: fix bug osdmap trim behavior
 * osd: fix several bugs with PG stat reporting
 * osd: limit number of maps shared with peers (which could cause domino failures)
 * rgw: fix radosgw-admin buckets list (for all buckets)
 * mds: fix occasional client failure to reconnect
 * mds: fix bad list traversal after unlink
 * mds: fix underwater dentry cleanup (occasional crash after mds restart)
 * libcephfs, ceph-fuse: fix occasional hangs on umount
 * libcephfs, ceph-fuse: fix old bug with O_LAZY vs O_NOATIME confusion
 * ceph-disk: more robust journal device detection on RHEL/CentOS
 * ceph-disk: better, simpler locking
 * ceph-disk: do not inadvertantely mount over existing osd mounts
 * ceph-disk: better handling for unusual device names
 * sysvinit, upstart: handle symlinks in /var/lib/ceph/*

Please also refer to the complete release notes:

   http://ceph.com/docs/master/release-notes/#v0-61-5-cuttlefish

You can get v0.61.5 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.61.5.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
