From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: Re: [ceph-users] Bluestore: inaccurate disk usage statistics problem?
Date: Wed, 27 Dec 2017 10:59:56 +0800
Message-ID: <CAGkCoN+M=YdB8VRroNQLo8jmBmuMFuHdte2zxGi386xp20ZmcA@mail.gmail.com>
References: <CAGkCoNLOPOKX3iO1QOTp4wyUN7=q-7VuamBxYyC9t9kvtTV-=g@mail.gmail.com>
 <alpine.DEB.2.11.1712261717190.14302@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pf0-f179.google.com ([209.85.192.179]:37330 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751163AbdL0DAi (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Dec 2017 22:00:38 -0500
Received: by mail-pf0-f179.google.com with SMTP id n6so19335314pfa.4
        for <ceph-devel@vger.kernel.org>; Tue, 26 Dec 2017 19:00:37 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1712261717190.14302@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi Sage,

Thanks for the quick reply. I read the code and our test also proved
that disk space was wasted due to min_alloc_size.

Very look forward to the "inline" data feature for small objects. We
will also look into this feature and hopefully work with community on
it.

Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com


On Wed, Dec 27, 2017 at 6:36 AM, Sage Weil <sage@newdream.net> wrote:
> On Tue, 26 Dec 2017, Zhi Zhang wrote:
>> Hi,
>>
>> We recently started to test bluestore with huge amount of small files
>> (only dozens of bytes per file). We have 22 OSDs in a test cluster
>> using ceph-12.2.1 with 2 replicas and each OSD disk is 2TB size. After
>> we wrote about 150 million files through cephfs, we found each OSD
>> disk usage reported by "ceph osd df" was more than 40%, which meant
>> more than 800GB was used for each disk, but the actual total file size
>> was only about 5.2 GB, which was reported by "ceph df" and also
>> calculated by ourselves.
>>
>> The test is ongoing. I wonder whether the cluster would report OSD
>> full after we wrote about 300 million files, however the actual total
>> file size would be far far less than the disk usage. I will update the
>> result when the test is done.
>>
>> My question is, whether the disk usage statistics in bluestore is
>> inaccurate, or the padding, alignment stuff or something else in
>> bluestore wastes the disk space?
>
> Bluestore isn't making any attempt to optimize for small files, so a
> one byte file will consume min_alloc_size (64kb on HDD, 16kb on SSD,
> IIRC).
>
> It probably wouldn't be too difficult to add an "inline" data for small
> objects feature that puts small objects in rocksdb...
>
> sage
>
>>
>> Thanks!
>>
>> $ ceph osd df
>> ID CLASS WEIGHT  REWEIGHT SIZE   USE    AVAIL  %USE  VAR  PGS
>>  0   hdd 1.49728  1.00000  1862G   853G  1009G 45.82 1.00 110
>>  1   hdd 1.69193  1.00000  1862G   807G  1054G 43.37 0.94 105
>>  2   hdd 1.81929  1.00000  1862G   811G  1051G 43.57 0.95 116
>>  3   hdd 2.00700  1.00000  1862G   839G  1023G 45.04 0.98 122
>>  4   hdd 2.06334  1.00000  1862G   886G   976G 47.58 1.03 130
>>  5   hdd 1.99051  1.00000  1862G   856G  1006G 45.95 1.00 118
>>  6   hdd 1.67519  1.00000  1862G   881G   981G 47.32 1.03 114
>>  7   hdd 1.81929  1.00000  1862G   874G   988G 46.94 1.02 120
>>  8   hdd 2.08881  1.00000  1862G   885G   976G 47.56 1.03 130
>>  9   hdd 1.64265  1.00000  1862G   852G  1010G 45.78 0.99 106
>> 10   hdd 1.81929  1.00000  1862G   873G   989G 46.88 1.02 109
>> 11   hdd 2.20041  1.00000  1862G   915G   947G 49.13 1.07 131
>> 12   hdd 1.45694  1.00000  1862G   874G   988G 46.94 1.02 110
>> 13   hdd 2.03847  1.00000  1862G   821G  1041G 44.08 0.96 113
>> 14   hdd 1.53812  1.00000  1862G   810G  1052G 43.50 0.95 112
>> 15   hdd 1.52914  1.00000  1862G   874G   988G 46.94 1.02 111
>> 16   hdd 1.99176  1.00000  1862G   810G  1052G 43.51 0.95 114
>> 17   hdd 1.81929  1.00000  1862G   841G  1021G 45.16 0.98 119
>> 18   hdd 1.70901  1.00000  1862G   831G  1031G 44.61 0.97 113
>> 19   hdd 1.67519  1.00000  1862G   875G   987G 47.02 1.02 115
>> 20   hdd 2.03847  1.00000  1862G   864G   998G 46.39 1.01 115
>> 21   hdd 2.18794  1.00000  1862G   920G   942G 49.39 1.07 127
>>                     TOTAL 40984G 18861G 22122G 46.02
>>
>> $ ceph df
>> GLOBAL:
>>     SIZE       AVAIL      RAW USED     %RAW USED
>>     40984G     22122G       18861G         46.02
>> POOLS:
>>     NAME                ID     USED      %USED     MAX AVAIL     OBJECTS
>>     cephfs_metadata     5       160M         0         6964G         77342
>>     cephfs_data         6      5193M      0.04         6964G     151292669
>>
>>
>> Regards,
>> Zhi Zhang (David)
>> Contact: zhang.david2011@gmail.com
>>               zhangz.david@outlook.com
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>>
