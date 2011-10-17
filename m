From: Martin Mailand <martin@tuxadero.com>
Subject: Re: OSD blocked for more than 120 seconds
Date: Mon, 17 Oct 2011 13:49:25 +0200
Message-ID: <4E9C1645.3070205@tuxadero.com>
References: <4E974C87.2070204@tuxadero.com> <1318585099.2999.10.camel@wido-laptop> <CAO47_-8wOFxzjy-n2W_q75D=h7z8spswgghJ9iy8p6eQu-2kFA@mail.gmail.com> <4E99E68F.9090005@tuxadero.com> <CAO47_-9qWX5cq-Qh9Kajt68ZCyzyhdsU5XTZ8MXSTj-s8+_XzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from einhorn.in-berlin.de ([192.109.42.8]:48055 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab1JQLtl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 17 Oct 2011 07:49:41 -0400
In-Reply-To: <CAO47_-9qWX5cq-Qh9Kajt68ZCyzyhdsU5XTZ8MXSTj-s8+_XzA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: chb@muc.de
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org

Am 17.10.2011 11:40, schrieb Christian Brunner:
> 2011/10/15 Martin Mailand<martin@tuxadero.com>:
>> Hi Christian,
>> I have a very similar experience, I also used josef's tree and btrfs snaps =
>> 0, the next problem I had than was excessive fragmentation, so I  used this
>> patch http://marc.info/?l=linux-btrfs&m=131495014823121&w=2, and changed the
>> btrfs option to (btrfs options = noatime,nodatacow,autodefrag) that kept the
>> fragmentation under control.
>> But even with this setup after a few days the load on the osd is unbearable.
>
> How did you find out about our fragmentation issues? Was it just a
> performance problem?
>

I used filefrag to show the number of extents, after the patch, I have 
on average 1,14 extents per 4MB ceph object on the osd.

>> As far as I understood the doku if you disable the btrfs snapshot
>> functionality the writeahead journal is activated.
>> http://ceph.newdream.net/wiki/Ceph.conf
>> And I get this in the logs.
>> mount: enabling WRITEAHEAD journal mode: 'filestore btrfs snap' mode is not
>> enabled
>>
>> May I asked what kind of probs you did have with ext4? Because I am looking
>> into this direction as well.
>
> You can read about our ext4 problems here:
>
> http://marc.info/?l=ceph-devel&m=131201869703245&w=2

I still can reproduce the bug with v3.1-rc9.

>
> Our bugreport with RedHat didn't make any progress for a long time,
> but last week RedHat made two sugestions:
>
> - If you configure ceph with 'filestore flusher = false', do you see
> any different behavior?
> - If you mount with -o noauto_da_alloc does it change anything?
>
> Since I have just migrated to btrfs, I've some problems to check this,
> but I'll try to do this as soon as I can get hold of some extra
> hardware.
>
I can check this, I have a spare cluster at the moment.

> Regards,
> Christian

