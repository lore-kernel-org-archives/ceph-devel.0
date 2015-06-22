From: Loic Dachary <loic@dachary.org>
Subject: Re: firefly v0.80.10 QE validation completed
Date: Mon, 22 Jun 2015 05:12:03 -0400
Message-ID: <5587D163.1040007@dachary.org>
References: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com> <628525610.25137687.1434591207216.JavaMail.zimbra@redhat.com> <1434958820.2806.3.camel@daevel.fr> <5587CBD3.5020804@dachary.org> <CABZ+qq=6bdicLnsCV3moVBRaBe=gXkHxqSMuL8rUZW1Mmpfj9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="v2lgVlrLFESeqqG45usg878VHcGhiieiE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38023 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932946AbbFVJMH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jun 2015 05:12:07 -0400
In-Reply-To: <CABZ+qq=6bdicLnsCV3moVBRaBe=gXkHxqSMuL8rUZW1Mmpfj9Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Alfredo Deza <adeza@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--v2lgVlrLFESeqqG45usg878VHcGhiieiE
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Dan,

On 22/06/2015 04:52, Dan van der Ster wrote:
> Hi Loic,
>=20
> What does "published" mean? 0.80.10 looks published to me:
> http://ceph.com/rpm-firefly/el6/x86_64/

It looks like it is indeed :-) I guess "published" would mean that the pe=
rson in charge of publishing the release declares it is done. I don't thi=
nk it happened yet, or if it did I missed it.

Cheers

>=20
> Cheers, Dan
>=20
>=20
>=20
> On Mon, Jun 22, 2015 at 10:48 AM, Loic Dachary <loic@dachary.org> wrote=
:
>>
>> Hi Olivier,
>>
>> On 22/06/2015 03:40, Olivier Bonvalet wrote:
>>> Hi,
>>>
>>> I saw the proposed upgrade to 0.80.10 this morning, but can't find th=
e
>>> announce about this (neither by email or on the website).
>>>
>>> Is the 0.80.10 ready to be used ?
>>>
>>
>> The QE validation is the last step before it is published. But it's no=
t published yet. You can track progress at http://tracker.ceph.com/issues=
/11090
>>
>> Cheers
>>
>>> thanks,
>>> Olivier
>>>
>>> Le mercredi 17 juin 2015 =C3=A0 21:33 -0400, Yuri Weinstein a =C3=A9c=
rit :
>>>> firefly v0.80.10 is ready for publishing (Sage, Alfredo, Loic, Xinxi=
n
>>>> FYI)
>>>>
>>>> All results details were summarized in
>>>> http://tracker.ceph.com/issues/11090
>>>>
>>>> Note:
>>>>
>>>> - upgrade/dumpling-firefly-x (to hammer)(distros) - runs out of
>>>> memory on vps and unreliable
>>>> - #11957 fixed (thanks Ilya, Zack!) and tested
>>>>
>>>> Thx
>>>> YuriW
>>>>
>>>> ----- Original Message -----
>>>> From: "Yuri Weinstein" <yweinste@redhat.com>
>>>> To: "Ceph Development" <ceph-devel@vger.kernel.org>
>>>> Cc: "Loic Dachary" <ldachary@redhat.com>, "Xinxin Shu" <
>>>> xinxin.shu@intel.com>
>>>> Sent: Monday, June 15, 2015 9:37:20 AM
>>>> Subject: firefly v0.80.10 QE validation status 6/15/2015
>>>>
>>>> QE validation is almost completed (there are a couple of jobs that
>>>> are still running)
>>>>
>>>> All statis details were summarized in
>>>> http://tracker.ceph.com/issues/11090
>>>>
>>>> Highlights (by suite/issue):
>>>>
>>>> rados #11914 needs Sam's approval
>>>> kcephfs n/a needs Greg's approval
>>>> samba #6613 needs Greg's approval
>>>>
>>>> Nice to have fixes (no blockers):
>>>> upgrade/firefly(distros) #11957      (env noise)
>>>>
>>>>
>>>> Thx
>>>> YuriW
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
"
>>>> in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--v2lgVlrLFESeqqG45usg878VHcGhiieiE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWH0WMACgkQ8dLMyEl6F209uQCfX+/0IwdWjXKNUceP7awrC4YG
L6UAoIULv3m6HOM0efSDQLlFkY1CnM5K
=Yjo9
-----END PGP SIGNATURE-----

--v2lgVlrLFESeqqG45usg878VHcGhiieiE--
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
