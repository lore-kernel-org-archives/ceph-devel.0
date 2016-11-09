From: Dong Wu <archer.wudong@gmail.com>
Subject: Re: Fwd: [ceph-users] Hammer OSD memory increase when add new machine
Date: Wed, 9 Nov 2016 13:52:01 +0800
Message-ID: <CAAL-TMfrg3Ry1qifc4juqHasMjrYsPUFPRgS4nDG41-pPyNa2w@mail.gmail.com>
References: <CALMEbCLNVTAsyCJUQXr7EgqLtW7gZmgNsSpYAWF29GYwVUrEXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f44.google.com ([209.85.213.44]:35094 "EHLO
        mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbcKIFwD (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 00:52:03 -0500
Received: by mail-vk0-f44.google.com with SMTP id w194so167692082vkw.2
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 21:52:02 -0800 (PST)
In-Reply-To: <CALMEbCLNVTAsyCJUQXr7EgqLtW7gZmgNsSpYAWF29GYwVUrEXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: zphj1987 <zphj1987@gmail.com>, Sage Weil <sage@newdream.net>, ceph-users <ceph-users@lists.ceph.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

Thanks, though CERN 30PB cluster test, the osdmap caches causes memory
increase, I'll test how these configs( osd_map_cache_size,
osd_map_max_advance, etc.) influence the memory usage.

2016-11-08 22:48 GMT+08:00 zphj1987 <zphj1987@gmail.com>:
> I  remember CERN had a test ceph cluster 30PB  and the osd use more memer=
y
> than usual   ,and thay tune osdmap_epochs ,if it is the osdmap make it us=
e
> more memery,ithink  you may have a test use less osdmap_epochs to see if
> have some change
>
> default mon_min_osdmap_epochs is 500
>
>
> zphj1987
>
> 2016-11-08 22:08 GMT+08:00 Sage Weil <sage@newdream.net>:
>>
>> > ---------- Forwarded message ----------
>> > From: Dong Wu <archer.wudong@gmail.com>
>> > Date: 2016-10-27 18:50 GMT+08:00
>> > Subject: Re: [ceph-users] Hammer OSD memory increase when add new
>> > machine
>> > To: huang jun <hjwsm1989@gmail.com>
>> > =E6=8A=84=E9=80=81=EF=BC=9A ceph-users <ceph-users@lists.ceph.com>
>> >
>> >
>> > 2016-10-27 17:50 GMT+08:00 huang jun <hjwsm1989@gmail.com>:
>> > > how do you add the new machine ?
>> > > does it first added to default ruleset and then you add the new rule
>> > > for this group?
>> > > do you have data pool use the default rule, does these pool contain
>> > > data?
>> >
>> > we dont use default ruleset, when we add new group machine,
>> > crush_location auto generate root and chassis, then we add a new rule
>> > for this group.
>> >
>> >
>> > > 2016-10-27 17:34 GMT+08:00 Dong Wu <archer.wudong@gmail.com>:
>> > >> Hi all,
>> > >>
>> > >> We have a ceph cluster only use rbd. The cluster contains several
>> > >> group machines, each group contains several machines, then each
>> > >> machine has 12 SSDs, each ssd as an OSD (journal and data together)=
.
>> > >> eg:
>> > >> group1: machine1~machine12
>> > >> group2: machine13~machine24
>> > >> ......
>> > >> each group is separated with other group, which means each group ha=
s
>> > >> separated pools.
>> > >>
>> > >> we use Hammer(0.94.6) compiled with jemalloc(4.2).
>> > >>
>> > >> We have found that when we add a new group machine, the other group
>> > >> machine's memory increase 5% more or less (OSDs usage).
>> > >>
>> > >> each group's data is separated with others, so backfill only in
>> > >> group,
>> > >> not across.
>> > >> Why add a group of machine cause others memory increase? Is this
>> > >> reasonable?
>>
>> It could be cached OSDmaps (they get slightly larger when you add OSDs)
>> but it's hard to say.  It seems more likely that the pools and crush rul=
es
>> aren't configured right and you're adding OSDs to the wrong group.
>>
>> If you look at the 'ceph daemon osd.NNN perf dump' output you can see,
>> among other things, how many PGs are on the OSD.  Can you capture the
>> output before and after the change (and 5% memory footprint increase)?
>>
>> sage
>
>
