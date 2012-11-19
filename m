From: Sage Weil <sage@inktank.com>
Subject: Re: deprecating mkcephfs (the arrival of light-weight deployment
 tools)
Date: Mon, 19 Nov 2012 14:54:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1211191443450.1082@cobra.newdream.net>
References: <CAJiejCTWvtn6yS+_9h07t4KWqRHPqT-Oe23KtXmnvf7ZZbsAAw@mail.gmail.com> <CAPYLRzikTGx=c+qJazxL=6amBj-GYT6fm9-noKmDGcABnAUUjw@mail.gmail.com> <1353363220.47659.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1182699872-1353365692=:1082"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36421 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752446Ab2KSWyx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Nov 2012 17:54:53 -0500
In-Reply-To: <1353363220.47659.YahooMailNeo@web121906.mail.ne1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Isaac Otsiabah <zmoo76b@yahoo.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1182699872-1353365692=:1082
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable

On Mon, 19 Nov 2012, Isaac Otsiabah wrote:
>=20
> I am trying to understand ceph deployment direction because from this l=
ink http://ceph.com/docs/master/rados/deployment/
> it
>  is mentioned that mkcephfs is dreprecated. It also has the statement=20
> below which mentions light-weight deployment scripts to help you=20
> evaluate Ceph.
>=20
>=20
> "We provide light-weight deployment scripts to help you evaluate Ceph. =
For
> professional deployment, you should consider professional deployment sy=
stems
> such as Juju, Puppet, Chef or Crowbar."
>=20
> I=A0 think there is a need to have native ceph deployment tools that ar=
en't dependent upon any third party deployment tools. So my question is t=
his
> =A0=A0=A0=20
> =A0=A0=A0 1. when will the light-weight deployment scripts be=20
> available and which ceph version will they be released into?

http://github.com/ceph/ceph-deploy is available for initial testing, but=20
far from ready for widespread use.  mkcephfs is still the preferred=20
installation path.

I'll make sure the 'deprecated' notation is removed until a real=20
alternative is ready.

> =A0=A0=A0 2. Now, going forward, when will mkcephfs not work anymore (w=
hat=20
> ceph version)?

It will be maintained at least through cuttlefish (the next stable=20
release), though probably longer, so that there is plenty of overlap with=
=20
whatever tool will follow.

sage
--557981400-1182699872-1353365692=:1082--
