From: =?iso-8859-2?Q?Da=B3ek=2C_Piotr?= <Piotr.Dalek@ts.fujitsu.com>
Subject: RE: c++11 merged in master
Date: Sun, 9 Aug 2015 20:02:34 +0200
Message-ID: <90559C83A9C7FA45B5846C975DFA612DDB53475CC8@ABGEX73E.FSC.NET>
References: <alpine.DEB.2.00.1508071041040.22099@cobra.newdream.net>
 <alpine.DEB.2.00.1508091032040.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from dgate10.ts.fujitsu.com ([80.70.172.49]:15041 "EHLO
	dgate10.ts.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933123AbbHISCj convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 9 Aug 2015 14:02:39 -0400
In-Reply-To: <alpine.DEB.2.00.1508091032040.22099@cobra.newdream.net>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: "adeza@redhat.com" <adeza@redhat.com>

> -----Original Message-----
> From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-
> owner@vger.kernel.org] On Behalf Of Sage Weil
> Sent: Sunday, August 09, 2015 7:39 PM
>=20
> [..]
>
> Well, I spoke too soon.  The builds still aren't completing (the olde=
r boost's
> shared_ptr is buggy on c++11, and I'm not sure we can upgrade since s=
ome
> of it is dynamically linked).  Also, when you try to install packages=
 built with
> gcc 4.8 (regardless of the branch), you get
>=20
> 2015-08-08T11:28:45.471 INFO:teuthology.orchestra.run.plana89.stdout:
> ceph
> : Depends: libstdc++6 (>=3D 4.8.1) but 4.6.3-1ubuntu5 is to be instal=
led
> 2015-08-08T11:28:45.471 INFO:teuthology.orchestra.run.plana89.stdout:
> ceph-test : Depends: libstdc++6 (>=3D 4.8.1) but 4.6.3-1ubuntu5 is to=
 be
> installed
>=20
> ...which blows.  I think we'd either need to include the 4.8 runtime =
in our
> repos or require users to add the appropriate APT source.  :(
>=20
> At this point my vote is to drop precise and el6 entirely for inferna=
lis
> and later.  Someone can always go build themselves and hunt down the
> proper backports but it's not worth our time.
>=20
> The main downsides here are:
>=20
>  - There may be precise or el6 users who want infernalis or later.  G=
iven
> what we've seen so far I think there aren't many of these people and
> our time is better spent on other things.
>
> [..]
>=20
> Thoughts?
> sage

I'm pretty sure there will be a lot of users (and direct or indirect cu=
stomers) being forced to use el6, so they won't get Infernalis. I'm not=
 sure about the Red Hat's stance on this, and we probably need their op=
inion here. For us (Fujitsu) it'll be a huge issue, as we're relying on=
 CentOS 6 and moving to 7 *will* be a huge amount of work, not to menti=
on that we will have to support both CentOS 6 (for existing and near-fu=
ture customers) and CentOS 7 (for future customers once we make the swi=
tch). Probably inevitable, but still a huge pain.
My suggestion is that the current LTS release could have more of "L" in=
 the "LTS" than others, so companies like ours will have more time to s=
witch and still benefit from any fixes community (including us) provide=
=2E=20


With best regards / Pozdrawiam
Piotr Da=B3ek


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
