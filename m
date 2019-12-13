From: Abhishek Lekshmanan <abhishek-IBi9RG/b67k@public.gmane.org>
Subject: v13.2.8 Mimic released
Date: Fri, 13 Dec 2019 18:10:14 +0100
Message-ID: <877e30cft5.fsf@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-announce-bounces-a8pt6IJUokc@public.gmane.org>
List-Archive: <https://lists.ceph.io/hyperkitty/list/ceph-announce-a8pt6IJUokc@public.gmane.org/>
List-Help: <mailto:ceph-announce-request-a8pt6IJUokc@public.gmane.org?subject=help>
List-Post: <mailto:ceph-announce-a8pt6IJUokc@public.gmane.org>
List-Subscribe: <mailto:ceph-announce-join-a8pt6IJUokc@public.gmane.org>
List-Unsubscribe: <mailto:ceph-announce-leave-a8pt6IJUokc@public.gmane.org>
To: ceph-announce-a8pt6IJUokc@public.gmane.org, ceph-users-a8pt6IJUokc@public.gmane.org, dev-a8pt6IJUokc@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


This is the eighth backport release in the Ceph Mimic stable release
series. Its sole purpose is to fix a regression that found its way into
the previous release. 

Notable Changes
---------------

* Due to a missed backport, clusters in the process of being upgraded from
  13.2.6 to 13.2.7 might suffer an OSD crash in build_incremental_map_msg.
  This regression was reported in https://tracker.ceph.com/issues/43106
  and is fixed in 13.2.8 (this release). Users of 13.2.6 can upgrade to 13.2.8
  directly - i.e., skip 13.2.7 - to avoid this.

Changelog
---------

* osd: fix sending incremental map messages (issue#43106 pr#32000, Sage Weil)
* tests: added missing point release versions (pr#32087, Yuri Weinstein)
* tests: rgw: add missing force-branch: ceph-mimic for swift tasks (pr#32033, Casey Bodley)

For a blog with links to PRs and issues please check out
https://ceph.io/releases/v13-2-8-mimic-released/

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://download.ceph.com/tarballs/ceph-13.2.8.tar.gz
* For packages, see http://docs.ceph.com/docs/master/install/get-packages/
* Release git sha1: 5579a94fafbc1f9cc913a0f5d362953a5d9c3ae0

-- 
Abhishek Lekshmanan
SUSE Software Solutions Germany GmbH
_______________________________________________
Ceph-announce mailing list -- ceph-announce-a8pt6IJUokc@public.gmane.org
To unsubscribe send an email to ceph-announce-leave-a8pt6IJUokc@public.gmane.org
