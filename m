From: Alfredo Deza <adeza-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: ceph-disk is getting removed from master
Date: Wed, 23 May 2018 11:12:52 -0400
Message-ID: <CAC-Np1yDMEjNsBth_TkzAhbefRZOnXxjVcK2EieMOKXXMWCfpA@mail.gmail.com>
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Willem Jan Withagen <wjw-dOtk1Lsa4IaEVqv0pETR8A@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

Now that Mimic is fully branched out from master, ceph-disk is going
to be removed from master so that it is no longer available for the N
release (pull request to follow)

ceph-disk should be considered as "frozen" and deprecated for Mimic,
in favor of ceph-volume.

This means that if you are relying on ceph-disk *at all*, you should
plan on migrating to ceph-volume for Mimic, and should expect breakage
if using/testing it in master.

Please refer to the guide to migrate away from ceph-disk [0]

Willem, we don't have a way of directly supporting FreeBSD, I've
suggested that a plugin would be a good way to consume ceph-volume
with whatever FreeBSD needs, alternatively forking ceph-disk could be
another option?


Thanks


[0] http://docs.ceph.com/docs/master/ceph-volume/#migrating
