From: Loic Dachary <loic@dachary.org>
Subject: Re: Fwd: Re: osd dm-crypt key management, part... deux?
Date: Thu, 28 Jan 2016 19:00:00 +0700
Message-ID: <56AA02C0.4050901@dachary.org>
References: <56A9E13E.8050508@suse.de> <56A9E2EC.8040000@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:39060 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933991AbcA1MAN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 Jan 2016 07:00:13 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 1357547BD5C
	for <ceph-devel@vger.kernel.org>; Thu, 28 Jan 2016 13:00:10 +0100 (CET)
In-Reply-To: <56A9E2EC.8040000@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joshua Schmid <jschmid@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Joshua,

Is there an issue related to your changes in http://tracker.ceph.com/ o=
r would you like me to create one ?

Cheers

On 28/01/2016 16:44, Joshua Schmid wrote:
>=20
> Hi Sage,
>=20
> On 01/27/2016 03:26 PM, Sage Weil wrote:
>> We've had several partial starts to address this problem but haven't=
=20
>> gotten anything over the line.  A quick summary:
>>
>> 1- Currently we store dm-crypt keys in /etc/ceph/dmcrypt-keys/$osd_u=
uid,=20
>> on the boot disk.  This lets you throw away OSD disk but not boot di=
sks=20
>> and doesn't help you if someone walks away with a whole server.
>>
>> 2- SUSE had a pull request that made ceph-disk push/pull keys over (=
s)ftp. =20
>> I can't find it now.. did it get closed?
>=20
> It's here.
>=20
> https://github.com/SUSE/ceph/commit/0f5644ef3d1b1a9a14be97717b9d8dfe0=
338b74d
>=20
>>
>> I suggest we do something simple:
>>
>> 1- Update SUSE's ceph-disk changes to make it easy to plug in=20
>> different key management strategies.
>=20
> And there.
>=20
> https://github.com/SUSE/ceph/commit/127a47ca7cf28f387d832da265f6955bb=
04107c3
>=20
> SUSE currently sticks with this solution since its pluggable and work=
s
> fairly well. It may not be the cleanest solution to rely on an extern=
al
> tool(ftp) but until now there is simply no other option.
>=20
>>
>> 2- Implement a simple mon-based strategy upstream.  We've discussed =
this a=20
>> fair bit in the past, and were getting stuck on the problem of where=
 to=20
>> store the key-fetching-key.  I.e., we want a key on the disk that yo=
u use=20
>> to ask the monitor for the LUKS key, which you then provide to LUKS =
to=20
>> unlock the actual encryption key.  This means that we need a unencry=
pted=20
>> spot on the device to store it in.  Milan has indicated that putting=
 it in=20
>> a LUKS key slot would be a bad idea and difficult to maintain.  Inst=
ead, I=20
>> propose we create a new GPT partition type called OSD_LOCKBOX (or=20
>> similar), with a tiny filesystem and a few files indicating what to =
do. =20
>> This will make it easy to store the info we need for the mon scheme,=
 and=20
>> to support new key management approaches later (we can put whatever =
we=20
>> want there as long as it's not too big).
>=20
> Sounds good! But i still see the possible scenario where you dump a
> whole rack with a MON + OSD. As a potential attacker, having these tw=
o
> components would grant you access to all the keys needed to decrypt t=
he
> OSDdata. If I got understood it correctly that every MON should hold =
all
> available keys.
>=20
> Some additions:
>=20
> The MON should only hand out keys when authenticated or in a clean
> cluster context. So what i mean is basically some way to proof if the
> MON is not in a made up environment.
>=20
>=20
>>
>> I put some notes here:
>>
>> 	http://pad.ceph.com/p/osd-key-management
>>
>> Thoughts?
>> sage
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
