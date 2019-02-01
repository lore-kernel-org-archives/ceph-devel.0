From: Abhishek <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v12.2.11 Luminous released
Date: Fri, 01 Feb 2019 08:44:51 +0100
Message-ID: <9c19065114b5d833ca77877fa4aff0cd@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-announce-ceph.com/>
List-Post: <mailto:ceph-announce-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-announce-ceph.com>,
 <mailto:ceph-announce-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "Ceph-announce" <ceph-announce-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org, ceph-announce-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

We are glad to announce the eleventh bug fix release of the Luminous 
v12.2.x long term stable release series. We recommend that all users 
upgrade to this release. Please note the following precautions while 
upgrading.

Notable Changes
---------------

* This release fixes the pg log hard limit bug that was introduced in
   12.2.9, https://tracker.ceph.com/issues/36686.  A flag called
   `pglog_hardlimit` has been introduced, which is off by default. 
Enabling
   this flag will limit the length of the pg log.  In order to enable
   that, the flag must be set by running `ceph osd set pglog_hardlimit`
   after completely upgrading to 12.2.11. Once the cluster has this flag
   set, the length of the pg log will be capped by a hard limit. Once 
set,
   this flag *must not* be unset anymore.

* There have been fixes to RGW dynamic and manual resharding, which no 
longer
   leaves behind stale bucket instances to be removed manually. For 
finding and
   cleaning up older instances from a reshard a radosgw-admin command 
`reshard
   stale-instances list` and `reshard stale-instances rm` should do the 
necessary
   cleanup.

For the complete changelog, please refer to the release blog entry at 
https://ceph.com/releases/v12-2-11-luminous-released/

Getting ceph:
------------
* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-12.2.11.tar.gz
* For packages, see 
http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: 26dc3775efc7bb286a1d6d66faee0ba30ea23eee

Best,
Abhishek
