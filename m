From: "Yan, Zheng" <ukernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: cephfs snapshot format upgrade
Date: Tue, 10 Apr 2018 20:44:58 +0800
Message-ID: <CAAM7YAnaiG6sTcQ=O7Sg36kq9u=APfOffBY4aY4OjWCGtfTNGQ@mail.gmail.com>
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Hello

To simplify snapshot handling in multiple active mds setup, we changed
format of snaprealm in mimic dev.
https://github.com/ceph/ceph/pull/16779.

The new version mds can handle old format snaprealm in single active
setup. It also can convert old format snaprealm to the new format when
snaprealm is modified. The problem is that new version mds can not
properly handle old format snaprealm in multiple active setup. It may
crash when it encounter old format snaprealm. For existing filesystem
with snapshots, upgrading mds to mimic seems to be no problem at first
glance. But if user later enables multiple active mds,  mds may
crashes continuously. No easy way to switch back to single acitve mds.

I don't have clear idea how to handle this situation. I can think of a
few options.

1. Forbid multiple active before all old snapshots are deleted or
before all snaprealms are converted to new format. Format conversion
requires traversing while whole filesystem tree.  Not easy to
implement.

2. Ask user to delete all old snapshots before upgrading to mimic,
make mds just ignore old format snaprealms.


Regards
Yan, Zheng
