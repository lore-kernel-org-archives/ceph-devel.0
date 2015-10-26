From: Loic Dachary <loic@dachary.org>
Subject: Re: Ceph erasure coding
Date: Tue, 27 Oct 2015 04:16:02 +0900
Message-ID: <562E7BF2.7040602@dachary.org>
References: <CA+nGFBodcEq0vOvuFP1Od0zVCyk_9PufsRSYBJYi1W4p_vh+7g@mail.gmail.com>	<562915FC.9090401@dachary.org> <CA+nGFBo2=i_ez_KkLchGQPeShuOevy0A20eu0=+HxjMeoce1xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="4KRTPjE53knGu03HW296fphQ9IkBg9I02"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:50194 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751108AbbJZTQI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 26 Oct 2015 15:16:08 -0400
In-Reply-To: <CA+nGFBo2=i_ez_KkLchGQPeShuOevy0A20eu0=+HxjMeoce1xw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kjetil Babington <babingto@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4KRTPjE53knGu03HW296fphQ9IkBg9I02
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 27/10/2015 03:34, Kjetil Babington wrote:
> I see, thank you for your replies. I will try to implement a
> CRUSH-map, which distributes the chunks in such a way.  Do you think
> there will be any performance issues with such a map, placing multiple
> smaller chunks on each osd instead of one large on each?

Maybe but I'd be better able to tell you looking at the crush ruleset.

> The reason we would like to do this, is that we have developed some
> new erasure codes, which we would like to test on a large-scale
> storage system like Ceph. These erasure codes rely on
> sub-packetization to reduce the amount of data read from each disk
> when reconstructing an erasure. Since CEPH does not seem to have an
> ability to read part of a chunk, we thought we could sort of bypass
> this by making each chunk contain one sub-packet, and place a set of
> these chunks (sub-packets) on each osd.

Interesting :-) Could you share the URL to the code of this erasure code =
plugin ?

Cheers

>=20
> 2015-10-22 18:59 GMT+02:00 Loic Dachary <loic@dachary.org>:
>> Hi,
>>
>> On 22/10/2015 18:44, Kjetil Babington wrote:
>>> Hi,
>>>
>>> I have a question about the capabilities of the erasure coding API in=

>>> Ceph. Let's say that I have 10 data disks and 4 parity disks, is it
>>> possible to create an erasure coding plugin which creates 20 data
>>> chunks and 8 parity chunks, and then places two chunks on each osd?
>>>
>>> Or said maybe a bit simpler is it possible for two or more chunks fro=
m
>>> the same encode operation to be placed on the same osd?
>>
>> This is more a question of creating a crush ruleset that does it. The =
erasure code plugin encodes chunks but the crush ruleset decides where th=
ey are placed.
>>
>> Cheers
>>
>>>
>>> - Kjetil Babington
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

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--4KRTPjE53knGu03HW296fphQ9IkBg9I02
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlYue/IACgkQ8dLMyEl6F22VIwCfWBSOEiONuyHKEPm83N9IdWCO
eVMAnRM9P1cS8PCXApCMDVikEyn7sUvZ
=UF+d
-----END PGP SIGNATURE-----

--4KRTPjE53knGu03HW296fphQ9IkBg9I02--
