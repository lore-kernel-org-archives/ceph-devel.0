From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: ceph-standalone
Date: Mon, 24 Feb 2014 22:35:48 +0100
Message-ID: <F33D6641-B3D1-4F25-9B7C-2269F2906908@enovance.com>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net> <22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/signed; boundary="Apple-Mail=_F8518537-41AE-42E6-BEC0-99EFAC9839F4"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:4888 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603AbaBXVfx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Feb 2014 16:35:53 -0500
In-Reply-To: <22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jean-Charles LOPEZ <jc.lopez@inktank.com>
Cc: Weil Sage <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--Apple-Mail=_F8518537-41AE-42E6-BEC0-99EFAC9839F4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

FYI I already have a vagrant box ready.

http://www.sebastien-han.fr/blog/2013/04/22/play-with-ceph-vagrant-box/

The box just needs to be updated with the last version.

Cheers.
=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 10, rue de la Victoire - 75009 Paris=20
Web : www.enovance.com - Twitter : @enovance=20

On 24 Feb 2014, at 21:59, Jean-Charles LOPEZ <jc.lopez@inktank.com> =
wrote:

> Hi Sage,
>=20
> I think this is a great idea.
>=20
> However, I would recommend that two options to be available:
> 1) First options is a standalone package as you describe it
> 2) Second option is a prepackaged VM in OVA format people can just =
download and import using VirtualBox, Fusion or VMWarePlayer.
>=20
> I can take care of the second option and prepare an OVA for you using =
the base I already have.
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
>>=20
>> - depend on all the relevant ceph packages
>> - install a simple, generic ceph.conf for use on localhost (or =
perhaps=20
>> whatever /etc/hosts has for our hostname)
>> - mkfs and start up a mon
>> - start up an osd (or two?) in /var/lib/ceph (no dedicated =
disk/volume)
>> - start an mds
>> - add an apache2 site in /etc/apache2/sites-available (or whatever)
>>=20
>> The idea would be to do
>>=20
>> $ sudo apt-get install ceph-standalone
>> $ ceph -s
>> [...]
>>=20
>> and have a usable mini-cluster.  That makes it really easy for users =
to=20
>> play with the basics, like:
>>=20
>> $ mkdir /mnt/ceph
>> $ sudo ceph-fuse /mnt/ceph
>>=20
>> $ rbd create ...
>> $ rbd map ...
>>=20
>> $ curl http://localhost:8000/
>> <more rgw stuff>
>>=20
>> Does this sound useful?  Any takers?
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--Apple-Mail=_F8518537-41AE-42E6-BEC0-99EFAC9839F4
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTC7s0AAoJECPrkYfpbtGTJjIH/iFQgOF54MqjSII2KcsRILz/
dXI55i7tGLafRgPzmJzF3SP6+iv3mh8Q3EddfarKUoVaWdkOuRxrX/8aAH3CXEXi
UxaTvE2GRZ3yadqWoRTpI3OnheNLcWxIxtolsnR9bqbvnOwMMK5eg42SX4QZt+Fm
tVOvltfH4FVzDUjQCWwcnqiBr6DF7DY95hbr3pWjYl+wko/M/lKWrz5eSBZfGTyc
a6wQNdaq2g5w8j3AjQI29inme88HWIt2dIFwSOdORHNl6vk8i7zYwJPD69X8e4ft
+/aoC1VcR4Cxm5eWftlK/Y/RGVtnwF+21fY+f8foq0fP3Dxo9atffAQzNsiTo1I=
=2sDg
-----END PGP SIGNATURE-----

--Apple-Mail=_F8518537-41AE-42E6-BEC0-99EFAC9839F4--
