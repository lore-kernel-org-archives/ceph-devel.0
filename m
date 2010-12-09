From: Eric Blake <eblake@redhat.com>
Subject: Re: [libvirt] [PATCH v2] add network disk support
Date: Thu, 09 Dec 2010 12:13:49 -0700
Message-ID: <4D012A6D.3080602@redhat.com>
References: <20101202131928.GV2502@redhat.com>	<1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp> <20101209110925.GA5313@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enigB092871972F681C2B82E800A"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:25046 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755215Ab0LITOQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Dec 2010 14:14:16 -0500
In-Reply-To: <20101209110925.GA5313@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>, libvir-list@redhat.com, ceph-devel@vger.kernel.org, sheepdog@lists.wpkg.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB092871972F681C2B82E800A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/09/2010 04:09 AM, Daniel P. Berrange wrote:
> On Mon, Dec 06, 2010 at 04:24:09PM +0900, MORITA Kazutaka wrote:
>> This patch adds network disk support to libvirt/QEMU.  The currently
>> supported protocols are nbd, rbd, and sheepdog.  The XML syntax is lik=
e
>> this:
>>
>>     <disk type=3D"network" device=3D"disk">
>>       <driver name=3D"qemu" type=3D"raw" />
>>       <source protocol=3D'rbd|sheepdog|nbd' name=3D"...some image iden=
tifier...">
>>         <host name=3D"mon1.example.org" port=3D"6000">
>>         <host name=3D"mon2.example.org" port=3D"6000">
>>         <host name=3D"mon3.example.org" port=3D"6000">
>>       </source>
>>       <target dev=3D"vda" bus=3D"virtio" />
>>     </disk>
>>
>>  docs/schemas/domain.rng |   31 +++++++

Hmm; missing a corresponding update to docs/formatdomain.html.in to
document the new XML.

> ACK

NACK.  After applying this patch, I get 'make check' failures:

TEST: vmx2xmltest
      /bin/sh: line 5: 15285 Segmentation fault      (core dumped)
abs_top_builddir=3D`cd '..'; pwd` abs_top_srcdir=3D`cd '..'; pwd`
abs_builddir=3D`cd '.'; pwd` abs_srcdir=3D`cd '.'; pwd` CONFIG_HEADER=3D"=
`cd
'..'; pwd`/config.h"
PATH=3D"$abs_top_builddir/src:$abs_top_builddir/daemon:$abs_top_builddir/=
tools:$PATH"
SHELL=3D"/bin/sh"
LIBVIRT_DRIVER_DIR=3D"/home/remote/eblake/libvirt/src/.libs" LC_ALL=3DC
${dir}$tst
FAIL: vmx2xmltest
TEST: xml2vmxtest
      ...!!!!!!!!!!...............!!!!!!!!!..  39  FAIL

I haven't looked into root cause.  Kazutaka, would you mind preparing a v=
3?

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigB092871972F681C2B82E800A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNASptAAoJEKeha0olJ0Nq04AH/0PU0z5eEsQf0+7b0vz9ZLRh
igJBzpfbG6qeNX4WOpmLsgjeYvyo6qBDvHCXbIGlsXFgRznD5Z7+Js3iK3N7nmO1
9FbrviPS/nGhZdnhMwL+91/3oF4jAI5L5HUgExvUCPRlb1UfAzqlYPb6/RfXj5A/
uQKje7PnYdnMiufWA/NpFmiqeBUfcjJv5sNPjW034k00/Za0pl8qXQdhQx7TwgjO
HSfsx3q5sZGk1ygRhtNx08xoNUdD9wu2QjGkSsGypGe0Nk0oQof3GH+N6sbOlZ3g
sZ79etglgX8lfeDEKR5JOctwEXi+CGJ0qh0CZvwfoKU2baVtj3GhPRBHZZ5/HwI=
=+WE1
-----END PGP SIGNATURE-----

--------------enigB092871972F681C2B82E800A--
