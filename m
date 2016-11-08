From: Dong Wu <archer.wudong@gmail.com>
Subject: Fwd: [ceph-users] Hammer OSD memory increase when add new machine
Date: Tue, 8 Nov 2016 11:17:32 +0800
Message-ID: <CAAL-TMdf-8Q9nd1px+VqFeQtVjg=vX6or4Xv0X3YW=-OzkNKgQ@mail.gmail.com>
References: <CAAL-TMfWddz2x7GzTghoJzp=_=d-OwtVa7fxvt8aD-rFCUqiWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35513 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750786AbcKHDRe (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Nov 2016 22:17:34 -0500
Received: by mail-vk0-f49.google.com with SMTP id w194so138334675vkw.2
        for <ceph-devel@vger.kernel.org>; Mon, 07 Nov 2016 19:17:33 -0800 (PST)
In-Reply-To: <CAAL-TMfWddz2x7GzTghoJzp=_=d-OwtVa7fxvt8aD-rFCUqiWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-users <ceph-users@lists.ceph.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

any sugesstions?

Thanks.


---------- Forwarded message ----------
From: Dong Wu <archer.wudong@gmail.com>
Date: 2016-10-27 18:50 GMT+08:00
Subject: Re: [ceph-users] Hammer OSD memory increase when add new machine
To: huang jun <hjwsm1989@gmail.com>
=E6=8A=84=E9=80=81=EF=BC=9A ceph-users <ceph-users@lists.ceph.com>


2016-10-27 17:50 GMT+08:00 huang jun <hjwsm1989@gmail.com>:
> how do you add the new machine ?
> does it first added to default ruleset and then you add the new rule
> for this group?
> do you have data pool use the default rule, does these pool contain data?

we dont use default ruleset, when we add new group machine,
crush_location auto generate root and chassis, then we add a new rule
for this group.


> 2016-10-27 17:34 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
>> Hi all,
>>
>> We have a ceph cluster only use rbd. The cluster contains several
>> group machines, each group contains several machines, then each
>> machine has 12 SSDs, each ssd as an OSD (journal and data together).
>> eg:
>> group1: machine1~machine12
>> group2: machine13~machine24
>> ......
>> each group is separated with other group, which means each group has
>> separated pools.
>>
>> we use Hammer(0.94.6) compiled with jemalloc(4.2).
>>
>> We have found that when we add a new group machine, the other group
>> machine's memory increase 5% more or less (OSDs usage).
>>
>> each group's data is separated with others, so backfill only in group,
>> not across.
>> Why add a group of machine cause others memory increase? Is this reasona=
ble?
>>
>> _______________________________________________
>> ceph-users mailing list
>> ceph-users@lists.ceph.com
>> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>>
>
>
>
> --
> Thank you!
> HuangJun
