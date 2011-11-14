From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Fwd: ceph and ext4
Date: Mon, 14 Nov 2011 11:54:11 -0800
Message-ID: <CAF3hT9B=C1zN6y9zGgFZe4ZDy9-g9Fh04Abyf4F=KVD8rd=vZw@mail.gmail.com>
References: <4EC10664.1080501@tuxadero.com>
	<CAMvP8PAuBbG_hcgjD+WJGRFo=p59Um3HAAoRN5zjuRPWjsLh1A@mail.gmail.com>
	<4EC118A1.1030008@tuxadero.com>
	<CAF3hT9APJBfjqfkKd_r3-vydtC0B2EHx2aG1OGwipmF-B+mdZg@mail.gmail.com>
	<4EC16EB6.3060707@tuxadero.com>
	<CAF3hT9DbnQLJb5YPZJ15ekt5JWZLwyoMymm2x=s9V64kw5qKWQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:40221 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754081Ab1KNTyM convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 14:54:12 -0500
Received: by iage36 with SMTP id e36so7575723iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 11:54:11 -0800 (PST)
In-Reply-To: <CAF3hT9DbnQLJb5YPZJ15ekt5JWZLwyoMymm2x=s9V64kw5qKWQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Sorry, missed adding the list.


---------- Forwarded message ----------
=46rom: Gregory Farnum <gregory.farnum@dreamhost.com>
Date: Mon, Nov 14, 2011 at 11:53 AM
Subject: Re: ceph and ext4
To: martin@tuxadero.com


Yeah, I think we'll be working on it in the next couple of months, but
right now we're recommending xfs if you can't do btrfs.

On Mon, Nov 14, 2011 at 11:40 AM, Martin Mailand <martin@tuxadero.com> =
wrote:
> Hi Gregory,
> this is quite bad, so ext4 is still no alternative as a backend fs.
>
> -martin
>
> Gregory Farnum schrieb:
>>
>> On Mon, Nov 14, 2011 at 5:33 AM, Martin Mailand <martin@tuxadero.com=
>
>> wrote:
>>>
>>> Hi Tomasz,
>>> as far as I know it still has this limit.
>>> But it should be relatively safe to use it.
>>>
>>> http://marc.info/?l=3Dceph-devel&m=3D131942130322957&w=3D2
>>>
>>> If we hit the 4KB limit of xattrs in ext4 how does it show up in th=
e rbd
>>> layer?
>>>
>>> How does it show up in the fs layer, would the fs still be clean?
>>
>> Right now it would show up very badly, unfortunately. (And yes, the
>> limit is still there.) You'd notice, though you might manage to
>> corrupt some of your data first. :/
>>
>> However, if you're not taking snapshots and you're not using xattrs
>> yourself, you won't hit it with rbd or the Ceph FS.
>> -Greg
>>
>>> -martin
>>>
>>>
>>> Am 14.11.2011 14:09, schrieb Tomasz Paszkowski:
>>>>
>>>> what about limit on xattr size ? Is it still limited to 4KB ?
>>>>
>>>>
>>>>
>>>> On Mon, Nov 14, 2011 at 1:15 PM, Martin Mailand<martin@tuxadero.co=
m>
>>>> =A0wrote:
>>>>>
>>>>> Hi Christian,
>>>>> I am not sure if you noticed, but your ext4 bug is fixed in mainl=
ine. I
>>>>> am
>>>>> running a ceph cluster with 40+ vms for over a week by now, witho=
ut any
>>>>> problems. An fsck.ext4 shows the ext4 is clean.
>>>>> The performance of ext4 is much better than btrfs, no rise in the=
 load
>>>>> of
>>>>> the osd's.
>>>>>
>>>>> -martin
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel"
>>>>> in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.h=
tml
>>>>>
>>>>
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
