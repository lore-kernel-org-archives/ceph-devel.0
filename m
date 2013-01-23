From: Sage Weil <sage@inktank.com>
Subject: Re: on disk encryption
Date: Tue, 22 Jan 2013 16:02:57 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1301221601540.17154@cobra.newdream.net>
References: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net> <CANT6BaObaeTF9giuTi-f=2gjW4BUVHyZxRSvETNhunqAta=6FA@mail.gmail.com> <50C5A894.8020507@ubuntu.com> <6EACA8977B8949FE9A17B74B37772B4A@inktank.com> <50FF0478.7020702@ubuntu.com>
 <CAEgPQZDqUK+MJTX3Kbpdv3ai4=5rNCrGkxi=ioLt5OzC+zi4+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1511358775-1358899377=:17154"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40614 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3AWAC6 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 19:02:58 -0500
In-Reply-To: <CAEgPQZDqUK+MJTX3Kbpdv3ai4=5rNCrGkxi=ioLt5OzC+zi4+Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Asghar Riahi <asghar.riahi@seagate.com>
Cc: James Page <james.page@ubuntu.com>, Gregory Farnum <greg@inktank.com>, Peter Reiher <reiher@inktank.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, ceph-devel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1511358775-1358899377=:17154
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Jan 2013, Asghar Riahi wrote:
> Are you familiar with Seagate's Self Encrypting Disk (SED)?
>=20
> Here are some links which might be usefull:
>=20
> http://smb.media.seagate.com/tag/seagate-sed/
>=20
> http://csrc.nist.gov/groups/STM/cmvp/documents/140-1/140sp/140sp1299.pd=
f

Yeah!  It would be great to use this.

My understanding is that there isn't yet any support in Linux to manage=20
the keys.  That would be the first step before we can make the ceph=20
tooling configure the keys prior to mounting the osd volume(s)...

sage

>=20
> --
> Regards,
> Asghar Riahi
> Seagate Technology
> Principal Cloud Architect=A0
> asghar.riahi@seagate.com
> (925) 683-3104
>=20
>=20
>=20
> On Tue, Jan 22, 2013 at 1:28 PM, James Page <james.page@ubuntu.com> wro=
te:
>       -----BEGIN PGP SIGNED MESSAGE-----
>       Hash: SHA256
>=20
> On 10/12/12 09:53, Gregory Farnum wrote:
> [...]
> >>>>> I love the idea of btrfs supporting encryption natively
> >>>>> much like it does compression. It may be some time before
> >>>>> that happens, so in the meantime, I'd love to see Ceph
> >>>>> support dm-crypt and/or eCryptfs beneath.
> >>>
> >>>
> >>>
> >>> Has this discussion progressed into any sort of implementation
> >>> yet? It sounds like this is going to be a key feature for users
> >>> who want top-to-bottom encryption of data right down to the
> >>> block level.
> >
> > Peter is working on this now ? I'll let him discuss the details.
> > :)
>=20
> Hey Peter - any update on the on-disk encryption work for Ceph?
>=20
> Cheers
>=20
> James
>=20
> - --
> James Page
> Ubuntu Core Developer
> Debian Maintainer
> james.page@ubuntu.com
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
> Comment: Using GnuPG with undefined - http://www.enigmail.net/
>=20
> iQIcBAEBCAAGBQJQ/wR4AAoJEL/srsug59jD4jAQAIByoFQ3rrbon/BsxqD+KUMZ
> xlGbviVxGIiHtLyUIwaXPerrEqnpuQCKbg/ZBXH0F9NUCRw3SZN74YuOjNz8c0Tr
> aAy1Wkx+lFCwt2FtiwC3pXx5++GO2qTbK7jsOeqJazxUN1J8EmoUv73jq3u+MmMo
> NV5k4e04g7leap3o5f13ONyJmTZC48XDZWdpa2HoYO7h1Er04y2tqOVTHwAd4PS5
> 26NaT2Cz4c+GMnDoTu608WrUJPv+pbi/WWf3RotRqXC3YX9VIDu6UxEc/tZHA+VP
> PcbfgtKGhzj7ooxdHsanhPtUtHv9o9Q2DZFbzvATDC0s3K5Rpav8C1vnC2ODq6fr
> LXCiRmVcjXz8e9TIQvSeQZLpK7Sy+WN4PTFdGsQqiVtw+iakw9qSn3EermAsCNIj
> EEeHlt6GcWgFF4oVxeZ5EDJHUobz/vyl+R0ZjJgNK3aYv0zDw4w249ARpvjmoIPS
> FHYrukgSIHxv1CFSh4AxA4mgRseGM4B7H69+jdzp+3LNaCnHQBnT5cfsVrpoqCam
> te5tytclC4gQ3xJh5L2lMH8D/ikSSZZjO+7cJ4ZEW5ebu7ChuonWMj0TQc2gPpUG
> qqI0aV4QxRYaE5oRJlxoSlylKd6tWvHc/44TDqUPFWVnqLB1c8WEEZnDviTz5BCC
> NYqJJb+2p+pzt2bK0p4r
> =3D+Uvt
> -----END PGP SIGNATURE-----
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
>=20
>=20
>=20
>=20
--557981400-1511358775-1358899377=:17154--
