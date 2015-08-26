From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: rados bench object not correct errors on v9.0.3
Date: Wed, 26 Aug 2015 09:02:08 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB537017C2@ABGEX73E.FSC.NET>
References: <BC97738F8E7C8742BABED7F06FB9DF91924D7E0E@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1508251041260.13116@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:62287 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756101AbbHZHCL convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Aug 2015 03:02:11 -0400
In-Reply-To: <alpine.DEB.2.00.1508251041260.13116@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, "Deneau, Tom" <tom.deneau@amd.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Tuesday, August 25, 2015 7:43 PM

> > I have built rpms from the tarball http://ceph.com/download/ceph-
> 9.0.3.tar.bz2.
> > Have done this for fedora 21 x86_64 and for aarch64.  On both
> > platforms when I run a single node "cluster" with a few osds and ru=
n
> > rados bench read tests (either seq or rand) I get occasional report=
s
> > like
> >
> > benchmark_data_myhost_20729_object73 is not correct!
> >
> > I never saw these with similar rpm builds on these platforms from 9=
=2E0.2
> sources.
> >
> > Also, if I go to an x86-64 system running Ubuntu trusty for which I=
 am
> > able to install prebuilt binary packages via
> >     ceph-deploy install --dev v9.0.3
> >
> > I do not see the errors there.
>=20
> Hrm.. haven't seen it on this end, but we're running/testing master a=
nd not
> 9.0.2 specifically.  If you can reproduce this on master, that'd be v=
ery helpful!
>=20
> There have been some recent changes to rados bench... Piotr, does thi=
s
> seem like it might be caused by your changes?

Yes. My PR #4690 (https://github.com/ceph/ceph/pull/4690) caused rados =
bench to be fast enough to sometimes run into race condition between li=
brados's AIO and objbencher processing. That was fixed in PR #5152 (htt=
ps://github.com/ceph/ceph/pull/5152) which didn't make it into 9.0.3.
Tom, you can confirm this by inspecting the contents of objects questio=
ned (their contents should be perfectly fine and I in line with other o=
bjects).
In the meantime you can either apply patch from PR #5152 on your own or=
 use --no-verify.

With best regards / Pozdrawiam
Piotr Da=B3ek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
