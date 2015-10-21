From: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: librbd regression with Hammer v0.94.4 -- use caution!
Date: Wed, 21 Oct 2015 11:44:48 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1510211140040.3868@cobra.newdream.net>
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
To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

There is a regression in librbd in v0.94.4 that can cause VMs to crash.  
For now, please refrain from upgrading hypervisor nodes or other librbd 
users to v0.94.4.

	http://tracker.ceph.com/issues/13559

The problem does not affect server-side daemons (ceph-mon, ceph-osd, 
etc.).

Jason's identified the bug and has a fix prepared, but it'll probably take 
a few days before we have v0.94.5 out.

	https://github.com/ceph/ceph/commit/4692c330bd992a06b97b5b8975ab71952b22477a

Thanks!
sage
