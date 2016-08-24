From: Gregory Meno <gmeno-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Ceph Tech Talk - Tomorrow -- Unified CI: Transitioning
	Away from Gitbuilders
Date: Wed, 24 Aug 2016 11:52:58 -0700
Message-ID: <CABq-AyT-qNxfQUcih3uuKypgh5YuGQ9WpN0p6AjRY5ur9g3DQw@mail.gmail.com>
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
To: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

Just a reminder that the August Ceph Tech Talk is on for tomorrow
@ 1p EDT.

http://ceph.com/ceph-tech-talks/


Unified CI: Transitioning Away from Gitbuilders
===============================================
While Ceph development has relied on "gitbuilders", the release process has
always been separate.

The infrastructure team has been working towards a unified version for both
active development and releases.

Why should you care?
--------------------
The new system will get fully transitioned, and all test builds
(when running teuthology) and repository consumption will have a new
structure. Come find why
this will be better, scalable, and robust.


Current Issues with Gitbuilders
-------------------------------
* They are slow
* Very difficult to scale
* Setting them up is very time consuming and not straightforward (too many
  steps, some automation)
* Dependencies, new requirements, and environment conditions are all applied on
  the fly (ssh in, make changes)
* Fatal conditions of a server make builds dependant on that gitbuilder to be
  disabled until replaced or fixed.

New CI build system
-------------------
* As fast as making the binaries are (currently close to an hour)
* Easy to scale to produce binaries: provides an on-demand node provisioning
  for creating binaries
* Scalable repository hosting: with load balancing build-types (not
tied to one host)
* Hosts that serve repos and have issues will not prevent builds from moving
  forward, they get automatically removed from the load balancer pool
* All systems are fully configurable with automation: recovery is as fast as
  bringing up a new host.
