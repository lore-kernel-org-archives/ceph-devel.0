From: "Deneau, Tom" <tom.deneau-5C7GfCeVMHo@public.gmane.org>
Subject: rados bench object not correct errors on v9.0.3
Date: Tue, 25 Aug 2015 16:44:00 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91924D7E0E@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org



> -----Original Message-----
> From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-
> owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sage Weil
> Sent: Monday, August 24, 2015 12:45 PM
> To: ceph-announce-Qp0mS5GaXlQ@public.gmane.org; ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org;
> ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
> Subject: v9.0.3 released
> 
> This is the second to last batch of development work for the Infernalis
> cycle.  The most intrusive change is an internal (non user-visible) change to
> the OSD's ObjectStore interface.  Many fixes and improvements elsewhere
> across RGW, RBD, and another big pile of CephFS scrub/repair improvements.
> 
> 
> Getting Ceph
> ------------
> 
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://ceph.com/download/ceph-9.0.3.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see http://ceph.com/docs/master/install/install-ceph-
> deploy
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in the
> body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html

I have built rpms from the tarball http://ceph.com/download/ceph-9.0.3.tar.bz2.
Have done this for fedora 21 x86_64 and for aarch64.  On both platforms when I run
a single node "cluster" with a few osds and run rados bench read tests
(either seq or rand) I get occasional reports like

benchmark_data_myhost_20729_object73 is not correct!

I never saw these with similar rpm builds on these platforms from 9.0.2 sources.

Also, if I go to an x86-64 system running Ubuntu trusty for which I am able to
install prebuilt binary packages via
    ceph-deploy install --dev v9.0.3

I do not see the errors there.

Any suggestions welcome.

-- Tom Deneau, AMD
