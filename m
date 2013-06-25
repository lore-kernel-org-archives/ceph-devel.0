From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.65 released
Date: Tue, 25 Jun 2013 14:26:29 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1306251424580.20428@cobra.newdream.net>
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

Our next development release v0.65 is out, with a few big changes. First 
and foremost, this release includes a complete revamp of the architecture 
for the command line interface in order to lay the groundwork for our 
ongoing REST management API work. The 'ceph' command line tool is now a 
thin python wrapper around librados. Note that this set of changes 
includes several small incompatible changes in the interface that tools or 
scripts utilizing the CLI should be aware of; these are detailed in the 
complete release notes.

Other notable changes:
 * mon, ceph: huge revamp of CLI and internal admin API. (Dan Mick)
 * mon: new capability syntax
 * osd: do not use fadvise(DONTNEED) on XFS (data corruption on power 
   cycle)
 * osd: recovery and peering performance improvements
 * osd: new writeback throttling (for less bursty write performance) (Sam 
   Just)
 * osd: ping/heartbeat on public and private interfaces
 * osd: avoid osd flapping from asymmetric network failure
 * osd: re-use partially deleted PG contents when present (Sam Just)
 * osd: break blacklisted client watches (David Zafman)
 * mon: many stability fixes (Joao Luis)
 * mon, osd: many memory leaks fixed
 * mds: misc stability fixes (Yan, Zheng, Greg Farnum)
 * mds: many backpointer improvements (Yan, Zheng)
 * mds: new robust open-by-ino support (Yan, Zheng)
 * ceph-fuse, libcephfs: fix a few caps revocation bugs
 * librados: new calls to administer the cluster
 * librbd: locking tests (Josh Durgin)
 * ceph-disk: improved handling of odd device names
 * ceph-disk: many fixes for RHEL/CentOS, Fedora, wheezy
 * many many fixes from static code analysis (Danny Al-Gaaf)
 * daemons: create /var/run/ceph as needed

The complete release notes, including upgrade notes, can be found at:

   http://ceph.com/docs/master/release-notes/#v0-65

We have one more sprint to go before the Dumpling feature freeze. Big 
items include monitor performance and stability improvements and 
multi-site and disaster recovery features for radosgw. Lots of radosgw has 
already appeard in rgw-next but these changes will not land until v0.67.

You can get v0.65 from the usual locations:
 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.65.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
