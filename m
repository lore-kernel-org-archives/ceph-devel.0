From: Martin Mailand <martin@tuxadero.com>
Subject: Re: ceph and ext4
Date: Mon, 14 Nov 2011 20:40:38 +0100
Message-ID: <4EC16EB6.3060707@tuxadero.com>
References: <4EC10664.1080501@tuxadero.com>	<CAMvP8PAuBbG_hcgjD+WJGRFo=p59Um3HAAoRN5zjuRPWjsLh1A@mail.gmail.com>	<4EC118A1.1030008@tuxadero.com> <CAF3hT9APJBfjqfkKd_r3-vydtC0B2EHx2aG1OGwipmF-B+mdZg@mail.gmail.com>
Reply-To: martin@tuxadero.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:50417 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305Ab1KNTkt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 14:40:49 -0500
In-Reply-To: <CAF3hT9APJBfjqfkKd_r3-vydtC0B2EHx2aG1OGwipmF-B+mdZg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: Tomasz Paszkowski <ss7pro@gmail.com>, ceph-devel@vger.kernel.org

Hi Gregory,
this is quite bad, so ext4 is still no alternative as a backend fs.

-martin

Gregory Farnum schrieb:
> On Mon, Nov 14, 2011 at 5:33 AM, Martin Mailand <martin@tuxadero.com> wrote:
>> Hi Tomasz,
>> as far as I know it still has this limit.
>> But it should be relatively safe to use it.
>>
>> http://marc.info/?l=ceph-devel&m=131942130322957&w=2
>>
>> If we hit the 4KB limit of xattrs in ext4 how does it show up in the rbd
>> layer?
>>
>> How does it show up in the fs layer, would the fs still be clean?
> 
> Right now it would show up very badly, unfortunately. (And yes, the
> limit is still there.) You'd notice, though you might manage to
> corrupt some of your data first. :/
> 
> However, if you're not taking snapshots and you're not using xattrs
> yourself, you won't hit it with rbd or the Ceph FS.
> -Greg
> 
>> -martin
>>
>>
>> Am 14.11.2011 14:09, schrieb Tomasz Paszkowski:
>>> what about limit on xattr size ? Is it still limited to 4KB ?
>>>
>>>
>>>
>>> On Mon, Nov 14, 2011 at 1:15 PM, Martin Mailand<martin@tuxadero.com>
>>>  wrote:
>>>> Hi Christian,
>>>> I am not sure if you noticed, but your ext4 bug is fixed in mainline. I
>>>> am
>>>> running a ceph cluster with 40+ vms for over a week by now, without any
>>>> problems. An fsck.ext4 shows the ext4 is clean.
>>>> The performance of ext4 is much better than btrfs, no rise in the load of
>>>> the osd's.
>>>>
>>>> -martin
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
