From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.61.1 released
Date: Thu, 9 May 2013 10:06:21 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1305091004170.32690@cobra.newdream.net>
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

This release fixes a problem when upgrading a bobtail cluster that had 
snapshots to cuttlefish.  Please use this instead of v0.61 if you are 
upgrading to avoid possible ceph-osd daemon crashes.  There is also fix 
for a problem deploying monitors and generating new authentication keys.

Notable changes:

 * osd: handle upgrade when legacy snap collections are present; repair 
   from previous failed restart
 * ceph-create-keys: fix race with ceph-mon startup (which broke 
   'ceph-deploy gatherkeys ...')
 * ceph-create-keys: gracefully handle bad response from ceph-osd
 * sysvinit: do not assume default osd_data when automatically weighting 
   OSD
 * osd: avoid crash from ill-behaved classes using getomapvals
 * debian: fix squeeze dependency
 * mon: debug options to log or dump leveldb transactactions

You can get v0.61.1 from the usual places:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.61.1.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
