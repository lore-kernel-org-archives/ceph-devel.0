From: Sebastien Han <sebastien.han@enovance.com>
Subject: Re: ceph-brag ready
Date: Sat, 8 Mar 2014 11:28:27 +0100
Message-ID: <5900FC4F-1498-4B4E-A667-D14212065F1D@enovance.com>
References: <78E29451-D203-4B1A-B825-E86894D940FB@enovance.com> <alpine.DEB.2.00.1402150942070.17892@cobra.newdream.net> <6FD0B3B6-DA32-4EBD-A807-2DDA3388E345@enovance.com> <alpine.DEB.2.00.1403031528410.17314@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Content-Type: multipart/signed; boundary="Apple-Mail=_BB0788B1-3AB9-4ADA-A0E0-43F8F50CEE1E"; protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mxi1.enovance.com ([94.143.114.217]:54569 "EHLO
	mxi1.enovance.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbaCHK2b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 8 Mar 2014 05:28:31 -0500
In-Reply-To: <alpine.DEB.2.00.1403031528410.17314@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Anbu <anbu@enovance.com>


--Apple-Mail=_BB0788B1-3AB9-4ADA-A0E0-43F8F50CEE1E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hey Sage,

Sorry for the late reply.
It was good to see you as well :).

Babu took (in cc) took care of the changes, he is about to push a PR for =
this.

Cheers.
=96=96=96=96=20
S=E9bastien Han=20
Cloud Engineer=20

"Always give 100%. Unless you're giving blood.=94=20

Phone: +33 (0)1 49 70 99 72=20
Mail: sebastien.han@enovance.com=20
Address : 11 bis, rue Roqu=E9pine - 75008 Paris
Web : www.enovance.com - Twitter : @enovance=20

On 04 Mar 2014, at 00:35, Sage Weil <sage@inktank.com> wrote:

> Hi Sebastien,
>=20
> Good seeing you last week in Frankfurt!
>=20
> I meant to follow up earlier (or hack on this a bit myself) but =
haven't=20
> had time.  After taking a look, my wish list here would be:
>=20
> - simplify the 'bytes' info to just be bytes.
>=20
> - maybe prefix these all with 'num_'
>=20
> - for crush_types, make it a map of type to count, so we can tell how =
many=20
> racks/rows/hosts/etc there are.
>=20
> - i wouldn't include the pool names in the pool metadata; that is =
probably=20
> too sensitive.
>=20
> - but, we can include 'type' (replicated|erasure) and change =
'rep_size' to=20
> 'size' (which is a more general name)
>=20
> - for sysinfo, i would remove nw_info entirely?  not sure what this =
would=20
> be for, but generally if there is any identifying info people will not=20=

> want to use this
>=20
> - for all the other metadata, i wonder if it would be better to break =
it=20
> down into a histogram (like the crush types) with a value and count, =
so=20
> that we just see how many of each =
version/distro/kernel/os/arch/cpu/etc=20
> are running.  unless people think it would be useful to see how they=20=

> correlate?
>=20
> In general, it seems like the more compact the info is, the easier and=20=

> more likely it is for a person to look at it, see it is safe to share, =
and=20
> then do so.
>=20
> Thanks!
> sage
>=20
>=20
>=20
>=20
> On Sun, 16 Feb 2014, Sebastien Han wrote:
>=20
>> Sorry for the late response Sage..
>> As discussed on IRC, LGPL is fine.
>>=20
>> Thanks for taking care of this :)
>>=20
>> Cheers.
>> =96=96=96=96=20
>> S=E9bastien Han=20
>> Cloud Engineer=20
>>=20
>> "Always give 100%. Unless you're giving blood.=94=20
>>=20
>> Phone: +33 (0)1 49 70 99 72=20
>> Mail: sebastien.han@enovance.com=20
>> Address : 10, rue de la Victoire - 75009 Paris=20
>> Web : www.enovance.com - Twitter : @enovance=20
>>=20
>> On 15 Feb 2014, at 18:43, Sage Weil <sage@inktank.com> wrote:
>>=20
>>> On Wed, 12 Feb 2014, Sebastien Han wrote:
>>>> Hi guys,
>>>>=20
>>>> First implementation of the ceph-brag is ready.
>>>> We have a public repo available here, so can try it out.
>>>>=20
>>>> https://github.com/enovance/ceph-brag
>>>>=20
>>>> However I don=92t have any idea on how to submit this to =
github.com/ceph.
>>>> Can someone help me on that?
>>>=20
>>> I'm merging this into ceph.git now (src/brag/{client, server}).  I =
don't=20
>>> see Signed-off-by lines on the commits, though, or an indication of =
what=20
>>> the license is.  Can you confirm whether this should be LGPL or MIT =
or=20
>>> whatever?
>>>=20
>>> Thanks!
>>> sage
>>=20


--Apple-Mail=_BB0788B1-3AB9-4ADA-A0E0-43F8F50CEE1E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJTGvDLAAoJECPrkYfpbtGToMkH/Rc1txv1mMFFCmqpg6LVjXs1
lU687pRjerEqoqoJifO6x42odtHBzpHGwImlCxD/qPinjLKWhSp8qM5okarIlwRs
VWbiHHk2udtPfqX39NHfkHZQK+Wzxrx3nsxh3ClTyuK4ajZ2ki4OvNc0ZpVv8T1R
VjdIkNkpcgKyNHSrmV/Q66Dd8JJdnnCLSfVWUSAiJZ0JlhyWI+WRYIMBU2L8pNUV
D28f9ZBFY6nAYpIuN52y0XELlp/0Ty4h8jHLQxp1dW+DuIu3k4kh4R9I/4Pb//D8
OM9ANNbdhhuz1Rsv6SBFV12xW5kbfhsi6iHBohBOhdgU2+XMHwiO/fl0Voek85s=
=KqTr
-----END PGP SIGNATURE-----

--Apple-Mail=_BB0788B1-3AB9-4ADA-A0E0-43F8F50CEE1E--
