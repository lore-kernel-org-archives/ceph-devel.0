From: Loic Dachary <loic@dachary.org>
Subject: Re: ceph-standalone
Date: Tue, 25 Feb 2014 09:33:35 +0100
Message-ID: <530C555F.1030902@dachary.org>
References: <alpine.DEB.2.00.1402231225090.17508@cobra.newdream.net>	<22A49EE2-BD1A-43C2-BBAB-8DD18CBEA550@inktank.com>	<F33D6641-B3D1-4F25-9B7C-2269F2906908@enovance.com>	<187667BD-58E9-4E75-8A71-872C3EB88095@inktank.com>	<CAFMfnwqB6CTEtZibW_uww=k+jxFZxmsix-d5sxR115ZOGR+qpw@mail.gmail.com>	<CAGRK8cxE10daLT8EwWr-_s_NjaWj-D_COPKy3HvwVgO=4qWj9w@mail.gmail.com> <CA+xPSVC63jiZe5RY+Sq_HE4=vBCNR0Hn09ZXwz6_1GW3FBZsNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="d6WquxgsmiDTQejU9bKwlmmBsKfDAJw2K"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:53255 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181AbaBYIdi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 25 Feb 2014 03:33:38 -0500
In-Reply-To: <CA+xPSVC63jiZe5RY+Sq_HE4=vBCNR0Hn09ZXwz6_1GW3FBZsNQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ricardo Rocha <rocha.porto@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Robert Sander <r.sander@heinlein-support.de>, Stephan Seitz <s.seitz@heinlein-support.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d6WquxgsmiDTQejU9bKwlmmBsKfDAJw2K
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 25/02/2014 04:34, Ricardo Rocha wrote:
> I did it mostly to learn about docker (and because i wanted a 'cluster
> in the office' like Loic had :-)). Not incredibly pretty though.

:-) Robert and Stephan created this nice office cluster and it would be n=
ice to know how it evolved. My understanding is that it was an experiment=
 to learn about Ceph before doing something more ambitious.

Cheers

> Usually i go with vagrant to deploy ceph in a box (1 mon, 2 osds) in
> an lxc container, with file loopback mounts and using the puppet
> module to deploy/config (which has good vagrant integration, and
> mimics our production env). We use a similar setup for the openstack
> bits, and it's also the basis of our continuous integration.
>=20
> On Tue, Feb 25, 2014 at 3:11 PM, Hunter Nield <hunter@acale.ph> wrote:
>> The packer solution sounds sensible to me as it also would allow the
>> creation of Docker images.
>>
>> A basic Docker image has already been started
>> (https://index.docker.io/u/rochaporto/cephbox/) but it would be quite
>> useful to have a version that comes from an official maintained
>> source.
>>
>> On Tue, Feb 25, 2014 at 7:06 AM, Kyle Bader <kyle.bader@gmail.com> wro=
te:
>>>> so that's great. It's already almost done. Let us know when you have=
 managed updating it.
>>>>
>>>> I suppose it would be best if we could offer one image each of the l=
ast 3 Ceph versions (dumpling, emperor and firefly) so people can then pl=
ay with the expected level they are looking for in either test environmen=
t or production environment.
>>>>
>>>> Each of the images would be maintained up to date for the last stabl=
e code base of each version only to reduce time consuming.
>>>
>>> This is screaming for us to use packer [1], that way we can easily
>>> create vbox/kvm/ec2 images from a file that we can stash in git
>>>
>>> [1] http://www.packer.io/
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--d6WquxgsmiDTQejU9bKwlmmBsKfDAJw2K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlMMVWAACgkQ8dLMyEl6F20iMACfe3KHu1nx40ZyX8qtLPk9TU2e
E40AnipEYNv6kjum32v1SafvNUE2Tk3M
=eByX
-----END PGP SIGNATURE-----

--d6WquxgsmiDTQejU9bKwlmmBsKfDAJw2K--
