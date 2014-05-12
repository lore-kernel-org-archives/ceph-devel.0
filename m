From: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Subject: v0.80.1 Firefly released
Date: Mon, 12 May 2014 14:31:19 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1405121426370.25386@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

This first Firefly point release fixes a few bugs, the most visible
being a problem that prevents scrub from completing in some cases.

Notable Changes
---------------

* osd: revert incomplete scrub fix (Samuel Just)
* rgw: fix stripe calculation for manifest objects (Yehuda Sadeh)
* rgw: improve handling, memory usage for abort reads (Yehuda Sadeh)
* rgw: send Swift user manifest HTTP header (Yehuda Sadeh)
* libcephfs, ceph-fuse: expose MDS session state via admin socket (Yan, 
  Zheng)
* osd: add simple throttle for snap trimming (Sage Weil)
* monclient: fix possible hang from ill-timed monitor connection failure 
  (Sage Weil)
* osd: fix trimming of past HitSets (Sage Weil)
* osd: fix whiteouts for non-writeback cache modes (Sage Weil)
* osd: prevent divide by zero in tiering agent (David Zafman)
* osd: prevent busy loop when tiering agent can do no work (David Zafman)

For more detailed information, see the complete changelog:

* http://ceph.com/docs/master/_downloads/v0.80.1.txt

Getting Ceph
------------

* Git at git://github.com/ceph/ceph.git
* Tarball at http://ceph.com/download/ceph-0.80.1.tar.gz
* For packages, see http://ceph.com/docs/master/install/get-packages
* For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-deploy
