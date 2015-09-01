From: Loic Dachary <loic@dachary.org>
Subject: Re: devicemapper and udev events
Date: Tue, 01 Sep 2015 13:02:51 +0200
Message-ID: <55E585DB.3020404@dachary.org>
References: <55E4D0A2.6040302@dachary.org> <CAOi1vP_ME6TyKtTS9PQbfJmwUu4LP4Vh7rAqbHTLY-QGcAv9UQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="8gQ6xqecGbnBhocEQs3qki3e7KJcNMoN9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:47436 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753095AbbIALCy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 1 Sep 2015 07:02:54 -0400
In-Reply-To: <CAOi1vP_ME6TyKtTS9PQbfJmwUu4LP4Vh7rAqbHTLY-QGcAv9UQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8gQ6xqecGbnBhocEQs3qki3e7KJcNMoN9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 01/09/2015 09:44, Ilya Dryomov wrote:
> On Tue, Sep 1, 2015 at 1:09 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Ilya,
>>
>> While working on multipath, I noticed that udev add event are not trig=
gered when /dev/dm-0 etc. are created. Should I expect a udev add event f=
or every device ? Or does it not apply to devices created by / with devic=
emapper ?
>=20
> I'd expect an event - are you sure it's not triggered?  Are you using
> udevadm monitor or is it just some udev rule not getting executed?

It's just that udev rules are not getting executed. Thanks for sorting ou=
t my confusion :-)

A++

>=20
> Thanks,
>=20
>                 Ilya
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--8gQ6xqecGbnBhocEQs3qki3e7KJcNMoN9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXlhdsACgkQ8dLMyEl6F21UowCfXkWZ2QIczdNOnne1ZApk2mfw
TkAAnihkOy4eUjeQhIJLf6CipGRvg7Fw
=7RFz
-----END PGP SIGNATURE-----

--8gQ6xqecGbnBhocEQs3qki3e7KJcNMoN9--
