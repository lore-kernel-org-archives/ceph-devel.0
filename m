From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: OSD blocked for more than 120 seconds
Date: Mon, 17 Oct 2011 14:05:55 +0200
Message-ID: <CAMvP8PC9j1V20HR1a1mTWVJKT+cbsbAHiigz+2XwBGm14dU7mw@mail.gmail.com>
References: <4E974C87.2070204@tuxadero.com> <1318585099.2999.10.camel@wido-laptop>
 <CAO47_-8wOFxzjy-n2W_q75D=h7z8spswgghJ9iy8p6eQu-2kFA@mail.gmail.com>
 <4E99E68F.9090005@tuxadero.com> <CAO47_-9qWX5cq-Qh9Kajt68ZCyzyhdsU5XTZ8MXSTj-s8+_XzA@mail.gmail.com>
 <4E9C1645.3070205@tuxadero.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:61142 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751442Ab1JQMGP convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 08:06:15 -0400
Received: by pzk36 with SMTP id 36so5288591pzk.1
        for <ceph-devel@vger.kernel.org>; Mon, 17 Oct 2011 05:06:15 -0700 (PDT)
In-Reply-To: <4E9C1645.3070205@tuxadero.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Mailand <martin@tuxadero.com>
Cc: chb@muc.de, Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Hi,

It seems that ext4 and btrfs are not to be considered as stable for
now. Does anyone could confirm that
ext3 is the best choice for this moment ?

On 17 October 2011 13:49, Martin Mailand <martin@tuxadero.com> wrote:
> Am 17.10.2011 11:40, schrieb Christian Brunner:
>>
>> 2011/10/15 Martin Mailand<martin@tuxadero.com>:
>>>
>>> Hi Christian,
>>> I have a very similar experience, I also used josef's tree and btrf=
s
>>> snaps =3D
>>> 0, the next problem I had than was excessive fragmentation, so I =A0=
used
>>> this
>>> patch http://marc.info/?l=3Dlinux-btrfs&m=3D131495014823121&w=3D2, =
and changed
>>> the
>>> btrfs option to (btrfs options =3D noatime,nodatacow,autodefrag) th=
at kept
>>> the
>>> fragmentation under control.
>>> But even with this setup after a few days the load on the osd is
>>> unbearable.
>>
>> How did you find out about our fragmentation issues? Was it just a
>> performance problem?
>>
>
> I used filefrag to show the number of extents, after the patch, I hav=
e on
> average 1,14 extents per 4MB ceph object on the osd.
>
>>> As far as I understood the doku if you disable the btrfs snapshot
>>> functionality the writeahead journal is activated.
>>> http://ceph.newdream.net/wiki/Ceph.conf
>>> And I get this in the logs.
>>> mount: enabling WRITEAHEAD journal mode: 'filestore btrfs snap' mod=
e is
>>> not
>>> enabled
>>>
>>> May I asked what kind of probs you did have with ext4? Because I am
>>> looking
>>> into this direction as well.
>>
>> You can read about our ext4 problems here:
>>
>> http://marc.info/?l=3Dceph-devel&m=3D131201869703245&w=3D2
>
> I still can reproduce the bug with v3.1-rc9.
>
>>
>> Our bugreport with RedHat didn't make any progress for a long time,
>> but last week RedHat made two sugestions:
>>
>> - If you configure ceph with 'filestore flusher =3D false', do you s=
ee
>> any different behavior?
>> - If you mount with -o noauto_da_alloc does it change anything?
>>
>> Since I have just migrated to btrfs, I've some problems to check thi=
s,
>> but I'll try to do this as soon as I can get hold of some extra
>> hardware.
>>
> I can check this, I have a spare cluster at the moment.
>
>> Regards,
>> Christian
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>



--=20
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
