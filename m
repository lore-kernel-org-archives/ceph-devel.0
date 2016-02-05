From: Loic Dachary <loic@dachary.org>
Subject: Re: Fwd: Re: osd dm-crypt key management, part... deux?
Date: Fri, 5 Feb 2016 17:13:20 +0700
Message-ID: <56B475C0.40305@dachary.org>
References: <56A9E13E.8050508@suse.de> <56A9E2EC.8040000@suse.de>
 <56AA02C0.4050901@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42355 "EHLO
	relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbcBEKNb (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Feb 2016 05:13:31 -0500
In-Reply-To: <56AA02C0.4050901@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Joshua Schmid <jschmid@suse.de>, Ceph Development <ceph-devel@vger.kernel.org>

I'll go ahead and create one then ;-)

On 28/01/2016 19:00, Loic Dachary wrote:
> Hi Joshua,
>=20
> Is there an issue related to your changes in http://tracker.ceph.com/=
 or would you like me to create one ?
>=20
> Cheers
>=20
> On 28/01/2016 16:44, Joshua Schmid wrote:
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
>>
>> SUSE currently sticks with this solution since its pluggable and wor=
ks
>> fairly well. It may not be the cleanest solution to rely on an exter=
nal
>> tool(ftp) but until now there is simply no other option.
>>
>>>
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
>>
>> Some additions:
>>
>> The MON should only hand out keys when authenticated or in a clean
>> cluster context. So what i mean is basically some way to proof if th=
e
>> MON is not in a made up environment.
>>
>>
>>>
>>> I put some notes here:
>>>
>>> 	http://pad.ceph.com/p/osd-key-management
>>>
>>> Thoughts?
>>> sage
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
