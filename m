From: Loic Dachary <loic@dachary.org>
Subject: Re: provisioning teuthology targets with OpenStack
Date: Tue, 23 Jun 2015 20:46:12 -0400
Message-ID: <5589FDD4.3020301@dachary.org>
References: <557479B4.9060207@dachary.org> <837976248.11945956.1433867145523.JavaMail.zimbra@redhat.com> <55773738.1090701@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="18feMqh9osMa7gJWkO3w9sXDUqNmdLtCg"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39089 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754891AbbFXAqQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 20:46:16 -0400
In-Reply-To: <55773738.1090701@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Zack Cerza <zack@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--18feMqh9osMa7gJWkO3w9sXDUqNmdLtCg
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Zack,

I think it works and I'll start using it. For the record

https://github.com/ceph/teuthology/compare/master...dachary:wip-6502-open=
stack?expand=3D1#diff-88b99bb28683bd5b7e3a204826ead112R318

is what I have right now. There are a few things that need cleaning but n=
othing major I hope. I'll clean them up after you had time to review the =
preliminary pull requests at https://github.com/ceph/teuthology/pulls.

Cheers

On 09/06/2015 14:58, Loic Dachary wrote:
>=20
>=20
> On 09/06/2015 18:25, Zack Cerza wrote:
>> Hi Loic!
>>
>> I'm really happy to hear you have the time and motivation to work on t=
his! It's something I've wanted to get to for a while, but other things k=
eep getting in the way.
>>
>> I'd suggest looking at teuthology.provision.Downburst to investigate m=
aybe pulling some of its functionality into a base class that a potential=
 OpenStack subclass could also benefit from. I'd love to see us using a c=
ommon interface for all of our provisioning. If that seems like a lot of =
work, I'd be willing to be the one to create the base class and work with=
 you to make sure its API was useful for OpenStack as well.
>>
>=20
> Thanks for the pointers. I'll write something that works and get back t=
o you to make it acceptable :-)
>=20
>> Thanks,
>> Zack
>>
>> ----- Original Message -----
>>> From: "Loic Dachary" <loic@dachary.org>
>>> To: "Zack Cerza" <zcerza@redhat.com>
>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>>> Sent: Sunday, June 7, 2015 11:04:52 AM
>>> Subject: provisioning teuthology targets with OpenStack
>>>
>>> Hi Zack,
>>>
>>> I'm motivated by my recent experience with hacking teuthology and con=
tainers
>>> :-) I'd like to give
>>>
>>> http://tracker.ceph.com/issues/6502 "provision targets using a cloud =
API"
>>>
>>> a shot with OpenStack in mind (because I know nothing of EC2 really).=
 The
>>> idea is to make it relatively easy for someone with access to an Open=
Stack
>>> tenant to using instead of downburst. Not only would that simplify th=
e
>>> development process for people without access to the lab, it would al=
so
>>> allow the addition of more horsepower to the lab. What do you think ?=

>>>
>>> Cheers
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>
>>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--18feMqh9osMa7gJWkO3w9sXDUqNmdLtCg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWJ/dQACgkQ8dLMyEl6F23+jgCgvE5nBV/B8EmotEHi9uAZmhNe
/bsAnA26tjp6kni4F2sccWfzpvfYfxWg
=wzC8
-----END PGP SIGNATURE-----

--18feMqh9osMa7gJWkO3w9sXDUqNmdLtCg--
