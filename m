From: Loic Dachary <loic@dachary.org>
Subject: Re: Firefly v0.80.10 backports (rgw)
Date: Mon, 16 Mar 2015 23:11:05 +0100
Message-ID: <550754F9.3020207@dachary.org>
References: <55074AE9.8080008@dachary.org> <788437467.22080577.1426542474307.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="NbfUuoN3xRfcnCIwixlneLraBWjH6o7lk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59115 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752090AbbCPWLH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Mar 2015 18:11:07 -0400
In-Reply-To: <788437467.22080577.1426542474307.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NbfUuoN3xRfcnCIwixlneLraBWjH6o7lk
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

On 16/03/2015 22:47, Yehuda Sadeh-Weinraub wrote:
>=20
>=20
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yehuda Sadeh" <yehuda@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Monday, March 16, 2015 2:28:09 PM
>> Subject: Firefly v0.80.10 backports (rgw)
>>
>> Hi Yehuda,
>>
>> A few issues related to rgw were backported to firefly[1]. They passed=
 the
>> rgw suite[2]. Could you please take a look ?
>>
>> Cheers
>>
>> [1]
>> https://github.com/ceph/ceph/pulls?q=3Dis%3Aopen+is%3Apr+milestone%3Af=
irefly+sort%3Aupdated-desc+label%3Argw
>> [2] http://tracker.ceph.com/issues/11090#rgw
>>
>>
>=20
> It all looks fine. There are a couple of fixes that went in that are mo=
re features than bug fixes.=20

Thanks for the quick reply. I guess we should be more careful about where=
 the "firefly" word shows in the tracker to reduce the scope to what's ab=
solutely necessary. I'll keep that in mind, thanks for mentioning it.=20

> They're pretty limited in scope, but the changes are bigger than the us=
ual trivial changes that go into firefly.
> There's also another issue that I think we'll need to see going in: 111=
25. I just sent a pull request for master on it today, and it applies cle=
anly to firefly.

Ok. Note that this pass is merely to address the firefly backport backlog=
=2E It's not release time yet, 11125 will be included ;-)

Cheers

> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--NbfUuoN3xRfcnCIwixlneLraBWjH6o7lk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUHVPkACgkQ8dLMyEl6F22O+QCgpL46w9Hd2OJBoPGbJIsXbzJu
xrYAniMI5nBEsyQQkhrfSTQNtwC2xseC
=M4Dl
-----END PGP SIGNATURE-----

--NbfUuoN3xRfcnCIwixlneLraBWjH6o7lk--
