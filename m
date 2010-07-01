From: Sage Weil <sage@newdream.net>
Subject: Re: pg 0.xxxx on [] is laggy
Date: Thu, 1 Jul 2010 16:58:35 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007011657260.5822@cobra.newdream.net>
References: <AANLkTimJpJeHVMvhLSyASwo3DjE9sd1njJ7PGG9yhPa1@mail.gmail.com>
 <Pine.LNX.4.64.1006290850420.12768@cobra.newdream.net>
 <AANLkTini3YGPjANBw-FgWDld2J1cpe2GXsimpMI-0y1Z@mail.gmail.com>
 <Pine.LNX.4.64.1006301104320.29167@cobra.newdream.net>
 <AANLkTikG7OsUyBtXXfO2tI-T2LzwVOlIb32UFtPFs41z@mail.gmail.com>
 <Pine.LNX.4.64.1006301424200.29167@cobra.newdream.net>
 <AANLkTikg5bx9nYZAz2qZJ6gjOm66EtI49VTieQBaFQ_K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-968823554-1278028715=:5822"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47574 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751811Ab0GAX5K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 1 Jul 2010 19:57:10 -0400
In-Reply-To: <AANLkTikg5bx9nYZAz2qZJ6gjOm66EtI49VTieQBaFQ_K@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?ISO-8859-1?Q?S=E9bastien_Paolacci?= <sebastien.paolacci@gmail.com>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-968823554-1278028715=:5822
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 2 Jul 2010, S=E9bastien Paolacci wrote:
> 2010/7/1 Sage Weil <sage@newdream.net>:
> > Can you do the same, but with
> >
> > =A0 =A0 =A0 =A0debug filestore =3D 20
> > =A0 =A0 =A0 =A0debug journal =3D 20
> > =A0 =A0 =A0 =A0debug osd =3D 20
> >
> > I'm not sure where that length 5120 write is coming from.
> >
> Neither do I ;)
>=20
> Sorry for not taking much more time to trace myself, here is however a
> more detailed log output:

I see the problem now. Your journal block size is 1KB and the page size is=
=20
4KB.  Fixing the journal code to align with the max of the two.

Thanks!
sage
--557981400-968823554-1278028715=:5822--
