From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: Improving Data-At-Rest encryption in Ceph
Date: Mon, 14 Dec 2015 14:32:33 -0800
Message-ID: <CAJ4mKGZmS3ThQcR3dZXoV3c3Kz1qRoHDRH=iSB6AUyKR1bwrPA@mail.gmail.com>
References: <CA+H5UW3DXVm2cQQe5Faw5moeD8jbb9Or5PiN4YJX54Axr-qKYQ@mail.gmail.com>
	<CAJ4mKGZP3oHt6Rgsp_pogcAZEmBzcQzDc4vzESDjPyoxJKoBUw@mail.gmail.com>
	<1450130526.1035.24.camel@millnert.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33119 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932764AbbLNWcf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Dec 2015 17:32:35 -0500
Received: by mail-wm0-f52.google.com with SMTP id n186so68713136wmn.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Dec 2015 14:32:34 -0800 (PST)
In-Reply-To: <1450130526.1035.24.camel@millnert.se>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Millnert <martin@millnert.se>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>, Adam Kupczyk <akupczyk@mirantis.com>

On Mon, Dec 14, 2015 at 2:02 PM, Martin Millnert <martin@millnert.se> w=
rote:
> On Mon, 2015-12-14 at 12:28 -0800, Gregory Farnum wrote:
>> On Mon, Dec 14, 2015 at 5:17 AM, Radoslaw Zarzynski
> <snip>
>> > In typical case ciphertext data transferred from OSD to OSD can be
>> > used without change. This is when both OSDs have the same crypto k=
ey
>> > version for given placement group. In rare cases when crypto keys =
are
>> > different (key change or transition period) receiving OSD will rec=
rypt
>> > with local key versions.
>>
>> I don't understand this part at all. Do you plan to read and rewrite
>> the entire PG whenever you change the "key version"? How often do yo=
u
>> plan to change these keys? What is even the point of changing them,
>> since anybody who can control an OSD can grab the entire current key
>> set?
>
> You may have leaked keys without having leaked ciphertext.
> The typical use case for FDE/SED is IMO being able to RMA drives.
> Nothing more than that.

Yeah, but you necessarily need to let people keep using the old key
*and* give them the new one on-demand if they've got access to the
system, in order to allow switching to the new key. You need to wait
for all the data to actually be rewritten with the new key before you
can consider it secure again, and that'll take a loooong time. I'm not
saying there isn't threat mitigation here, just that I'm not sure it's
useful against somebody who's already obtained access to your
encryption keys =E2=80=94 if they've gotten those it's unlikely they wo=
n't
have gotten OSD keys as well, and if they've got network access they
can impersonate an OSD and get access to whatever data they like.

I guess that still protects against an external database hack from
somebody who gets access to your old hard drives, but...*shrug*

>
>> > For compression to be effective it must be done before encryption.=
 Due
>> > to that encryption may be applied differently for replication pool=
s
>> > and EC pools. Replicated pools do not implement compression; for t=
hose
>> > pools encryption is applied right after data enters OSD. For EC po=
ols
>> > encryption is applied after compressing. When compression will be
>> > implemented for replicated pools, it must be placed before encrypt=
ion.
>>
>> So this means you'll be encrypting the object data, but not the omap
>> nor xattrs, and not the file names on disk. Is that acceptable to
>> people? It's probably fine for a lot of rbd use cases, but not for
>> RGW, CephFS, nor raw RADOS where meaningful metadata (and even *data=
*)
>> is stored in those regions. I'd rather a solution worked on the full
>> data set. :/
>> -Greg
>
> This is indeed the largest weakness of the proposal.
>
> I'm lacking a bit on the motivation for what problem this solution
> solves that a dm-crypt-based solution doesn't address? When, except f=
or
> snooping, is it a desired design to not encrypt all the things?
>
> I guess one could say: "ciphertext would be transferred on the networ=
k".
> But, it's incomplete. Internal transport encryption (and better auth)
> for Ceph is a different problem.
>
> I'd probably rather dm-crypt key management processes were refined an=
d
> improved (saying this without knowing the state of any current
> implementations for Ceph), and have a solid FDE solution than a solut=
ion
> that doesn't encrypt metadata. Only encrypting data but not metadata
> isn't sufficient anymore...

Yeah, I'd rather see dm-crypt get done well rather than in-Ceph
encryption like this. If we want to protect data I think that's a lot
more secure (and will *stay* that way since encryption is all that
project does), and adding TLS or similar to the messenger code would
give us on-the-wire protection from the clients to the disk.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
