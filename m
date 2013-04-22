From: "Christopher LILJENSTOLPE" <cdl@asgaard.org>
Subject: Re: erasure coding (sorry)
Date: Mon, 22 Apr 2013 07:08:24 -0700
Message-ID: <0AEB5F22-B38F-4702-95A1-B18938FE7F7C@asgaard.org>
References: <20130418162842.0c61d1e2@dieter-t420s>
 <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net>
 <517060B2.80706@inktank.com> <51706120.2060702@inktank.com>
 <20130418173113.74a53769@dieter-t420s>
 <8232544E-56F5-40BF-899D-2A2D4735FD54@asgaard.org>
 <5174F08F.2070001@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_A162998C-47E5-4FBC-A557-5AC3B5B6D257_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.emailarray.com ([69.28.212.198]:25392 "EHLO
	smtp2.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab3DVOIg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 10:08:36 -0400
In-Reply-To: <5174F08F.2070001@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_A162998C-47E5-4FBC-A557-5AC3B5B6D257_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Supposedly, on 2013-Apr-22, at 01.10 PDT(-0700), someone claiming to be L=
oic Dachary scribed:

> Hi Christopher,
>
> You wrote "A modified client/library could be used to store objects tha=
t should be sharded, vs "standard" ceph treatment.  In this model, each s=
hard would be written to a seperate PG, and each PG would we stored on ex=
actly one OSD.  " but there is no way for a client to enforce the fact th=
at two objects are stored in separate PG.

Poorly worded.  The idea is that each shard becomes a seperate object, an=
d the encoder/sharder would use CRUSH to identify the OSDs to hold the sh=
ards.  However, the OSDs would treat the shard as an n=3D1 replication an=
d just store locally.  =


Actually, looking at this this morning, this is actually harder than the =
prefered alternative (i.e. grafting a encode/decode into the (e)OSD.  It =
was meant to cover the alternative approaches.  I didn't like this one, b=
ut it now appears to be more difficult, and non-deterministic of the plac=
ement.  =


One question on CRUSH (it's been too long since I read the paper), if x i=
s the same for two objects, and, using an n=3D3 returns R=3D{OSD18,OSD45,=
OSD97}, if an object is handed to OSD45 that matches x, but has an n=3D1,=
 would OSD45 store it, or would it forward it to OSD18 to store?  If it w=
ould this idea is DOA.  Also, if x is held invariant, but n changes, does=
 the same R set get returned (truncated to n members)?

	Thx
	Christopher



>
> Am I missing something ?
>
> On 04/22/2013 09:23 AM, Christopher LILJENSTOLPE wrote:
>> Supposedly, on 2013-Apr-18, at 14.31 PDT(-0700), someone claiming to b=
e Plaetinck, Dieter scribed:
>>
>>> On Thu, 18 Apr 2013 16:09:52 -0500
>>> Mark Nelson <mark.nelson@inktank.com> wrote:
>>
>>>>
>>>
>>> @Bryan: I did come across cleversafe.  all the articles around it see=
med promising,
>>> but unfortunately it seems everything related to the cleversafe open =
source project
>>> somehow vanished from the internet.  (e.g. http://www.cleversafe.org/=
) quite weird...
>>>
>>> @Sage: interesting. I thought it would be more relatively simple if o=
ne assumes
>>> the restriction of immutable files.  I'm not familiar with those ceph=
 specifics you're mentioning.
>>> When building an erasure codes-based system, maybe there's ways to re=
use existing ceph
>>> code and/or allow some integration with replication based objects, wi=
thout aiming for full integration or
>>> full support of the rados api, based on some tradeoffs.
>>>
>>> @Josh, that sounds like an interesting approach.  Too bad that page d=
oesn't contain any information yet :)
>>
>> Greetings - it does now - see what you all think=E2=80=A6
>>
>> 	Christopher
>>
>>>
>>> Dieter
>>
>>
>> --
>> =E6=9D=8E=E6=9F=AF=E7=9D=BF
>> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
>> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
>> Check my calendar availability: https://tungle.me/cdl
>
> -- =

> Lo=C3=AFc Dachary, Artisan Logiciel Libre


--
=E6=9D=8E=E6=9F=AF=E7=9D=BF
Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
Check my calendar availability: https://tungle.me/cdl
--=_MailMate_A162998C-47E5-4FBC-A557-5AC3B5B6D257_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJRdURYAAoJEGmx2Mt/+Iw/ancH/3jluXC+yZztm5bXIZQwF2mH
OY8ebn5H4ehFRK0El3+czcly0C5EGZ9dBTvdAKul1qkBU1YFe+hS+IohoVD8hWRx
Yz79Xmma2r78q1wlK7jKvN2VrzVoVyYW5ClJ8DrBeIIOi9nhMi5PHoJujIXjdXB0
pk92FdyorgNGIKYGaNgTiVL8RtOCl1jEU/ILZuUsJSP7wsDF3Tyn3UXQjG6sfe5h
tV0iBPmTzdJLEQldHd8Dtxjk2JTMqDuao5s11hYOGa32YxP6ORcXwc0gtlQHt3Ga
Gqxm0pTixt8r7REEWprtbOnKPJ7KzQD687mnjCWv2hlQmj7xpaRLA3n2+3wFdtg=
=QTJK
-----END PGP SIGNATURE-----

--=_MailMate_A162998C-47E5-4FBC-A557-5AC3B5B6D257_=--
