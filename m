From: Blair Bethwaite <blair.bethwaite@gmail.com>
Subject: Re: un-even data filled on OSDs
Date: Fri, 10 Jun 2016 12:10:56 +1000
Message-ID: <CA+z5DszOHS8z9SzNyDXwU2=cPy3T0PkqEgV_xfmbrGu2nVFBjg@mail.gmail.com>
References: <CANA9Uk4NH7H4kQjEzeNp26bvar5DRWvnNdPff-wCJDRfb1be_A@mail.gmail.com>
 <alpine.DEB.2.11.1606070830160.6221@cpach.fuggernut.com> <CANA9Uk6YXFpAyp+jUgq7Cc9nRwR4Ha=UO-0nPrEAxy8A_GxGNA@mail.gmail.com>
 <alpine.DEB.2.11.1606070905590.6221@cpach.fuggernut.com> <CANA9Uk7aQrom4HEWJHSUjJeY7ywK8KZ0pmdsoY6dwHf4HhPBWg@mail.gmail.com>
 <CA+z5DsznXSZQ2TQ9y3D0rj-fU4Yi=8GNOW89ZmwvHkvQada4cg@mail.gmail.com>
 <CANA9Uk7rNtfLrO+oT8XbfxaRdX0psPmcRHcNOKYvQ0UCrTGc=g@mail.gmail.com>
 <CANA9Uk48oQ7sjd614LzYy=7HxYfmO8qZxoQCC62wYeOdsBPFeg@mail.gmail.com>
 <CA+z5DszvAcwTO=9smdqjrLWexWGkYmjA0tE6yKVn79ezr0FVmg@mail.gmail.com> <CANA9Uk4Bddii2vBgExF3tM9hs2CByefep8mpUZpHKFCyzEFyXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36443 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcFJCLR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jun 2016 22:11:17 -0400
Received: by mail-vk0-f51.google.com with SMTP id g67so79862703vkb.3
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jun 2016 19:11:16 -0700 (PDT)
In-Reply-To: <CANA9Uk4Bddii2vBgExF3tM9hs2CByefep8mpUZpHKFCyzEFyXg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: M Ranga Swami Reddy <swamireddy@gmail.com>
Cc: Sage Weil <sage@newdream.net>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@lists.ceph.com>

Hi Swami,

That's a known issue, which I believe is much improved in Jewel thanks
to a priority queue added somewhere in the OSD op path (I think). If I
were you I'd be planning to get off Firefly and upgrade.

Cheers,

On 10 June 2016 at 12:08, M Ranga Swami Reddy <swamireddy@gmail.com> wrote:
> Blair - Thanks for the details. I used to set the low priority for
> recovery during the rebalance/recovery activity.
> Even though I set the recovery_priority as 5 (instead of 1) and
> client-op_priority set as 63, some of my customers complained that
> their VMs are not reachable for a few mins/secs during the reblancing
> task. Not sure, these low priority configurations are doing the job as
> its.
>
> Thanks
> Swami
>
> On Thu, Jun 9, 2016 at 5:50 PM, Blair Bethwaite
> <blair.bethwaite@gmail.com> wrote:
>> Swami,
>>
>> Run it with the help option for more context:
>> "./crush-reweight-by-utilization.py --help". In your example below
>> it's reporting to you what changes it would make to your OSD reweight
>> values based on the default option settings (because you didn't
>> specify any options). To make the script actually apply those weight
>> changes you need the "-d -r" or "--doit --really" flags.
>>
>> If you want to get an idea of the impact that the weight changes will
>> have before actually starting to move data then I suggest setting
>> norecover and nobackfill (ceph osd set ...) on your cluster before
>> making the weight changes, you can then examine "ceph -s" output
>> (looking at "objects misplaced" to determine the scale of recovery
>> required. Unset the flags once ready to start or back-out the reweight
>> settings if you change your mind. You'll also want to lower these
>> recovery and backfill tunables to reduce impact to client I/O (and if
>> possible do not do this reweight change during peak I/O hours):
>> ceph tell osd.* injectargs '--osd-max-backfills 1'
>> ceph tell osd.* injectargs '--osd-max-recovery-threads 1'
>> ceph tell osd.* injectargs '--osd-recovery-op-priority 1'
>> ceph tell osd.* injectargs '--osd-client-op-priority 63'
>> ceph tell osd.* injectargs '--osd-recovery-max-active 1'
>>
>> Cheers,
>>
>> On 9 June 2016 at 20:20, M Ranga Swami Reddy <swamireddy@gmail.com> wrote:
>>> Hi Blari,
>>> I ran the script and results are below:
>>> ==
>>> ./crush-reweight-by-utilization.py
>>> average_util: 0.587024, overload_util: 0.704429, underload_util: 0.587024.
>>> reweighted:
>>> 43 (0.852690 >= 0.704429) [1.000000 -> 0.950000]
>>> 238 (0.845154 >= 0.704429) [1.000000 -> 0.950000]
>>> 104 (0.827908 >= 0.704429) [1.000000 -> 0.950000]
>>> 173 (0.817063 >= 0.704429) [1.000000 -> 0.950000]
>>> ==
>>>
>>> is the above scripts says to reweight 43 -> 0.95?
>>>
>>> Thanks
>>> Swami
>>>
>>> On Wed, Jun 8, 2016 at 10:34 AM, M Ranga Swami Reddy
>>> <swamireddy@gmail.com> wrote:
>>>> Blair - Thanks for the script...Btw, is this script has option for dry run?
>>>>
>>>> Thanks
>>>> Swami
>>>>
>>>> On Wed, Jun 8, 2016 at 6:35 AM, Blair Bethwaite
>>>> <blair.bethwaite@gmail.com> wrote:
>>>>> Swami,
>>>>>
>>>>> Try https://github.com/cernceph/ceph-scripts/blob/master/tools/crush-reweight-by-utilization.py,
>>>>> that'll work with Firefly and allow you to only tune down weight of a
>>>>> specific number of overfull OSDs.
>>>>>
>>>>> Cheers,
>>>>>
>>>>> On 7 June 2016 at 23:11, M Ranga Swami Reddy <swamireddy@gmail.com> wrote:
>>>>>> OK, understood...
>>>>>> To fix the nearfull warn, I am reducing the weight of a specific OSD,
>>>>>> which filled >85%..
>>>>>> Is this work-around advisable?
>>>>>>
>>>>>> Thanks
>>>>>> Swami
>>>>>>
>>>>>> On Tue, Jun 7, 2016 at 6:37 PM, Sage Weil <sage@newdream.net> wrote:
>>>>>>> On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>>>>>>>> Hi Sage,
>>>>>>>> >Jewel and the latest hammer point release have an improved
>>>>>>>> >reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
>>>>>>>> > run) to correct this.
>>>>>>>>
>>>>>>>> Thank you....But not planning to upgrade the cluster soon.
>>>>>>>> So, in this case - are there any tunable options will help? like
>>>>>>>> "crush tunable optimal" or so?
>>>>>>>> OR any other configuration options change will help?
>>>>>>>
>>>>>>> Firefly also has reweight-by-utilization... it's just a bit less friendly
>>>>>>> than the newer versions.  CRUSH tunables don't generally help here unless
>>>>>>> you have lots of OSDs that are down+out.
>>>>>>>
>>>>>>> Note that firefly is no longer supported.
>>>>>>>
>>>>>>> sage
>>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Thanks
>>>>>>>> Swami
>>>>>>>>
>>>>>>>>
>>>>>>>> On Tue, Jun 7, 2016 at 6:00 PM, Sage Weil <sage@newdream.net> wrote:
>>>>>>>> > On Tue, 7 Jun 2016, M Ranga Swami Reddy wrote:
>>>>>>>> >> Hello,
>>>>>>>> >> I have aorund 100 OSDs in my ceph cluster. In this a few OSDs filled
>>>>>>>> >> with >85% of data and few OSDs filled with ~60%-70% of data.
>>>>>>>> >>
>>>>>>>> >> Any reason why the unevenly OSDs filling happned? do I need to any
>>>>>>>> >> tweaks on configuration to fix the above? Please advise.
>>>>>>>> >>
>>>>>>>> >> PS: Ceph version is - 0.80.7
>>>>>>>> >
>>>>>>>> > Jewel and the latest hammer point release have an improved
>>>>>>>> > reweight-by-utilization (ceph osd test-reweight-by-utilization ... to dry
>>>>>>>> > run) to correct this.
>>>>>>>> >
>>>>>>>> > sage
>>>>>>>> >
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>>
>>>>>> --
>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Cheers,
>>>>> ~Blairo
>>
>>
>>
>> --
>> Cheers,
>> ~Blairo



-- 
Cheers,
~Blairo
