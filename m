From: Michael Kuriger <mk7193-CivJcMWXhi0@public.gmane.org>
Subject: New Calamari server
Date: Mon, 11 May 2015 21:43:34 +0000
Message-ID: <D1766F6E.30C8E%mk7193@yp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
Content-ID: <C3CA51412BFF654CB6B77D6DD1D21FE0-CivJcMWXhi0@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
Cc: Ceph Development <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

I had an issue with my calamari server, so I built a new one from scratch.
 I=B9ve been struggling trying to get the new server to start up and see my
ceph cluster.  I went so far as to remove salt and diamond from my ceph
nodes and reinstalled again.  On my calamari server, it sees the hosts
connected but doesn=B9t detect a cluster.  What am I missing?  I=B9ve set up
many calamari servers on different ceph clusters, but this is the first
time I=B9ve tried to build a new calamari server.

Here=B9s what I see on my calamari GUI:

New Calamari Installation

This appears to be the first time you have started Calamari and there are
no clusters currently configured.

33 Ceph servers are connected to Calamari, but no Ceph cluster has been
created yet. Please use ceph-deploy to create a cluster; please see the
Inktank Ceph Enterprise documentation for more details.

Thanks!
Mike Kuriger
