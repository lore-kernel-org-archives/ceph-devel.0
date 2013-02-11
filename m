From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: rest mgmt api
Date: Mon, 11 Feb 2013 16:38:42 -0600
Message-ID: <511972F2.7080304@bmrb.wisc.edu>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com> <5112AE17.6080605@inktank.com> <alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net> <5112B43D.6070602@bmrb.wisc.edu> <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net> <CAPYLRzh5JD3hvxB5VFrmEXq2g9JuEk-ODQquahPMwGMRiqSc6g@mail.gmail.com> <alpine.DEB.2.00.1302111345000.27987@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig745996B4CBE23C91510884E7"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:57628 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932757Ab3BKWin (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Feb 2013 17:38:43 -0500
In-Reply-To: <alpine.DEB.2.00.1302111345000.27987@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Gregory Farnum <greg@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig745996B4CBE23C91510884E7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/11/2013 04:00 PM, Sage Weil wrote:
> On Mon, 11 Feb 2013, Gregory Farnum wrote:
=2E..

> That doesn't really help; it means the mon still has to understand the =

> CLI grammar.
>=20
> What we are talking about is the difference between:
>=20
> [ 'osd', 'down', '123' ]
>=20
> and
>=20
> {
>   URI: '/osd/down',
>   OSD-Id: 123
> }
>=20
> or however we generically translate the HTTP request into JSON.

I think the setup we have in mind is where the MON reads something like
{"who:"osd", "which":"123", "what":"down", "when":"now"} from a socket
(pipe, whatever),

the CLI reads "osd down 123 now" from the prompt and pushes {"who:"osd",
"which":"123", "what":"down", "when":"now"} into that socket,

the webapp gets whatever: "/osd/down/123/now" or
?who=3Dosd&command=3Ddown&id=3D123&when=3Dnow" from whoever impersonates =
the
browser and pipes {"who:"osd", "which":"123", "what":"down",
"when":"now"} into that same socket,

and all three of them are three completely separate applications that
don't try to do what they don't need to.

> FWIW you could pass the CLI command as JSON, but that's no different th=
an=20
> encoding vector<string>; it's still a different way to describing the s=
ame=20
> command.

The devil is of course in the details: in (e.g.) python json.loads() the
string and gives you the map you could plug into a lookup table or
something to get right to the function call. My c++ is way rusty, I've
no idea what's available in boost &co -- if you have to roll your own
json parser then you indeed don't care how that vector<string> is encoded=
=2E

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enig745996B4CBE23C91510884E7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFRGXLyxzG8ttqkbbgRAnm3AJ40a2OI3VFdFZHsa+qvPsU0k7l8VgCdF4cv
N4vvTUgr++8L9pmsGA+ygbU=
=3UgO
-----END PGP SIGNATURE-----

--------------enig745996B4CBE23C91510884E7--
