From: Loic Dachary <loic@dachary.org>
Subject: Re: Fwd: monitor crashing
Date: Tue, 13 Oct 2015 15:52:27 +0200
Message-ID: <561D0C9B.2050706@dachary.org>
References: <CACx0BdM2qsO0n492Y7R=+FBfJzJT+4HxbBYaU1rkG0mZV=caJw@mail.gmail.com> <CACx0BdNRPk64Etwvs7_tEce=xwFw7E4Ube=8raav_-EFhhP2Fw@mail.gmail.com> <CACx0BdMi79jokSX4aPy9XJrUorE-2Fa-_oBDjYwW3bBuee5A7g@mail.gmail.com> <alpine.DEB.2.00.1510130624270.6589@cobra.newdream.net> <CACx0BdOOY0k02kJSacm_rHgBz0wLKv0YtganjuGy9Vtj63QVPQ@mail.gmail.com> <alpine.DEB.2.00.1510130637450.6589@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6dhLM9HwFKJd86P6xmOCAR9bjb9t2U3id"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42202 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753005AbbJMNwa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 13 Oct 2015 09:52:30 -0400
In-Reply-To: <alpine.DEB.2.00.1510130637450.6589@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Luis Periquito <periquito@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6dhLM9HwFKJd86P6xmOCAR9bjb9t2U3id
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

https://github.com/ceph/ceph/compare/hammer...wip-ecpool-hammer

In order to bypass the crush verification, you could:

ceph tell mon.* injectargs --crushtool /bin/true

Cheers

On 13/10/2015 15:41, Sage Weil wrote:
> On Tue, 13 Oct 2015, Luis Periquito wrote:
>> the store.db dir is 3.4GB big :(
>>
>> can I do it on my side?
>=20
> Nevermind, I was able to reproduce it from the bugzilla.  I've pushed a=
=20
> branch wip-ecpool-hammer.  Not sure which distro you're on, but package=
s=20
> will appear at gitbuilder.ceph.com in 30-45 minutes.  This fixes the mo=
n=20
> crash, which will let you delete the pool.  I suggest stopping the OSDs=
=20
> before starting the mon with this or else they might get pg create=20
> messages and crash too.  Once the pool is removed you can start them=20
> again.  They shouldn't need to be upgraded.
>=20
> Note that the latest hammer doesn't let you create the pool at all beca=
use=20
> it fails the crush safety check (I had to disable the check to reproduc=
e=20
> this), so that's good at least!
>=20
> sage
>=20
>>
>> On Tue, Oct 13, 2015 at 2:25 PM, Sage Weil <sage@newdream.net> wrote:
>>> On Tue, 13 Oct 2015, Luis Periquito wrote:
>>>> Any ideas? I'm growing desperate :(
>>>>
>>>> I've tried compiling from source, and including
>>>> https://github.com/ceph/ceph/pull/5276, but it still crashes on boot=

>>>> of the ceph-mon
>>>
>>> If you can email a (link to a) tarball of your mon data directory I'd=
 love
>>> to extract the osdmap and see why crush is crashing.. it's obviously =
not
>>> supposed to do that (even with a bad rule).  You can also use
>>> the ceph-post-file utility.
>>>
>>> Thanks!
>>> sage
>>>
>>>
>>>>
>>>> ---------- Forwarded message ----------
>>>> From: Luis Periquito <periquito@gmail.com>
>>>> Date: Tue, Oct 13, 2015 at 12:26 PM
>>>> Subject: Re: monitor crashing
>>>> To: Ceph Users <ceph-users@lists.ceph.com>
>>>>
>>>>
>>>> I'm currently running Hammer (0.94.3), created an invalid LRC profil=
e
>>>> (typo in the l=3D, should have been l=3D4 but was l=3D3, and now I d=
on't
>>>> have enough different ruleset-locality) and created a pool. Is there=

>>>> any way to delete this pool? remember I can't start the ceph-mon...
>>>>
>>>> On Tue, Oct 13, 2015 at 11:56 AM, Luis Periquito <periquito@gmail.co=
m> wrote:
>>>>> It seems I've hit this bug:
>>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1231630
>>>>>
>>>>> is there any way I can recover this cluster? It worked in our test
>>>>> cluster, but crashed the production one...
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--6dhLM9HwFKJd86P6xmOCAR9bjb9t2U3id
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYdDJsACgkQ8dLMyEl6F20cagCgnGJVfFcg6xaQdfS2hauWWBYq
wQUAn1dMaS+YN8NGpDB4U+p/LPIwnZev
=Q5lw
-----END PGP SIGNATURE-----

--6dhLM9HwFKJd86P6xmOCAR9bjb9t2U3id--
