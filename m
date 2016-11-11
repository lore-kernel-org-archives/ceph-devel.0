From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Can we drop ubuntu 14.04 (trusty) for kraken and
	lumninous?
Date: Fri, 11 Nov 2016 18:43:35 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1611111837410.29579@piezo.us.to>
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
To: ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Currently the distros we use for upstream testing are

 centos 7.x
 ubuntu 16.04 (xenial)
 ubuntu 14.04 (trusty)

We also do some basic testing for Debian 8 and Fedora (some old version).

Jewel was the first release that had native systemd and full xenial 
support, so it's helpful to have both 14.04 and 16.04 supported to provide 
an upgrade path.  But I think we can safely drop 14.04 now for kraken and 
luminous.  Our options are

1) keep testing on xenial and trusty, and keep building packages for both

2) stop testing trusty, but still build packages

3) stop testing or building for trusty

Preferences?
sage
