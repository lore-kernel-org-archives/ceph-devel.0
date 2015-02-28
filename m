From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next firefly release
Date: Sat, 28 Feb 2015 18:16:38 +0100
Message-ID: <54F1F7F6.3000409@dachary.org>
References: <54F19BF7.6030808@dachary.org> <1610756257.12816609.1425142542413.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Vf0jP3Q2KNb4l4WfKnIgaXBsUPgUgRQiN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50635 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751105AbbB1RQl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 28 Feb 2015 12:16:41 -0500
In-Reply-To: <1610756257.12816609.1425142542413.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Vf0jP3Q2KNb4l4WfKnIgaXBsUPgUgRQiN
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

Thanks for the quick feedback, much appreciated :-) Let me know as soon a=
s these fixes are committed to master. If you think the cherry-pick is st=
raightforward, I'll take care of it.

Cheers

On 28/02/2015 17:55, Yehuda Sadeh-Weinraub wrote:
>=20
>=20
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yehuda Sadeh" <yehuda@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Saturday, February 28, 2015 2:44:07 AM
>> Subject: rgw and the next firefly release
>>
>> Hi Yehuda,
>>
>> The rados teuthology suite for the next firefly release as found in
>> https://github.com/ceph/ceph/commits/firefly-backports came back green=

>> http://pulpito.ceph.com/loic-2015-02-27_18:04:18-rgw-firefly-backports=
---basic-multi/.
>> Do you think it is ready for QE to start their own round of testing ?
>>
>> Cheers
>=20
> I think the following issues need to get in:
>  - 10978 (fix still hasn't made it upstream, current commit: b6e43e30b3=
9aed701bb4cdfaa0f6b27c1f207d86)
>  - 10965 (fix still hasn't made it upstream, current commits: f28fe7442=
85117a1715eac0d08911cdb37285103, caa90225bad9fe5e9c275e6189b3396b4d396e3f=
)
>  - 10907 (commit: 986d7554426764a149621ba733c5c075b94e0431)
>=20
>=20
> I prepared the top two branches, need to do a sanity check on them firs=
t, then I'll send a pull request to master. I think 10978 is critical, th=
e bottom two are important for civetweb and less risky.
>=20
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Vf0jP3Q2KNb4l4WfKnIgaXBsUPgUgRQiN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlTx9/YACgkQ8dLMyEl6F20uNgCgwTqD0d8q63ClMWykoNdskWB8
hX0AoLshhzEqS/yoYN3LCKMWc7TAa6a4
=ribt
-----END PGP SIGNATURE-----

--Vf0jP3Q2KNb4l4WfKnIgaXBsUPgUgRQiN--
