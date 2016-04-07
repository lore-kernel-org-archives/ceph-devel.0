From: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: v10.1.1 Jewel candidate released
Date: Thu, 7 Apr 2016 14:14:25 -0400 (EDT)
Message-ID: <alpine.DEB.2.11.1604071410170.21587@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
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

Hi all,

We've pushed 10.1.1, a second release candidate for Jewel.  This fixes 
another round of bugs, and we are getting pretty close to a final release.  
There are a few known issues to watch out for:

 - Old CephFS clusters will mangle the layouts with this release; the 
fix was committed just after it was cut.  Wait for the next RC or the 
release if you're upgrading a cluster that has a CephFS data pool as pool 
0.

 - The upstart ceph-mds-all.conf file is missing.

Also, this is the first release build that includes arm64/aarch64 packages 
for Ubuntu Xenial 16.04.  Yay!  The CentOS7 builds are waiting on 
the EPEL repos; hopefully that will happen soon.

Please review the release notes before trying:

	http://docs.ceph.com/docs/master/release-notes/

Thanks!
sage
