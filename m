From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: dropping python 2 for nautilus... go/no-go
Date: Wed, 16 Jan 2019 15:45:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1901161328370.15033@piezo.novalocal>
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

Hi everyone,

This has come up several times before, but we need to make a final 
decision.  Alfredo has a PR prepared that drops Python 2 support entirely 
in master, which will mean nautilus is Python 3 only.

All of our distro targets (el7, bionic, xenial) include python 3, so that 
isn't an issue.  However, it also means that users of python-rados, 
python-rbd, and python-cephfs will need to be using python 3.

Python 2 is on its way out, and has been for years.  See

	https://pythonclock.org/

If it don't kill it in Nautilus, we'll be doing it for Octopus.

Are there major python-{rbd,cephfs,rgw,rados} users that are still Python 
2 that we need to be worried about?  (OpenStack?)

sage
