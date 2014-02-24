From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-standalone
Date: Mon, 24 Feb 2014 22:26:56 +0100
Message-ID: <530BB920.1040605@dachary.org>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net> <22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="ArjU8X9PcqFX3PtEAn13wLptwHkcXJAos"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:52757 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbaBXV06 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 16:26:58 -0500
In-Reply-To: <22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jean-Charles LOPEZ <jc.lopez@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ArjU8X9PcqFX3PtEAn13wLptwHkcXJAos
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 24/02/2014 21:59, Jean-Charles LOPEZ wrote:
> Hi Sage,
>=20
> I think this is a great idea.
>=20
> However, I would recommend that two options to be available:
> 1) First options is a standalone package as you describe it
> 2) Second option is a prepackaged VM in OVA format people can just down=
load and import using VirtualBox, Fusion or VMWarePlayer.
>=20
Hi Jean-Charles,

I like the idea of a ready-to-run VM. The "raw" format (i.e. a file which=
 is a disk with partitions and bootloader) is universal and all hyperviso=
r/cloud infrastructures are able to load it natively.

My 2cts ;-)

> I can take care of the second option and prepare an OVA for you using t=
he base I already have.
>=20
> JC
> jc.lopez@inktank.com
>=20
>=20
> On Feb 23, 2014, at 12:30, Sage Weil <sage@inktank.com> wrote:
>=20
>> One idea kicking around is to create a simple ceph-standalone package =
that=20
>> is meant to make it really easy to play around with Ceph.  It would:
>>
>> - depend on all the relevant ceph packages
>> - install a simple, generic ceph.conf for use on localhost (or perhaps=
=20
>> whatever /etc/hosts has for our hostname)
>> - mkfs and start up a mon
>> - start up an osd (or two?) in /var/lib/ceph (no dedicated disk/volume=
)
>> - start an mds
>> - add an apache2 site in /etc/apache2/sites-available (or whatever)
>>
>> The idea would be to do
>>
>> $ sudo apt-get install ceph-standalone
>> $ ceph -s
>> [...]
>>
>> and have a usable mini-cluster.  That makes it really easy for users t=
o=20
>> play with the basics, like:
>>
>> $ mkdir /mnt/ceph
>> $ sudo ceph-fuse /mnt/ceph
>>
>> $ rbd create ...
>> $ rbd map ...
>>
>> $ curl http://localhost:8000/
>> <more rgw stuff>
>>
>> Does this sound useful?  Any takers?
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--ArjU8X9PcqFX3PtEAn13wLptwHkcXJAos
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMLuSAACgkQ8dLMyEl6F20YjwCeL0RNbZjnDqWvJuqOXbWHClTg
Pr0AoJ5G3uXUy3f2jvyy5yMkC0k8qEOu
=95vm
-----END PGP SIGNATURE-----

--ArjU8X9PcqFX3PtEAn13wLptwHkcXJAos--
