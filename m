From: Joshua Schmid <jschmid@suse.de>
Subject: Re: Fwd: Re: osd dm-crypt key management, part... deux?
Date: Tue, 2 Feb 2016 12:26:59 +0100
Message-ID: <56B09283.6080603@suse.de>
References: <56A9E13E.8050508@suse.de> <56A9E2EC.8040000@suse.de>
 <alpine.DEB.2.11.1601280952120.6710@cpach.fuggernut.com>
 <56AA42A4.7080406@suse.de>
 <alpine.DEB.2.11.1601281244360.4107@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46343 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754458AbcBBLV3 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 2 Feb 2016 06:21:29 -0500
In-Reply-To: <alpine.DEB.2.11.1601281244360.4107@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 01/28/2016 06:46 PM, Sage Weil wrote:
> On Thu, 28 Jan 2016, Joshua Schmid wrote:
>>>>> 2- Implement a simple mon-based strategy upstream.  We've discuss=
ed this a=20
>>>>> fair bit in the past, and were getting stuck on the problem of wh=
ere to=20
>>>>> store the key-fetching-key.  I.e., we want a key on the disk that=
 you use=20
>>>>> to ask the monitor for the LUKS key, which you then provide to LU=
KS to=20
>>>>> unlock the actual encryption key.  This means that we need a unen=
crypted=20
>>>>> spot on the device to store it in.  Milan has indicated that putt=
ing it in=20
>>>>> a LUKS key slot would be a bad idea and difficult to maintain.  I=
nstead, I=20
>>>>> propose we create a new GPT partition type called OSD_LOCKBOX (or=
=20
>>>>> similar), with a tiny filesystem and a few files indicating what =
to do. =20
>>>>> This will make it easy to store the info we need for the mon sche=
me, and=20
>>>>> to support new key management approaches later (we can put whatev=
er we=20
>>>>> want there as long as it's not too big).
>>>>
>>>> Sounds good! But i still see the possible scenario where you dump =
a
>>>> whole rack with a MON + OSD. As a potential attacker, having these=
 two
>>>> components would grant you access to all the keys needed to decryp=
t the
>>>> OSDdata. If I got understood it correctly that every MON should ho=
ld all
>>>> available keys.
>>>
>>> I think this is no different than a normal keyserver: if you steal =
the=20
>>> encrypted thing, and the keyserver, then the game is up.  In this c=
ase the=20
>>> mon is just acting as a keyserver.
>>>
>>> Unless there are other tricks that the keyservers normally play?
>>
>> The only difference between a dedicated keyserver and a MON is that =
you
>> hopefully know where its physically located and can take precautions=
=2E So
>> the problem(customer needs) we are facing is not only theft but the
>> ability to just dump disks/nodes/racks without exposing sensitive da=
ta.
>>
>>
>>>
>>>> Some additions:
>>>>
>>>> The MON should only hand out keys when authenticated or in a clean
>>>> cluster context. So what i mean is basically some way to proof if =
the
>>>> MON is not in a made up environment.
>>>
>>> Like, a secret to decrypt the keyservers' keys might be erasure cod=
ed=20
>>> across the keyservers so that you can only decrypt when you have a =
quorum?
>>>
>> sounds pretty good to me! that would cover all requirements i can
>> currently think of..
>=20
> I'm skeptical that's actually something we want to implement in the m=
on,=20
> though.  I think if you want that level of security (secret sharding=20
> across keyservers) you should use a real keyserver and not the mon.  =
I=20
> think if we cover the basic case, though, where we assume the monitor=
=20
> nodes are secure and separate from the OSDs, then that'll cover most=20
> users' needs.

Thats true. There is one more concern I have about using MONs as
keyservers. Users might want to encrypt their swap/root (and i some
cases I guess they have to) what means that authentication has to take
place in the initrd. Pulling in a ceph-client to retrieve the keys migh=
t
be a bad idea. So i guess relying on a rather small service (ftps) coul=
d
be cleaner/easier.

>=20
> sage
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
=46reundliche Gr=FC=DFe - Kind regards,
Joshua Schmid
SUSE Enterprise Storage - Trainee
SUSE Linux GmbH - Maxfeldstr. 5 - 90409 N=FCrnberg
-----------------------------------------------------------------------=
---------------------------------------------
SUSE Linux GmbH, GF: Felix Imend=F6rffer, Jane Smithard,
Jennifer Guild, Dilip Upmanyu, Graham Norton, HRB 21284 (AG N=FCrnberg)
-----------------------------------------------------------------------=
---------------------------------------------
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
