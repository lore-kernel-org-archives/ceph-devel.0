From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: ceph and ext4
Date: Mon, 14 Nov 2011 11:10:18 -0800
Message-ID: <CAF3hT9APJBfjqfkKd_r3-vydtC0B2EHx2aG1OGwipmF-B+mdZg@mail.gmail.com>
References: <4EC10664.1080501@tuxadero.com>
	<CAMvP8PAuBbG_hcgjD+WJGRFo=p59Um3HAAoRN5zjuRPWjsLh1A@mail.gmail.com>
	<4EC118A1.1030008@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:48343 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751817Ab1KNTKS convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Nov 2011 14:10:18 -0500
Received: by iage36 with SMTP id e36so7536747iag.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 Nov 2011 11:10:18 -0800 (PST)
In-Reply-To: <4EC118A1.1030008@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: Tomasz Paszkowski <ss7pro@gmail.com>, ceph-devel@vger.kernel.org

On Mon, Nov 14, 2011 at 5:33 AM, Martin Mailand <martin@tuxadero.com> w=
rote:
> Hi Tomasz,
> as far as I know it still has this limit.
> But it should be relatively safe to use it.
>
> http://marc.info/?l=3Dceph-devel&m=3D131942130322957&w=3D2
>
> If we hit the 4KB limit of xattrs in ext4 how does it show up in the =
rbd
> layer?
>
> How does it show up in the fs layer, would the fs still be clean?

Right now it would show up very badly, unfortunately. (And yes, the
limit is still there.) You'd notice, though you might manage to
corrupt some of your data first. :/

However, if you're not taking snapshots and you're not using xattrs
yourself, you won't hit it with rbd or the Ceph FS.
-Greg

>
> -martin
>
>
> Am 14.11.2011 14:09, schrieb Tomasz Paszkowski:
>>
>> what about limit on xattr size ? Is it still limited to 4KB ?
>>
>>
>>
>> On Mon, Nov 14, 2011 at 1:15 PM, Martin Mailand<martin@tuxadero.com>
>> =A0wrote:
>>>
>>> Hi Christian,
>>> I am not sure if you noticed, but your ext4 bug is fixed in mainlin=
e. I
>>> am
>>> running a ceph cluster with 40+ vms for over a week by now, without=
 any
>>> problems. An fsck.ext4 shows the ext4 is clean.
>>> The performance of ext4 is much better than btrfs, no rise in the l=
oad of
>>> the osd's.
>>>
>>> -martin
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>
>>
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
