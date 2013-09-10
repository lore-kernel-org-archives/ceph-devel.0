From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.67.3 Dumpling released
Date: Tue, 10 Sep 2013 10:05:59 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1309101004250.3239@cobra.newdream.net>
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
To: ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This point release fixes a few important performance regressions with the 
OSD (both with CPU and disk utilization), as well as several other 
important but less common problems. We recommend that all production users 
upgrade.

Notable changes since v0.67.2 include:

 * ceph-disk: partprobe after creation journal partition
 * ceph-disk: specify fs type when mounting
 * ceph-post-file: new utility to help share logs and other files with 
   ceph developers
 * libcephfs: fix truncate vs readahead race (crash)
 * mds: fix flock/fcntl lock deadlock
 * mds: fix rejoin loop when encountering pre-dumpling backpointers
 * mon: allow name and addr discovery during election stage
 * mon: always refresh after Paxos store_state (fixes recovery corner 
   case)
 * mon: fix off-by-4x bug with osd byte counts
 * osd: add and disable 'pg log keys debug' by default
 * osd: add option to disable throttling
 * osd: avoid leveldb iterators for pg log append and trim
 * osd: fix readdir_r invocations
 * osd: use fdatasync instead of sync
 * radosgw: fix sysvinit script return status
 * rbd: relicense as LGPL2
 * rgw: flush pending data on multipart upload
 * rgw: recheck object name during S3 POST
 * rgw: reorder init/startup
 * rpm: fix debuginfo package build

For more detailed information, see

 * http://ceph.com/docs/master/release-notes/#v0-67-3-dumpling
 * http://ceph.com/docs/master/_downloads/v0.67.3.txt

You can get v0.67.3 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.67.3.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
