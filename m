From: Joshua Schmid <jschmid@suse.de>
Subject: Fwd: Re: osd dm-crypt key management, part... deux?
Date: Thu, 28 Jan 2016 10:44:12 +0100
Message-ID: <56A9E2EC.8040000@suse.de>
References: <56A9E13E.8050508@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39136 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751488AbcA1Jiu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 28 Jan 2016 04:38:50 -0500
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 3E042ADCC
	for <ceph-devel@vger.kernel.org>; Thu, 28 Jan 2016 09:38:49 +0000 (UTC)
In-Reply-To: <56A9E13E.8050508@suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>


Hi Sage,

On 01/27/2016 03:26 PM, Sage Weil wrote:
> We've had several partial starts to address this problem but haven't=20
> gotten anything over the line.  A quick summary:
>=20
> 1- Currently we store dm-crypt keys in /etc/ceph/dmcrypt-keys/$osd_uu=
id,=20
> on the boot disk.  This lets you throw away OSD disk but not boot dis=
ks=20
> and doesn't help you if someone walks away with a whole server.
>=20
> 2- SUSE had a pull request that made ceph-disk push/pull keys over (s=
)ftp. =20
> I can't find it now.. did it get closed?

It's here.

https://github.com/SUSE/ceph/commit/0f5644ef3d1b1a9a14be97717b9d8dfe033=
8b74d

>=20
> I suggest we do something simple:
>=20
> 1- Update SUSE's ceph-disk changes to make it easy to plug in=20
> different key management strategies.

And there.

https://github.com/SUSE/ceph/commit/127a47ca7cf28f387d832da265f6955bb04=
107c3

SUSE currently sticks with this solution since its pluggable and works
fairly well. It may not be the cleanest solution to rely on an external
tool(ftp) but until now there is simply no other option.

>=20
> 2- Implement a simple mon-based strategy upstream.  We've discussed t=
his a=20
> fair bit in the past, and were getting stuck on the problem of where =
to=20
> store the key-fetching-key.  I.e., we want a key on the disk that you=
 use=20
> to ask the monitor for the LUKS key, which you then provide to LUKS t=
o=20
> unlock the actual encryption key.  This means that we need a unencryp=
ted=20
> spot on the device to store it in.  Milan has indicated that putting =
it in=20
> a LUKS key slot would be a bad idea and difficult to maintain.  Inste=
ad, I=20
> propose we create a new GPT partition type called OSD_LOCKBOX (or=20
> similar), with a tiny filesystem and a few files indicating what to d=
o. =20
> This will make it easy to store the info we need for the mon scheme, =
and=20
> to support new key management approaches later (we can put whatever w=
e=20
> want there as long as it's not too big).

Sounds good! But i still see the possible scenario where you dump a
whole rack with a MON + OSD. As a potential attacker, having these two
components would grant you access to all the keys needed to decrypt the
OSDdata. If I got understood it correctly that every MON should hold al=
l
available keys.

Some additions:

The MON should only hand out keys when authenticated or in a clean
cluster context. So what i mean is basically some way to proof if the
MON is not in a made up environment.


>=20
> I put some notes here:
>=20
> 	http://pad.ceph.com/p/osd-key-management
>=20
> Thoughts?
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
