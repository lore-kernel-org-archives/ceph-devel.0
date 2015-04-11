From: Loic Dachary <loic@dachary.org>
Subject: Re: loadable objectstore
Date: Sat, 11 Apr 2015 17:06:39 +0200
Message-ID: <5529387F.2040607@dachary.org>
References: <1395275405.143.1428703419864.JavaMail.root@thunderbeast.private.linuxbox.com> <alpine.DEB.2.00.1504101545120.4469@cobra.newdream.net> <C226B0AB34511445928D9882AA519F601C3DB5ED@SACMBXIP03.sdcorp.global.sandisk.com> <alpine.DEB.2.00.1504110746540.4469@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="hrrEDWKaljlkWKmwMeJqRha4p4ueUOwiM"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:45165 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753942AbbDKPGm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Apr 2015 11:06:42 -0400
In-Reply-To: <alpine.DEB.2.00.1504110746540.4469@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, Varada Kari <Varada.Kari@sandisk.com>
Cc: "Matt W. Benjamin" <matt@cohortfs.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hrrEDWKaljlkWKmwMeJqRha4p4ueUOwiM
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sage,

It looks like common/PluginRegistry.{h,cc} are missing from 18ad8df1094db=
52c839dc6b2dc689fc882230acb

Cheers

On 11/04/2015 16:51, Sage Weil wrote:
> On Sat, 11 Apr 2015, Varada Kari wrote:
>> Hi Matt/ Sage,
>>
>> Thanks for sharing the pull request. Will work on the items what sage =

>> was mentioning in the comments along with the items in the tracker.
>=20
> I pushed a wip-plugin branch with the pattern I had in mind... does thi=
s=20
> make sense?  It's only compile tested, and still needs preload() method=
s=20
> implemented so that long-running daemons (or perhaps others?) can prelo=
ad=20
> it all at once.
>=20
> Ideally we would replace ErasurePluginRegistry with this too, which mea=
ns=20
> the naming of the .so's needs to be a bit more flexible as the EC plugi=
n=20
> scheme is something like /usr/lib/ceph/erasure-code/libec_$name.so (not=
 a=20
> strict function of type and name).  Or actually, we can just rename the=
=20
> EC .so's when this goes in?  Since they're explicitly incompatible=20
> between versions there is no reason the names need to remain=20
> consistent...
>=20
> sage
>=20
>>
>> Varada
>>
>> -----Original Message-----
>> From: Sage Weil [mailto:sage@newdream.net]
>> Sent: Saturday, April 11, 2015 4:16 AM
>> To: Matt W. Benjamin
>> Cc: Varada Kari; ceph-devel
>> Subject: Re: loadable objectstore
>>
>> On Fri, 10 Apr 2015, Matt W. Benjamin wrote:
>>> Hi Varada,
>>>
>>> I pushed branch hammer-osfactory to
>>> https://github.com/linuxbox2/ceph.git
>>>
>>> It can at least provide a starting point for discussion, if not a
>>> jumping off point;  I do think it's basically what Sage described.
>>
>> I made a few comments on the pull request.  I think a factory class is=
 the way to go, but we should be able to make the plugin loading part gen=
eric and not interface specific at all...
>>
>> sage
>>
>>>
>>> I was able to update the CMake build system to build the tree, I
>>> haven't attempted Autotools. :(
>>>
>>> Regards,
>>>
>>> Matt
>>>
>>> --
>>> Matt Benjamin
>>> CohortFS, LLC.
>>> 315 West Huron Street, Suite 140A
>>> Ann Arbor, Michigan 48103
>>>
>>> http://cohortfs.com
>>>
>>> tel.  734-761-4689
>>> fax.  734-769-8938
>>> cel.  734-216-5309
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=

>>> in the body of a message to majordomo@vger.kernel.org More majordomo
>>> info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>>
>> ________________________________
>>
>> PLEASE NOTE: The information contained in this electronic mail message=
 is intended only for the use of the designated recipient(s) named above.=
 If the reader of this message is not the intended recipient, you are her=
eby notified that you have received this message in error and that any re=
view, dissemination, distribution, or copying of this message is strictly=
 prohibited. If you have received this communication in error, please not=
ify the sender by telephone or e-mail (as shown above) immediately and de=
stroy any and all copies of this message in your possession (whether hard=
 copies or electronically stored copies).
>>
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


--hrrEDWKaljlkWKmwMeJqRha4p4ueUOwiM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlUpOH8ACgkQ8dLMyEl6F20yBwCfeYjciL3CYB6a2zhUG0a8jh+o
sGwAoL2br9Ns+8m4p2vHnQ5t5+xM8/w/
=UrUg
-----END PGP SIGNATURE-----

--hrrEDWKaljlkWKmwMeJqRha4p4ueUOwiM--
