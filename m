From: Sage Weil <sage@inktank.com>
Subject: Re: [ceph-users] how to use the function ceph_open_layout
Date: Fri, 3 Jan 2014 08:41:35 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1401030841020.3197@cobra.newdream.net>
References: <28fa4e4e.af9f.14356a4e251.Coremail.wkp4666@126.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2128151733-1388767295=:3197"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40939 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750889AbaACQlf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Jan 2014 11:41:35 -0500
In-Reply-To: <28fa4e4e.af9f.14356a4e251.Coremail.wkp4666@126.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?xfQ=?= <wkp4666@126.com>
Cc: "ceph-users@ceph.com" <ceph-users@ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2128151733-1388767295=:3197
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

On Fri, 3 Jan 2014, ? wrote:
> =A0Hi all;
> today,=A0 I want to use the fuction of ceph_open_layout() in libcephFs.=
h
>=20
> I creat a new pool=A0 success,
> # rados mkpool data1

You also need to do

ceph mds add_data_pool data1

sage

> and then I=A0 edit the code like this:
>=20
> int fd =3D ceph_open_layout( cmount, c_path, O_RDONLY|O_CREAT, 0666. (1=
<<22),
> 1, (1<<22) , "data1")
>=20
> and then the fd is -22!!!!!!!!!
>=20
> when I use the data pool , it can success
> int fd =3D ceph_open_layout( cmount, c_path, O_RDONLY|O_CREAT, 0666. (1=
<<22),
> 1, (1<<22) , "data")
>=20
> the ceph_open_layout support read/write to a new pool???
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 thinks you for the help!
> yous !
>=20
>=20
>=20
>=20
>=20
> =A0
> =A0
>=20
>=20
>=20
>=20
--557981400-2128151733-1388767295=:3197--
