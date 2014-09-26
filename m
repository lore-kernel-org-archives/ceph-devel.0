From: Loic Dachary <loic@dachary.org>
Subject: Re: Weekly performance meeting
Date: Fri, 26 Sep 2014 10:56:16 +0200
Message-ID: <54252A30.8020800@dachary.org>
References: <alpine.DEB.2.00.1409250856010.12347@cobra.newdream.net> <542514DE.6070807@dachary.org> <51FC7A40FB29414D88A121A7FFEF9A4710F71A35@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="cu4W6k9SHoGoLOEcI2MprBxW6wdN2gqla"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60480 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753728AbaIZI4W (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 26 Sep 2014 04:56:22 -0400
In-Reply-To: <51FC7A40FB29414D88A121A7FFEF9A4710F71A35@SHSMSX104.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Zhang, Jian" <jian.zhang@intel.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cu4W6k9SHoGoLOEcI2MprBxW6wdN2gqla
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

I added

  - isa : performances improvement expected ~20% [jian.zhang]

to http://pad.ceph.com/p/performance_weekly . Do you have more informatio=
n about this degradation ?

Cheers

On 26/09/2014 10:37, Zhang, Jian wrote:
> Loic,=20
> Sorry for the confusion. We have observed up to ~20% EC performance deg=
radation and have some initial findings and want to have a discussion. =20
>=20
> Thanks
> Jian
>=20
>=20
> -----Original Message-----
> From: Loic Dachary [mailto:loic@dachary.org]=20
> Sent: Friday, September 26, 2014 3:25 PM
> To: ceph-devel@vger.kernel.org; Zhang, Jian
> Subject: Re: Weekly performance meeting
>=20
> Hi,
>=20
> I added a section to http://pad.ceph.com/p/performance_weekly about the=
 current efforts to optimize/benchmark erasure code plugins. @Zhang, Jian=
 : the ISA erasure code plugin Andreas Peters worked on is not mentioned =
because it does not need any optimization, as far as I can tell ;-)=20
>=20
> Cheers
>=20
> On 25/09/2014 20:27, Sage Weil wrote:
>> Hi everyone,
>>
>> A number of people have approached me about how to get more involved=20
>> with the current work on improving performance and how to better=20
>> coordinate with other interested parties.  A few meetings have taken=20
>> place offline with good results but only a few interested parties were=
 involved.
>>
>> Ideally, we'd like to move as much of this dicussion into the public
>> forums: ceph-devel@vger.kernel.org and #ceph-devel.  That isn't always=
=20
>> sufficient, however.  I'd like to also set up a regular weekly meeting=
=20
>> using google hangouts or bluejeans so that all interested parties can =

>> share progress.  There are a lot of things we can do during the Hammer=
=20
>> cycle to improve things but it will require some coordination of effor=
t.
>>
>> Among other things, we can discuss:
>>
>>  - observed performance limitations
>>  - high level strategies for addressing them
>>  - proposed patch sets and their performance impact
>>  - anything else that will move us forward
>>
>> One challenge is timezones: there are developers in the US, China,=20
>> Europe, and Israel who may want to join.  As a starting point, how=20
>> about next Wednesday, 15:00 UTC?  If I didn't do my tz math wrong,=20
>> that's
>>
>>   8:00 (PDT, California)
>>  15:00 (UTC)
>>  18:00 (IDT, Israel)
>>  23:00 (CST, China)
>>
>> That is surely not the ideal time for everyone but it can hopefully be=
=20
>> a starting point.
>>
>> I've also created an etherpad for collecting discussion/agenda items=20
>> at
>>
>> 	http://pad.ceph.com/p/performance_weekly
>>
>> Is there interest here?  Please let everyone know if you are actively =

>> working in this area and/or would like to join, and update the pad=20
>> above with the topics you would like to discuss.
>>
>> Thanks!
>> sage
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =

>> in the body of a message to majordomo@vger.kernel.org More majordomo=20
>> info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--cu4W6k9SHoGoLOEcI2MprBxW6wdN2gqla
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQlKjAACgkQ8dLMyEl6F2316QCffQT2oN4q2GQWQTb+foDpN4WI
8OwAoMJxx4KZ1E+6Ui5ZBLrLWayLhZ61
=/Dg9
-----END PGP SIGNATURE-----

--cu4W6k9SHoGoLOEcI2MprBxW6wdN2gqla--
