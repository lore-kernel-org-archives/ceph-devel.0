From: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: autoconfigured haproxy service?
Date: Tue, 11 Jul 2017 15:03:29 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1707111458470.3424@piezo.novalocal>
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
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Hi all,

Luminous features a new 'service map' that lets rgw's (and rgw nfs 
gateways and iscsi gateways and rbd mirror daemons and ...) advertise 
themselves to the cluster along with some metadata (like the addresses 
they are binding to and the services the provide).

It should be pretty straightforward to build a service that 
auto-configures haproxy based on this information so that you can deploy 
an rgw front-end that dynamically reconfigures itself when additional 
rgw's are deployed or removed.  haproxy has a facility to adjust its 
backend configuration at runtime[1].

Anybody interested in tackling this?  Setting up the load balancer in 
front of rgw is one of the more annoying pieces of getting ceph up and 
running in production and until now has been mostly treated as out of 
scope.  It would be awesome if there was an autoconfigured service that 
did it out of the box (and had all the right haproxy options set).

sage
