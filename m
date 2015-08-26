From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: rados bench object not correct errors on v9.0.3
Date: Wed, 26 Aug 2015 18:21:06 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB53701B6B@ABGEX73E.FSC.NET>
References: <BC97738F8E7C8742BABED7F06FB9DF91924D7E0E@SATLEXDAG01.amd.com>
 <alpine.DEB.2.00.1508251041260.13116@cobra.newdream.net>
 <90559C83A9C7FA45B5846C975DFA612DDB537017C2@ABGEX73E.FSC.NET>
 <BC97738F8E7C8742BABED7F06FB9DF91924D8376@SATLEXDAG01.amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate20.ts.fujitsu.com ([80.70.172.51]:21327 "EHLO
	dgate20.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752563AbbHZQVK convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Aug 2015 12:21:10 -0400
In-Reply-To: <BC97738F8E7C8742BABED7F06FB9DF91924D8376@SATLEXDAG01.amd.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Deneau, Tom" <tom.deneau@amd.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

> -----Original Message-----
> From: Deneau, Tom [mailto:tom.deneau@amd.com]
> Sent: Wednesday, August 26, 2015 5:23 PM
> To: Da=B3ek, Piotr; Sage Weil

> > > There have been some recent changes to rados bench... Piotr, does
> > > this seem like it might be caused by your changes?
> >
> > Yes. My PR #4690 (https://github.com/ceph/ceph/pull/4690) caused ra=
dos
> > bench to be fast enough to sometimes run into race condition betwee=
n
> > librados's AIO and objbencher processing. That was fixed in PR #515=
2
> > (https://github.com/ceph/ceph/pull/5152) which didn't make it into =
9.0.3.
> > Tom, you can confirm this by inspecting the contents of objects
> > questioned (their contents should be perfectly fine and I in line w=
ith other
> objects).
> > In the meantime you can either apply patch from PR #5152 on your ow=
n
> > or use - -no-verify.
>=20
> Piotr --
>=20
> Thank you.  Yes, when I looked at the contents of the objects they al=
ways
> looked correct.  And yes a single object would sometimes report an er=
ror and
> sometimes not.  So a race condition makes sense.
>=20
> A couple of questions:
>=20
>    * Why would I not see this behavior using the pre-built 9.0.3 bina=
ries
>      that get installed using "ceph-deploy install --dev v9.0.3"?  I =
would assume
>      this is built from the same sources as the 9.0.3 tarball.

No idea actually. It's a race condition, so it might be just luck.

>    * So I assume one should not compare pre 9.0.3 rados bench numbers=
 with
> 9.0.3 and after?
>      The pull request https://github.com/ceph/ceph/pull/4690 did not =
mention
> the
>      effect on final bandwidth numbers, did you notice what that effe=
ct was?

That depends on the CPU performance, but you should expect differences =
of a few or tens of MB/s on smaller blocks to up to even hundreds of MB=
 per second on larger block sizes. More concurrent jobs also make issue=
 more visible and add to total difference.

With best regards / Pozdrawiam
Piotr Da=B3ek
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
