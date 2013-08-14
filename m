From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.67 Dumpling released
Date: Tue, 13 Aug 2013 22:32:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1308132222350.18836@cobra.newdream.net>
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

Another three months have gone by, and the next stable release of Ceph is 
ready: Dumpling!  Thank you to everyone who has contributed to this 
release!

This release focuses on a few major themes since v0.61 (Cuttlefish):

 * rgw: multi-site, multi-datacenter support for S3/Swift object storage
 * new RESTful API endpoint for administering the cluster, based on a new 
   and improved management API and updated CLI
 * mon: stability and performance
 * osd: stability performance
 * cephfs: open-by-ino support (for improved NFS reexport)
 * improved support for Red Hat platforms
 * use of the Intel CRC32c instruction when available

As with previous stable releases, you can upgrade from previous versions 
of Ceph without taking the entire cluster online, as long as a few simple 
guidelines are followed.

 * For Dumpling, we have tested upgrades from both Bobtail and Cuttlefish.  
   If you are running Argonaut, please upgrade to Bobtail and then to 
   Dumpling.
 * Please upgrade daemons/hosts in the following order:
   1. Upgrade ceph-common on all nodes that will use the command line ceph 
      utility.
   2. Upgrade all monitors (upgrade ceph package, restart ceph-mon 
      daemons). This can happen one daemon or host at a time. Note that 
      because cuttlefish and dumpling monitors cant talk to each other, 
      all monitors should be upgraded in relatively short succession to
      minimize the risk that an untimely failure will reduce availability.
   3. Upgrade all osds (upgrade ceph package, restart ceph-osd daemons). 
      This can happen one daemon or host at a time.
   4. Upgrade radosgw (upgrade radosgw package, restart radosgw daemons).

There are several small compatibility changes between Cuttlefish and 
Dumpling, particularly with the CLI interface.  Please see the complete 
release notes for a summary of the changes since v0.66 and v0.61 
Cuttlefish, and other possible issues that should be considered before 
upgrading:

   http://ceph.com/docs/master/release-notes/#v0-67-dumpling

Dumpling is the second Ceph release on our new three-month stable release 
cycle.  We are very pleased to have pulled everything together on 
schedule.  The next stable release, which will be code-named Emperor, is 
slated for three months from now (beginning of November).

You can download v0.67 Dumpling from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.67.tar.gz
 * For Debian/Ubuntu packages, see http://ceph.com/docs/master/install/debian
 * For RPMs, see http://ceph.com/docs/master/install/rpm
