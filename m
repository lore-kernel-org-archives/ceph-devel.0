From: James Page <james.page@ubuntu.com>
Subject: Re: on disk encryption
Date: Tue, 22 Jan 2013 15:28:24 -0600
Message-ID: <50FF0478.7020702@ubuntu.com>
References: <alpine.DEB.2.00.1209150428490.16190@cobra.newdream.net> <CANT6BaObaeTF9giuTi-f=2gjW4BUVHyZxRSvETNhunqAta=6FA@mail.gmail.com> <50C5A894.8020507@ubuntu.com> <6EACA8977B8949FE9A17B74B37772B4A@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:36994 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab3AVV23 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:28:29 -0500
In-Reply-To: <6EACA8977B8949FE9A17B74B37772B4A@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Peter Reiher <reiher@inktank.com>, Dustin Kirkland <dustin.kirkland@gazzang.com>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 10/12/12 09:53, Gregory Farnum wrote:
[...]
>>>>> I love the idea of btrfs supporting encryption natively
>>>>> much like it does compression. It may be some time before
>>>>> that happens, so in the meantime, I'd love to see Ceph
>>>>> support dm-crypt and/or eCryptfs beneath.
>>>=20
>>>=20
>>>=20
>>> Has this discussion progressed into any sort of implementation
>>> yet? It sounds like this is going to be a key feature for users
>>> who want top-to-bottom encryption of data right down to the
>>> block level.
>=20
> Peter is working on this now =E2=80=94 I'll let him discuss the detai=
ls.
> :)

Hey Peter - any update on the on-disk encryption work for Ceph?

Cheers

James

- --=20
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQ/wR4AAoJEL/srsug59jD4jAQAIByoFQ3rrbon/BsxqD+KUMZ
xlGbviVxGIiHtLyUIwaXPerrEqnpuQCKbg/ZBXH0F9NUCRw3SZN74YuOjNz8c0Tr
aAy1Wkx+lFCwt2FtiwC3pXx5++GO2qTbK7jsOeqJazxUN1J8EmoUv73jq3u+MmMo
NV5k4e04g7leap3o5f13ONyJmTZC48XDZWdpa2HoYO7h1Er04y2tqOVTHwAd4PS5
26NaT2Cz4c+GMnDoTu608WrUJPv+pbi/WWf3RotRqXC3YX9VIDu6UxEc/tZHA+VP
PcbfgtKGhzj7ooxdHsanhPtUtHv9o9Q2DZFbzvATDC0s3K5Rpav8C1vnC2ODq6fr
LXCiRmVcjXz8e9TIQvSeQZLpK7Sy+WN4PTFdGsQqiVtw+iakw9qSn3EermAsCNIj
EEeHlt6GcWgFF4oVxeZ5EDJHUobz/vyl+R0ZjJgNK3aYv0zDw4w249ARpvjmoIPS
=46HYrukgSIHxv1CFSh4AxA4mgRseGM4B7H69+jdzp+3LNaCnHQBnT5cfsVrpoqCam
te5tytclC4gQ3xJh5L2lMH8D/ikSSZZjO+7cJ4ZEW5ebu7ChuonWMj0TQc2gPpUG
qqI0aV4QxRYaE5oRJlxoSlylKd6tWvHc/44TDqUPFWVnqLB1c8WEEZnDviTz5BCC
NYqJJb+2p+pzt2bK0p4r
=3D+Uvt
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
