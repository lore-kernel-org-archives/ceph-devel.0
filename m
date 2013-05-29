From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.63 released
Date: Tue, 28 May 2013 21:05:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305282104180.20845@cobra.newdream.net>
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

Another sprint, and v0.63 is here.  This release features librbd 
improvements, mon fixes, osd robustness, and packaging fixes.

Notable features in this release include:

 * librbd: parallelize delete, rollback, flatten, copy, resize
 * librbd: ability to read from local replicas
 * osd: resurrect partially deleted PGs
 * osd: prioritize recovery for degraded PGs
 * osd: fix internal heartbeart timeouts when scrubbing very large objects
 * osd: close narrow journal race
 * rgw: fix usage log scanning for large, untrimmed logs
 * rgw: fix locking issue, user operation mask,
 * initscript: fix osd crush weight calculation when using -a
 * initscript: fix enumeration of local daemons
 * mon: several fixes to paxos, sync
 * mon: new --extract-monmap to aid disaster recovery
 * mon: fix leveldb compression, trimming
 * add 'config get' admin socket command
 * rados: clonedata command for cli
 * debian: stop daemons on uninstall; fix dependencies
 * debian wheezy: fix udev rules
 * many many small fixes from coverity scan

You can get v0.63 from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.63.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
