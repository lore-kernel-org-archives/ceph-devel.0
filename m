From: Loic Dachary <loic@dachary.org>
Subject: Re: rgw and the next firefly release
Date: Tue, 03 Mar 2015 15:57:32 +0100
Message-ID: <54F5CBDC.5000101@dachary.org>
References: <54F19BF7.6030808@dachary.org> <1610756257.12816609.1425142542413.JavaMail.zimbra@redhat.com> <1845838520.13663626.1425312514641.JavaMail.zimbra@redhat.com> <54F49366.9080203@dachary.org> <773298376.13717568.1425316887571.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Rw0sHkfHRBNETgIfUI5iGqbFxVraHrRPd"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:52113 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753829AbbCCO5f (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Mar 2015 09:57:35 -0500
In-Reply-To: <773298376.13717568.1425316887571.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rw0sHkfHRBNETgIfUI5iGqbFxVraHrRPd
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

The rgw suite came back green http://tracker.ceph.com/issues/10641#rgw wi=
th https://github.com/ceph/ceph/tree/firefly-backports which includes the=
 requested backports.

Do you think it is ready for QE to start their own round of testing ?

Cheers

On 02/03/2015 18:21, Yehuda Sadeh-Weinraub wrote:
>=20
>=20
> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Sent: Monday, March 2, 2015 8:44:22 AM
>> Subject: Re: rgw and the next firefly release
>>
>> Hi Yehuda,
>>
>> On 02/03/2015 17:08, Yehuda Sadeh-Weinraub wrote:
>>>
>>>
>>> ----- Original Message -----
>>>> From: "Yehuda Sadeh-Weinraub" <yehuda@redhat.com>
>>>> To: "Loic Dachary" <loic@dachary.org>
>>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>>>> Sent: Saturday, February 28, 2015 8:55:42 AM
>>>> Subject: Re: rgw and the next firefly release
>>>>
>>>>
>>>>
>>>> ----- Original Message -----
>>>>> From: "Loic Dachary" <loic@dachary.org>
>>>>> To: "Yehuda Sadeh" <yehuda@redhat.com>
>>>>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>
>>>>> Sent: Saturday, February 28, 2015 2:44:07 AM
>>>>> Subject: rgw and the next firefly release
>>>>>
>>>>> Hi Yehuda,
>>>>>
>>>>> The rados teuthology suite for the next firefly release as found in=

>>>>> https://github.com/ceph/ceph/commits/firefly-backports came back gr=
een
>>>>> http://pulpito.ceph.com/loic-2015-02-27_18:04:18-rgw-firefly-backpo=
rts---basic-multi/.
>>>>> Do you think it is ready for QE to start their own round of testing=
 ?
>>>>>
>>>>> Cheers
>>>>
>>>> I think the following issues need to get in:
>>>>  - 10978 (fix still hasn't made it upstream, current commit:
>>>>  b6e43e30b39aed701bb4cdfaa0f6b27c1f207d86)
>>> it's actually eb13f2d4b60c031f16139f7cc4237c012644dd78. Sent pull req=
uest
>>> #3843.
>>
>> Would you like me to cherry-pick this one to firefly and schedule a ru=
n of
>> rgw suite with it ?
>=20
> Yes. Also, the other ones need to be cherry-picked, all should be in ma=
ster already.
>=20
> Thanks,
> Yehuda
>=20
>>
>> https://github.com/ceph/ceph/pull/3843
>>
>> Cheers
>>>
>>>>  - 10965 (fix still hasn't made it upstream, current commits:
>>>>  f28fe744285117a1715eac0d08911cdb37285103,
>>>>  caa90225bad9fe5e9c275e6189b3396b4d396e3f)
>>>>  - 10907 (commit: 986d7554426764a149621ba733c5c075b94e0431)
>>>>
>>>>
>>>> I prepared the top two branches, need to do a sanity check on them f=
irst,
>>>> then I'll send a pull request to master. I think 10978 is critical, =
the
>>>> bottom two are important for civetweb and less risky.
>>>>
>>>> Yehuda
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--Rw0sHkfHRBNETgIfUI5iGqbFxVraHrRPd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlT1y9wACgkQ8dLMyEl6F22B6ACcCuP35tJ70HCNeqNEzOg5iJcD
1GUAn2e8UVKjvrZboSDvkYop7iST6l+M
=KskR
-----END PGP SIGNATURE-----

--Rw0sHkfHRBNETgIfUI5iGqbFxVraHrRPd--
