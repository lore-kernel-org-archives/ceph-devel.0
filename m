From: Sage Weil <sage@newdream.net>
Subject: Re: Auto-striping feature
Date: Tue, 25 Jan 2011 21:20:16 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1101252119550.19989@cobra.newdream.net>
References: <1408EC05-75B0-4DD8-B6D6-7F5D10AAC096@gmail.com>
 <AANLkTinw9OZprRD8XoK9rjBm5Q_5aez8n-ZK75+hihYo@mail.gmail.com>
 <Pine.LNX.4.64.1101252031290.19989@cobra.newdream.net>
 <AANLkTiniHjvhwvd9q-iOvg_fpupr69hEs40OXX5efGNp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1997266385-1296019216=:19989"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47548 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750783Ab1AZFTu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Jan 2011 00:19:50 -0500
In-Reply-To: <AANLkTiniHjvhwvd9q-iOvg_fpupr69hEs40OXX5efGNp@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: tsuna <tsunanet@gmail.com>
Cc: Gregory Farnum <gregf@hq.newdream.net>, Tatsuya Kawano <tatsuya6502@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1997266385-1296019216=:19989
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 25 Jan 2011, tsuna wrote:
> On Tue, Jan 25, 2011 at 8:32 PM, Sage Weil <sage@newdream.net> wrote:
> > Actually, you just need to make sure that object_size is a multiple of
> > stripe_unit. =A0The striping strategy puts each stripe_unit on stripe_c=
ount
> > consecutive objects until they reach a size of stripe_count; it then mo=
ves
>=20
> Did you mean "until they reach a size of object_size"?

Yeah :)

sage

>=20
> > onto the next set of stripe_count objects. =A0The default degenerate ca=
se
> > has stripe_unit =3D=3D object_size and stripe_count =3D=3D 1.
>=20
> --=20
> Benoit "tsuna" Sigoure
> Software Engineer @ www.StumbleUpon.com
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-1997266385-1296019216=:19989--
