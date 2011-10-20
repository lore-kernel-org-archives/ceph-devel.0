From: Sage Weil <sage@newdream.net>
Subject: Re: Inode numbers on 32 Bit Linux
Date: Thu, 20 Oct 2011 13:01:32 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1110201301240.13450@cobra.newdream.net>
References: <201110200828.26887.a.ott@m-privacy.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-437261150-1319140892=:13450"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43682 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1JTUBd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Oct 2011 16:01:33 -0400
In-Reply-To: <201110200828.26887.a.ott@m-privacy.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Amon Ott <a.ott@m-privacy.de>
Cc: ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-437261150-1319140892=:13450
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

Queueing this for 3.2-rc1, thanks!

sage


On Thu, 20 Oct 2011, Amon Ott wrote:

> Hi all,
>=20
> we need to run 32 Bit Linux kernels, but file identification of our RSBAC=
=20
> access control system relies on unique inode numbers. Plain Ceph uses ino=
de=20
> number 1 for all filesystem objects, leading to id problems. To check=20
> yourself, make a "find" and see that it complains about file system loops=
=20
> because of this. ls -i shows number 1 for all items.
>=20
> I changed the inode number generation as follows to get unique numbers an=
d now=20
> everything works fine without collisions.
>=20
> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
> index 35dc965..bb73b49 100644
> --- a/fs/ceph/super.h
> +++ b/fs/ceph/super.h
> @@ -344,9 +344,10 @@ static inline struct ceph_vino ceph_vino(struct inod=
e=20
> *inode)
>   * x86_64+ino32  64                     32
>   * x86_64        64                     64
>   */
> -static inline u32 ceph_ino_to_ino32(ino_t ino)
> +static inline u32 ceph_ino_to_ino32(__u64 vino)
>  {
> -       ino ^=3D ino >> (sizeof(ino) * 8 - 32);
> +       u32 ino =3D vino & 0xffffffff;
> +       ino ^=3D vino >> 32;
>         if (!ino)
>                 ino =3D 1;
>         return ino;
> @@ -359,9 +360,10 @@ static inline ino_t ceph_vino_to_ino(struct ceph_vin=
o=20
> vino)
>  {
>         ino_t ino =3D (ino_t)vino.ino;  /* ^ (vino.snap << 20); */
>  #if BITS_PER_LONG =3D=3D 32
> -       ino =3D ceph_ino_to_ino32(ino);
> +       return ceph_ino_to_ino32(vino.ino);
> +#else
> +       return (ino_t)vino.ino;
>  #endif
> -       return ino;
>  }
>=20
>=20
>=20
> Amon Ott
> --=20
> Dr. Amon Ott
> m-privacy GmbH           Tel: +49 30 24342334
> Am K=F6llnischen Park 1    Fax: +49 30 24342336
> 10179 Berlin             http://www.m-privacy.de
>=20
> Amtsgericht Charlottenburg, HRB 84946
>=20
> Gesch=E4ftsf=FChrer:
>  Dipl.-Kfm. Holger Maczkowsky,
>  Roman Maczkowsky
>=20
> GnuPG-Key-ID: 0x2DD3A649
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
--557981400-437261150-1319140892=:13450--
