From: Loic Dachary <loic@dachary.org>
Subject: Re: creation of the puppet-ceph repository
Date: Tue, 17 Dec 2013 00:32:37 +0100
Message-ID: <52AF8D95.5050704@dachary.org>
References: <52AC97E2.8080907@dachary.org> <CED3B77C.1F7CF%ian.colle@inktank.com> <52AF56D9.9040005@dachary.org> <CED4D2E9.1F9F3%ian.colle@inktank.com> <52AF89CC.8060007@dachary.org> <CED4D9B5.1FA0B%ian.colle@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="5bs5ls8IlWCk3kHED9GIpnfmgh5PaphIv"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:42158 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab3LPXcj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Dec 2013 18:32:39 -0500
In-Reply-To: <CED4D9B5.1FA0B%ian.colle@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ian Colle <ian.colle@inktank.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5bs5ls8IlWCk3kHED9GIpnfmgh5PaphIv
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Works https://github.com/ceph/puppet-ceph now is a mirror of https://gith=
ub.com/stackforge/puppet-ceph :-)

On 17/12/2013 00:24, Ian Colle wrote:
>=20
> On 12/16/13, 4:16 PM, "Loic Dachary" <loic@dachary.org> wrote:
>=20
>> Hi Ian,
>>
>> I failed to push with:
>>
>> ERROR: Permission to ceph/puppet-ceph.git denied to dachary.
>> fatal: Could not read from remote repository.
>>
>> I also checked if I had enough permissions to merge a pull request and=

>> apparently I don't. Would you be so kind as to grant me additional
>> permission on this specific repository ? If it looks like I already ha=
ve
>> permissions I will investigate more.
>=20
> Try again now.
>=20
>>
>> Really sorry this is being so complicated :-(
>>
>> On 16/12/2013 23:55, Ian Colle wrote:
>>>
>>>
>>> On 12/16/13, 12:39 PM, "Loic Dachary" <loic@dachary.org> wrote:
>>>
>>>> Hi Ian,
>>>>
>>>> It looks like nothing at all was created after all, not even the
>>>> repository. Or maybe I don't understand how github works.
>>>>
>>>> $ git push puppet-ceph master
>>>> ERROR: Permission to ceph/puppet-ceph.git denied to dachary.
>>>> fatal: Could not read from remote repository.
>>>>
>>>> Please make sure you have the correct access rights
>>>> and the repository exists.
>>>>
>>>> Could you please re-create it and add a README ? I should be able to=

>>>> get
>>>> rid of it afterwards.
>>>
>>> Done.
>>>
>>>>
>>>> Thank you for your patience
>>>>
>>>> On 16/12/2013 04:46, Ian Colle wrote:
>>>>>
>>>>>
>>>>> On 12/14/13, 9:39 AM, "Loic Dachary" <loic@dachary.org> wrote:
>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Could someone with sufficient permission please create the
>>>>>> puppet-ceph
>>>>>> repository (empty, no README or .gitignore) at
>>>>>> http://github.com/ceph/
>>>>>> ?
>>>>>
>>>>> Done.
>>>>>
>>>>> https://github.com/ceph/puppet-ceph
>>>>>
>>>>>
>>>>>>
>>>>>> A few weeks ago it was decided to host the development of the modu=
le
>>>>>> on
>>>>>> stackforge ( https://github.com/stackforge/puppet-ceph ) and also =
to
>>>>>> establish a mirror under the ceph github namespace.
>>>>>>
>>>>>> Cheers
>>>>>>
>>>>>> --=20
>>>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>> --=20
>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --=20
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--5bs5ls8IlWCk3kHED9GIpnfmgh5PaphIv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKvjZUACgkQ8dLMyEl6F22hpwCgqPCNNvHAXjGQjVUOc67QHLzC
LgUAoJZ+A81zQFJomVPQB3NHf5hkjKW9
=IDGG
-----END PGP SIGNATURE-----

--5bs5ls8IlWCk3kHED9GIpnfmgh5PaphIv--
