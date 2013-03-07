From: Loic Dachary <loic@dachary.org>
Subject: Re: OpenStack summit : Ceph design session
Date: Thu, 07 Mar 2013 23:21:36 +0100
Message-ID: <513912F0.80402@dachary.org>
References: <51289AF2.9010509@dachary.org> <512A9F5F.7080706@inktank.com> <CANygib_m5h6F7u5ayzSTdZ2Y_8mO414dFXQup2w8NTWQtYWc9w@mail.gmail.com> <512B3725.4040602@dachary.org> <513319E8.7000105@dachary.org> <CANygib_axAT=3vmG39GNCb0X_1Goycy+P6nF2UQyBcUm9EqbUA@mail.gmail.com> <5137C71E.5090507@dachary.org> <CANygib_BkX7oXGKNF44UxJL=1b=+6Kaw3janFaA4cDHPpxV9BQ@mail.gmail.com> <CAC-hyiEDiTNgdkNjc0Jd5hpY-vDELDhD0Xy7VPwhyAP4Yf37Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7E9D51FC71C1ADC186A07C95"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:41009 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753822Ab3CGWVj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 7 Mar 2013 17:21:39 -0500
In-Reply-To: <CAC-hyiEDiTNgdkNjc0Jd5hpY-vDELDhD0Xy7VPwhyAP4Yf37Jw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Neil Levine <neil.levine@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7E9D51FC71C1ADC186A07C95
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Yehuda,

I'm not sure if one keystone for all zones would be better than one keyst=
one per zone. If you think it's worth discussing during the OpenStack sum=
mit and you create a session http://summit.openstack.org/cfp/create in th=
e keystone track, I will definitely attend :-). Or I can do it if you lik=
e. But there is no way to share the edit permissions.

Cheers

On 03/07/2013 12:12 AM, Yehuda Sadeh wrote:
> On Wed, Mar 6, 2013 at 3:05 PM, Neil Levine <neil.levine@inktank.com> w=
rote:
>> On Wed, Mar 6, 2013 at 2:45 PM, Loic Dachary <loic@dachary.org> wrote:=

>>> Hi Neil,
>>>
>>> On 03/06/2013 08:27 PM, Neil Levine wrote:
>>>> I think the multi-site RGW stuff is somewhat orthogonal to OpenStack=

>>>
>>> Even when keystone is involved ?
>>
>> Good question.
>>
>> Yehuda: how would the asynchronously replicated user metadata interact=

>> with Keystone?
>=20
> Depends. Are there any special requirements? From what I understand,
> you'd define the keystone backend every zone interact with per-zone,
> and the fact that it's a replicated region/zone doesn't change much.
>=20
>>
>>>> Who approves the session at ODS and when is this decision made?
>>>
>>> I suspect Josh knows more than I do about this. During the cinder mee=
ting earlier today J. Griffith said that if the nova track is too busy to=
 host the "Roadmap for Ceph integration with OpenStack" session he was in=
 favor of having it in the cinder track. Following his advice I suggested=
 to Thierry Carrez to open a "Cross project" track ( http://lists.opensta=
ck.org/pipermail/openstack-dev/2013-March/006365.html )
>>
>> I don't think Cinder is such a bad place for it to be as presumably
>> the interaction to copy the block device to a secondary location would=

>> be triggered through a Cinder API call no?
>>
>> Neil
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

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig7E9D51FC71C1ADC186A07C95
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlE5EvAACgkQ8dLMyEl6F20v9ACfWmIJuXSpJ/5MVEluxz+J0rQr
/ukAnRUyWPIYkS63tVury6nJI/Dnf3WA
=jBg/
-----END PGP SIGNATURE-----

--------------enig7E9D51FC71C1ADC186A07C95--
