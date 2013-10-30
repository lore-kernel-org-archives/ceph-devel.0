From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: 0.72-rc1 Emperor release candidate released
Date: Wed, 30 Oct 2013 14:11:22 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1310301401500.1782@cobra.newdream.net>
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

A release candidate for 0.72 emperor is ready!  This candidate squashes 
the last of the blocker bugs and includes all of the functionality that 
will be present in the final 0.72.  Looking back to dumpling, overall I 
think we are also in much better shape than before: better overall 
stability from our testing and much broader test coverage.

Please test!

Emperor will include several key improvements over dumpling:

 - improved crc32c performance (intel optimizations, caching)
 - mon: friendly warnings when pg counts are out of whack
 - mon: per-pool performance statistics
 - mon: stability and cpu utilization improvements
 - osd: improved interaction with backend file systems (lower latency)
 - osd, librados: new copy primitives (to support in-progress tiering 
   work)
 - osd: lots of internal clean and refactoring (to support erasure coding)
 - rgw: bucket quotas
 - rgw: performance improvements
 - rgw: validate S3 tokens against keystone
 - mds: many many bug fixes and improvements (mostly from Yan, Zheng of 
   Intel)
 - librados: new class and client example code

The draft release notes can be found here:

 - http://ceph.com/docs/master/release-notes/

You can get the emperor packages from the 'testing' rpm and deb locations:

 - http://ceph.com/debian-testing
 - http://ceph.com/rpm-testing

We will also be putting them in the stable emperor locations shortly 
(e.g., /debian-emperor).

If you anticipate moving from dumpling to emperor, please try this release 
on any test environment you have available.  If you are still running 
cuttlefish or bobtail, upgrade to dumpling already!

sage
