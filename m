From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] libceph: fix a use after free issue in osdmap_set_max_osd
Date: Wed, 10 Sep 2014 13:30:20 +0400
Message-ID: <CALFYKtA6YDbn87X=5RLe7YoLdwh0VSwzBMug_bbBC7rN=jh4+g@mail.gmail.com>
References: <1410084652-23031-1-git-send-email-roy.qing.li@gmail.com>
	<CALFYKtAEihrOd0WEiNk3iA9ev4EXEuTfAEAQYgveSHPeF7Jifg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:38134 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbaIJJaV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 05:30:21 -0400
Received: by mail-qa0-f46.google.com with SMTP id k15so63019qaq.33
        for <ceph-devel@vger.kernel.org>; Wed, 10 Sep 2014 02:30:20 -0700 (PDT)
In-Reply-To: <CALFYKtAEihrOd0WEiNk3iA9ev4EXEuTfAEAQYgveSHPeF7Jifg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: roy.qing.li@gmail.com
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Sun, Sep 7, 2014 at 6:27 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> On Sun, Sep 7, 2014 at 2:10 PM,  <roy.qing.li@gmail.com> wrote:
>> From: Li RongQing <roy.qing.li@gmail.com>
>>
>> If the state variable is krealloced successfully, map->osd_state will be
>> freed, once following two reallocation failed, and exit the function
>> without resetting map->osd_state, map->osd_state become a wild pointer.
>>
>> fix it by resetting them after krealloc successfully.
>>
>> Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
>> ---
>>  net/ceph/osdmap.c |   20 ++++++++++----------
>>  1 file changed, 10 insertions(+), 10 deletions(-)
>>
>> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
>> index c547e46..81e9c66 100644
>> --- a/net/ceph/osdmap.c
>> +++ b/net/ceph/osdmap.c
>> @@ -671,15 +671,19 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
>>         int i;
>>
>>         state = krealloc(map->osd_state, max*sizeof(*state), GFP_NOFS);
>> +       if (!state)
>> +               return -ENOMEM;
>> +       map->osd_state = state;
>> +
>>         weight = krealloc(map->osd_weight, max*sizeof(*weight), GFP_NOFS);
>> -       addr = krealloc(map->osd_addr, max*sizeof(*addr), GFP_NOFS);
>> -       if (!state || !weight || !addr) {
>> -               kfree(state);
>> -               kfree(weight);
>> -               kfree(addr);
>> +       if (!weight)
>> +               return -ENOMEM;
>> +       map->osd_weight = weight;
>>
>> +       addr = krealloc(map->osd_addr, max*sizeof(*addr), GFP_NOFS);
>> +       if (!addr)
>>                 return -ENOMEM;
>> -       }
>> +       map->osd_addr = addr;
>>
>>         for (i = map->max_osd; i < max; i++) {
>>                 state[i] = 0;
>> @@ -687,10 +691,6 @@ static int osdmap_set_max_osd(struct ceph_osdmap *map, int max)
>>                 memset(addr + i, 0, sizeof(*addr));
>>         }
>>
>> -       map->osd_state = state;
>> -       map->osd_weight = weight;
>> -       map->osd_addr = addr;
>> -
>>         if (map->osd_primary_affinity) {
>>                 u32 *affinity;
>>
>> --
>> 1.7.10.4
>
> Looks good.  I'll apply it tomorrow.

Pushed a branch with your patch.  Minor modifications: use map->*
instead of local variables for initialization and change primary
affinity case so it fits in.  You can take a look at

https://github.com/ceph/ceph-client/commit/790415a024871a2100388ce4b3d485756fb90865

Thanks,

                Ilya
