From: huang jun <hjwsm1989@gmail.com>
Subject: Re: How to improve erasure pool's delete performance
Date: Sun, 3 Apr 2016 23:22:25 +0800
Message-ID: <CABAwU-bbnYJPJxA7Za8b4w9Nv7Z6_678QCkPrk5_xNnqUGr_pA@mail.gmail.com>
References: <CABAwU-a1kxbc=i564da=GAj11_5M-tKE6R2kP5vaX7Ga2F3g=w@mail.gmail.com>
	<alpine.DEB.2.11.1604030906170.19675@cpach.fuggernut.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f177.google.com ([209.85.217.177]:36401 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751393AbcDCPW1 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Apr 2016 11:22:27 -0400
Received: by mail-lb0-f177.google.com with SMTP id qe11so125984712lbc.3
        for <ceph-devel@vger.kernel.org>; Sun, 03 Apr 2016 08:22:26 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1604030906170.19675@cpach.fuggernut.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

yeah, bluestore is the best solution, the rename operation almost done
in memory, so it's fast.


2016-04-03 21:07 GMT+08:00 Sage Weil <sage@newdream.net>:
> On Sun, 3 Apr 2016, huang jun wrote:
>> Hi, all
>> Recently, we test deletion performance of erasure pool, and we found
>> the delete op
>> is pretty slow.
>> We trace the code and found Delete op was converted to Rename in Fil=
estore,
>> It was implemented in function FileStore::_collection_move_rename(),
>> it calls FileStore::_set_replay_guard function and
>> FileStore::_close_replay_guard function,
>> in these 2 function, do 3 fsyncs and 1 objectmap sync, which we thin=
k
>> spend the most time.
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> Envirnoment:
>> ceph version: 0.94.5
>> linux kernel: 3.18
>> Test cluster: 1MON, 1MDS, 4OSD
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> We do some comparison tests:
>> 1. sync omap + fd=EF=BC=88default)
>> avg rename op used 0.883818s
>> 2. only sync omap: 0.428431s
>> 3. only sync fd: 0.400266s
>> 4. dont sync: 0.00319648
>> 5. do posix_fadvise(FADVISE_DONTNEED) after write, and sync omap + f=
d: 0.855178s
>> 6. use fdatasync to replace fsync, and sync omap + fd : 0.432659s
>>
>> As we can see, sync fd and sync objectmap use 50% of the total time =
each.
>> Compare 1 with 6, fdatasync uses 50% less time compared to fdatasync=
,
>> which means sync metadata spent more time than sync data.
>> In FileStore::_set_replay_guard function and
>> FileStore::_close_replay_guard function,
>> it only set object's user.cephos.seq xattr, then do sync to let it d=
urable.
>>
>> I have some questions:
>> 1. Do we record the xattr(user.cephos.seq) to avoid replaying an old=
er
>> transaction?
>
> Yes, exactly.
>
>> 2. If dont do sync, we will get the best performance, is there any
>> side effects? like: get data corrupted.
>
> Yes--we may replay incorrectly after a failure.  Unfortunately, not a=
n
> option.
>
> This problem goes away with BlueStore, so we only have to live with i=
t
> for a bit longer.  I don't think it's worth investing any effort into
> addressing this with FileStore--we'll be unlikely to want to merge an=
y
> non-trivial change anyway.
>
> sage



--=20
thanks
huangjun
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
