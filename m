From: "Deneau, Tom" <tom.deneau-5C7GfCeVMHo@public.gmane.org>
Subject: Re: rados bench object not correct errors on v9.0.3
Date: Wed, 26 Aug 2015 15:23:28 +0000
Message-ID: <BC97738F8E7C8742BABED7F06FB9DF91924D8376@SATLEXDAG01.amd.com>
References: <BC97738F8E7C8742BABED7F06FB9DF91924D7E0E@SATLEXDAG01.amd.com>
	<alpine.DEB.2.00.1508251041260.13116@cobra.newdream.net>
	<90559C83A9C7FA45B5846C975DFA612DDB537017C2@ABGEX73E.FSC.NET>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <90559C83A9C7FA45B5846C975DFA612DDB537017C2-SPt524Z5ILdAuK1PVaBULA@public.gmane.org>
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
To: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek-RJz4owOZxyXQFUHtdCDX3A@public.gmane.org>, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-Qp0mS5GaXlQ@public.gmane.org" <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org


> -----Original Message-----
> From: Da=B3ek, Piotr [mailto:Piotr.Dalek-RJz4owOZxyXQFUHtdCDX3A@public.gmane.org]
> Sent: Wednesday, August 26, 2015 2:02 AM
> To: Sage Weil; Deneau, Tom
> Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ceph-users-Qp0mS5GaXlQ@public.gmane.org
> Subject: RE: rados bench object not correct errors on v9.0.3
> =

> > -----Original Message-----
> > From: ceph-devel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org [mailto:ceph-devel-
> > owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] On Behalf Of Sage Weil
> > Sent: Tuesday, August 25, 2015 7:43 PM
> =

> > > I have built rpms from the tarball http://ceph.com/download/ceph-
> > 9.0.3.tar.bz2.
> > > Have done this for fedora 21 x86_64 and for aarch64.  On both
> > > platforms when I run a single node "cluster" with a few osds and run
> > > rados bench read tests (either seq or rand) I get occasional reports
> > > like
> > >
> > > benchmark_data_myhost_20729_object73 is not correct!
> > >
> > > I never saw these with similar rpm builds on these platforms from
> > > 9.0.2
> > sources.
> > >
> > > Also, if I go to an x86-64 system running Ubuntu trusty for which I
> > > am able to install prebuilt binary packages via
> > >     ceph-deploy install --dev v9.0.3
> > >
> > > I do not see the errors there.
> >
> > Hrm.. haven't seen it on this end, but we're running/testing master
> > and not
> > 9.0.2 specifically.  If you can reproduce this on master, that'd be very
> helpful!
> >
> > There have been some recent changes to rados bench... Piotr, does this
> > seem like it might be caused by your changes?
> =

> Yes. My PR #4690 (https://github.com/ceph/ceph/pull/4690) caused rados be=
nch
> to be fast enough to sometimes run into race condition between librados's=
 AIO
> and objbencher processing. That was fixed in PR #5152
> (https://github.com/ceph/ceph/pull/5152) which didn't make it into 9.0.3.
> Tom, you can confirm this by inspecting the contents of objects questioned
> (their contents should be perfectly fine and I in line with other objects=
).
> In the meantime you can either apply patch from PR #5152 on your own or u=
se -
> -no-verify.
> =

> With best regards / Pozdrawiam
> Piotr Da=B3ek

Piotr --

Thank you.  Yes, when I looked at the contents of the objects they always
looked correct.  And yes a single object would sometimes report an error
and sometimes not.  So a race condition makes sense.

A couple of questions:

   * Why would I not see this behavior using the pre-built 9.0.3 binaries
     that get installed using "ceph-deploy install --dev v9.0.3"?  I would =
assume
     this is built from the same sources as the 9.0.3 tarball.

   * So I assume one should not compare pre 9.0.3 rados bench numbers with =
9.0.3 and after?
     The pull request https://github.com/ceph/ceph/pull/4690 did not mentio=
n the
     effect on final bandwidth numbers, did you notice what that effect was?

-- Tom
