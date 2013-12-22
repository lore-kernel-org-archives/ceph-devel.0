From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.72.2 Emperor released
Date: Sat, 21 Dec 2013 21:33:15 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312212130350.2669@cobra.newdream.net>
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

This is the second bugfix release for the v0.72.x Emperor series.  We
have fixed a hang in radosgw, and fixed (again) a problem with monitor
CLI compatiblity with mixed version monitors.  (In the future this
will no longer be a problem.)

Upgrading:

* The JSON schema for the 'osd pool set ...' command changed slightly.  
  Please avoid issuing this particular command via the CLI while there is 
  a mix of v0.72.1 and v0.72.2 monitor daemons running.

Changes:

* mon: 'osd pool set ...' syntax change
* osd: added test for missing on-disk HEAD object
* osd: fix osd bench block size argument
* rgw: fix hang on large object GET
* rgw: fix rare use-after-free
* rgw: various DR bug fixes
* rgw: do not return error on empty owner when setting ACL
* sysvinit, upstart: prevent starting daemons using both init systems

For more detailed information, see the complete changelog:

 * http://ceph.com/docs/master/changelog/v0.72.2.txt

You can get v0.72.2 from the usual locations:

 * Git at git://github.com/ceph/ceph.git
 * Tarball at http://ceph.com/download/ceph-0.72.2.tar.gz
 * For packages, see http://ceph.com/docs/master/install/get-packages/
 * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy/
