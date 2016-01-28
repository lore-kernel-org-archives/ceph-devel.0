From: Joshua Schmid <jschmid@suse.de>
Subject: Re: Fwd: Re: osd dm-crypt key management, part... deux?
Date: Thu, 28 Jan 2016 17:32:36 +0100
Message-ID: <56AA42A4.7080406@suse.de>
References: <56A9E13E.8050508@suse.de> <56A9E2EC.8040000@suse.de>
 <alpine.DEB.2.11.1601280952120.6710@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54046 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753277AbcA1Q1P (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Jan 2016 11:27:15 -0500
In-Reply-To: <alpine.DEB.2.11.1601280952120.6710@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>



On 01/28/2016 03:53 PM, Sage Weil wrote:
> On Thu, 28 Jan 2016, Joshua Schmid wrote:
>>
>> Hi Sage,
>>
>> On 01/27/2016 03:26 PM, Sage Weil wrote:
>>> We've had several partial starts to address this problem but haven'=
t=20
>>> gotten anything over the line.  A quick summary:
>>>
>>> 1- Currently we store dm-crypt keys in /etc/ceph/dmcrypt-keys/$osd_=
uuid,=20
>>> on the boot disk.  This lets you throw away OSD disk but not boot d=
isks=20
>>> and doesn't help you if someone walks away with a whole server.
>>>
>>> 2- SUSE had a pull request that made ceph-disk push/pull keys over =
(s)ftp. =20
>>> I can't find it now.. did it get closed?
>>
>> It's here.
>>
>> https://github.com/SUSE/ceph/commit/0f5644ef3d1b1a9a14be97717b9d8dfe=
0338b74d
>>
>>>
>>> I suggest we do something simple:
>>>
>>> 1- Update SUSE's ceph-disk changes to make it easy to plug in=20
>>> different key management strategies.
>>
>> And there.
>>
>> https://github.com/SUSE/ceph/commit/127a47ca7cf28f387d832da265f6955b=
b04107c3
>=20
> Thanks!
>=20
>> SUSE currently sticks with this solution since its pluggable and wor=
ks
>> fairly well. It may not be the cleanest solution to rely on an exter=
nal
>> tool(ftp) but until now there is simply no other option.
>>
>>> 2- Implement a simple mon-based strategy upstream.  We've discussed=
 this a=20
>>> fair bit in the past, and were getting stuck on the problem of wher=
e to=20
>>> store the key-fetching-key.  I.e., we want a key on the disk that y=
ou use=20
>>> to ask the monitor for the LUKS key, which you then provide to LUKS=
 to=20
>>> unlock the actual encryption key.  This means that we need a unencr=
ypted=20
>>> spot on the device to store it in.  Milan has indicated that puttin=
g it in=20
>>> a LUKS key slot would be a bad idea and difficult to maintain.  Ins=
tead, I=20
>>> propose we create a new GPT partition type called OSD_LOCKBOX (or=20
>>> similar), with a tiny filesystem and a few files indicating what to=
 do. =20
>>> This will make it easy to store the info we need for the mon scheme=
, and=20
>>> to support new key management approaches later (we can put whatever=
 we=20
>>> want there as long as it's not too big).
>>
>> Sounds good! But i still see the possible scenario where you dump a
>> whole rack with a MON + OSD. As a potential attacker, having these t=
wo
>> components would grant you access to all the keys needed to decrypt =
the
>> OSDdata. If I got understood it correctly that every MON should hold=
 all
>> available keys.
>=20
> I think this is no different than a normal keyserver: if you steal th=
e=20
> encrypted thing, and the keyserver, then the game is up.  In this cas=
e the=20
> mon is just acting as a keyserver.
>=20
> Unless there are other tricks that the keyservers normally play?

The only difference between a dedicated keyserver and a MON is that you
hopefully know where its physically located and can take precautions. S=
o
the problem(customer needs) we are facing is not only theft but the
ability to just dump disks/nodes/racks without exposing sensitive data.


>=20
>> Some additions:
>>
>> The MON should only hand out keys when authenticated or in a clean
>> cluster context. So what i mean is basically some way to proof if th=
e
>> MON is not in a made up environment.
>=20
> Like, a secret to decrypt the keyservers' keys might be erasure coded=
=20
> across the keyservers so that you can only decrypt when you have a qu=
orum?
>=20
sounds pretty good to me! that would cover all requirements i can
currently think of..

> sage
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
