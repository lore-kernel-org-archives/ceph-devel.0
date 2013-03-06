From: Loic Dachary <loic@dachary.org>
Subject: Re: OpenStack summit : Ceph design session
Date: Wed, 06 Mar 2013 23:45:50 +0100
Message-ID: <5137C71E.5090507@dachary.org>
References: <51289AF2.9010509@dachary.org> <512A9F5F.7080706@inktank.com> <CANygib_m5h6F7u5ayzSTdZ2Y_8mO414dFXQup2w8NTWQtYWc9w@mail.gmail.com> <512B3725.4040602@dachary.org> <513319E8.7000105@dachary.org> <CANygib_axAT=3vmG39GNCb0X_1Goycy+P6nF2UQyBcUm9EqbUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1CA9D2B3A4D72C1AF5B35E66"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:36306 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752838Ab3CFWpz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Mar 2013 17:45:55 -0500
In-Reply-To: <CANygib_axAT=3vmG39GNCb0X_1Goycy+P6nF2UQyBcUm9EqbUA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Neil Levine <neil.levine@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1CA9D2B3A4D72C1AF5B35E66
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Neil,

On 03/06/2013 08:27 PM, Neil Levine wrote:
> I think the multi-site RGW stuff is somewhat orthogonal to OpenStack

Even when keystone is involved ?

> where as the RBD backups needs to factor in Horizon, Cinder APIs and
> where the logic for managing the backups sits.
>=20
> Ross is looking to get a wiki setup for Ceph blueprints so we can
> document the incremental snapshot stuff and then use this as a basis
> for creating the OpenStack blueprint.

Great.

> Who approves the session at ODS and when is this decision made?

I suspect Josh knows more than I do about this. During the cinder meeting=
 earlier today J. Griffith said that if the nova track is too busy to hos=
t the "Roadmap for Ceph integration with OpenStack" session he was in fav=
or of having it in the cinder track. Following his advice I suggested to =
Thierry Carrez to open a "Cross project" track ( http://lists.openstack.o=
rg/pipermail/openstack-dev/2013-March/006365.html )=20

Cheers

> Neil
>=20
> On Sun, Mar 3, 2013 at 1:37 AM, Loic Dachary <loic@dachary.org> wrote:
>> Hi Neil,
>>
>> I've updated http://summit.openstack.org/cfp/details/38 with the Geogr=
aphic DR related threads
>>
>>     Geo-replication with RADOS GW http://marc.info/?l=3Dceph-devel&m=3D=
135939566407623&w=3D4
>>     Geographic DR for RGW http://marc.info/?l=3Dceph-devel&m=3D1361914=
79931880&w=3D4
>>
>> I'm increasingly interested in figuring out how it fits with OpenStack=
=2E
>>
>> Cheers
>>
>> On 02/25/2013 11:04 AM, Loic Dachary wrote:
>>> Hi Neil,
>>>
>>> I've added "RBD backups secondary clusters within Openstack" to the l=
ist of blueprints. Do you have links to mail threads / chat logs related =
to this topic ?
>>>
>>> I moved the content of the session to an etherpad for collaborative e=
diting
>>>
>>> https://etherpad.openstack.org/roadmap-for-ceph-integration-with-open=
stack
>>>
>>> and it is now linked from
>>>
>>> http://summit.openstack.org/cfp/details/38
>>>
>>> Cheers
>>>
>>> On 02/25/2013 07:12 AM, Neil Levine wrote:
>>>> Thanks for taking the lead on this Loic.
>>>>
>>>> As a blueprint, I'd like to look at RBD backups to secondary cluster=
s
>>>> within Openstack. Nick Barcet and others have mentioned ideas for th=
is
>>>> now that Cinder is multi-cluster aware.
>>>>
>>>> Neil
>>>>
>>>> On Sun, Feb 24, 2013 at 3:16 PM, Josh Durgin <josh.durgin@inktank.co=
m> wrote:
>>>>> On 02/23/2013 02:33 AM, Loic Dachary wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> In anticipation of the next OpenStack summit
>>>>>> http://www.openstack.org/summit/portland-2013/, I proposed a sessi=
on to
>>>>>> discuss OpenStack and Ceph integration. Our meeting during FOSDEM =
earlier
>>>>>> this month was a great experience although it was planned at the l=
ast
>>>>>> minute. I hope we can organize something even better for the summi=
t.
>>>>>>
>>>>>> For developers and contributors to both Ceph and OpenStack such as=
 myself,
>>>>>> it would be a great opportunity to figure out a sensible roadmap f=
or the
>>>>>> next six months. I realize this roadmap is already clear for Josh =
Durgin and
>>>>>> other Ceph / OpenStack developers who are passionately invested in=
 both
>>>>>> projects for a long time. However I am new to both projects and su=
ch a
>>>>>> session would be a precious guide and highly motivating.
>>>>>>
>>>>>> http://summit.openstack.org/cfp/details/38
>>>>>>
>>>>>> What do you think ?
>>>>>>
>>>>>
>>>>> Sounds like a great idea!
>>>>> Thanks for putting together the session!
>>>>>
>>>>> Josh
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig1CA9D2B3A4D72C1AF5B35E66
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlE3xx4ACgkQ8dLMyEl6F20rcQCfVUSXet3LmdNOeUyWbGnAPjhE
V6YAoL2y7INRRA8EWOwf8YP+KYTa6344
=OZWC
-----END PGP SIGNATURE-----

--------------enig1CA9D2B3A4D72C1AF5B35E66--
