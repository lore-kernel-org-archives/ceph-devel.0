From: Sage Weil <sage@newdream.net>
Subject: Re: rbd and Metaserver
Date: Fri, 6 May 2011 09:03:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1105060902510.9905@cobra.newdream.net>
References: <4DC2DB6E.9010500@ufm.su> <2000619B57A3492DBDFCA82B0843792D@gmail.com>
 <BANLkTim-7Y5DKQ+O3o4_cUbvjZ9kYghAQA@mail.gmail.com>
 <Pine.LNX.4.64.1105052054060.14021@cobra.newdream.net>
 <BANLkTi=rZ6L_V0NqBe6Vi7JuJh6P2CZBkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-2062352993-1304697815=:9905"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58390 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753185Ab1EFQC6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 May 2011 12:02:58 -0400
In-Reply-To: <BANLkTi=rZ6L_V0NqBe6Vi7JuJh6P2CZBkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsk <aixt2006@gmail.com>
Cc: Gregory Farnum <gregory.farnum@dreamhost.com>, Fyodor Ustinov <ufm@ufm.su>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-2062352993-1304697815=:9905
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 6 May 2011, tsk wrote:
> Hi  Sage,
>=20
> If I use librados:
>=20
>     int create(const std::string& oid, bool exclusive);
>     int write(const std::string& oid, bufferlist& bl, size_t len, uint64_=
t off);
>     int read(const std::string& oid, bufferlist& bl, size_t len, uint64_t=
 off);
>=20
> MDS is not required to be running either?

Right.

> What does the oid mean,  is there any relation between oid and the
> object file name when it's dropped into an OSD server, like
> "current/0.c5_head/10000000004.000001ba_head"?
                     ^^^^^^^^^^^^^^^^^^^^
That part is the object name.  The _head bit is part of the snap revision=
=20
tracking.

sage

>=20
>=20
> Thx very much!
>=20
>=20
> 2011/5/6 Sage Weil <sage@newdream.net>:
> > On Fri, 6 May 2011, tsk wrote:
> >> 2011/5/6 Gregory Farnum <gregory.farnum@dreamhost.com>:
> >> > Nope, the MDS is only required for the POSIX-compliant Ceph layer.
> >> > -Greg
> >>
> >> May I know that who will maintain the rbd_image_info if there is no MD=
S?
> >> From where, the api int rbd_list(rados_ioctx_t io, char *names, size_t
> >> *size) =A0will get the data it want?
> >
> > The rbd image header is stored as just another object in the object sto=
re.
> >
> > sage
> >
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-2062352993-1304697815=:9905--
