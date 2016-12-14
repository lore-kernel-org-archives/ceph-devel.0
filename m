From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: wake up sync waiter when unregistering request
Date: Wed, 14 Dec 2016 22:58:24 +0100
Message-ID: <CAOi1vP8F5jhYha=b+JO9LTrLXB+fPYG-_URLshvKfS__jci-pw@mail.gmail.com>
References: <20161129114921.62964-1-zyan@redhat.com> <CAOi1vP8ieneOG-UhTysHNoOvoZ3_kcV_x7zqw9p3BSUpMLK_9Q@mail.gmail.com>
 <B93E1ED2-557B-4414-AABC-42A47569D405@redhat.com> <CAOi1vP-mhjC+jxYcxt+q642Dm7Oc4jyWvR0J3FjxP=DF1ZuL+Q@mail.gmail.com>
 <20559259-27E6-4A70-85CE-FD3F09DAB27D@redhat.com> <CAOi1vP9JoPFYSpWSYDON6da9dOW0jRAzOvHXVT+Zd4fyQfPAvA@mail.gmail.com>
 <CAAM7YAkreRGsX2HaiYu+dDdiJC+TLsgpbvAmvZX__8njDKcwrQ@mail.gmail.com>
 <CAOi1vP9JskuNeOX5dk7gU62=6knhfGX46mkK1nt0rB7FY+11nw@mail.gmail.com> <0507F2C5-0455-4616-900D-4E7FAFB665D0@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35600 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbcLNXGX (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Dec 2016 18:06:23 -0500
Received: by mail-vk0-f54.google.com with SMTP id w194so51778332vkw.2
        for <ceph-devel@vger.kernel.org>; Wed, 14 Dec 2016 15:06:16 -0800 (PST)
In-Reply-To: <0507F2C5-0455-4616-900D-4E7FAFB665D0@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Nov 30, 2016 at 11:02 AM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On 30 Nov 2016, at 17:06, Ilya Dryomov <idryomov@gmail.com> wrote:
>>
>> On Wed, Nov 30, 2016 at 1:30 AM, Yan, Zheng <ukernel@gmail.com> wrote:
>>> On Tue, Nov 29, 2016 at 11:29 PM, Ilya Dryomov <idryomov@gmail.com> wro=
te:
>>>> On Tue, Nov 29, 2016 at 4:03 PM, Yan, Zheng <zyan@redhat.com> wrote:
>>>>>
>>>>>> On 29 Nov 2016, at 22:58, Ilya Dryomov <idryomov@gmail.com> wrote:
>>>>>>
>>>>>> On Tue, Nov 29, 2016 at 2:59 PM, Yan, Zheng <zyan@redhat.com> wrote:
>>>>>>>
>>>>>>>> On 29 Nov 2016, at 21:54, Ilya Dryomov <idryomov@gmail.com> wrote:
>>>>>>>>
>>>>>>>> On Tue, Nov 29, 2016 at 12:49 PM, Yan, Zheng <zyan@redhat.com> wro=
te:
>>>>>>>>> Current code does not wake up sync waiter if osd replies error
>>>>>>>>> or the request does not want ondisk ack.
>>>>>>>>
>>>>>>>> Hi Zheng,
>>>>>>>>
>>>>>>>> Did you mean to write "and" instead of "or" - "if osd replies erro=
r
>>>>>>>> *and* the request does not want ondisk ack=E2=80=9D?
>>>>>>>
>>>>>>> I mean =E2=80=98or=E2=80=99.  The code does not wake up sync waiter=
 in either of these two cases.
>>>>>>
>>>>>> It does wake the sync waiter (r_safe_completion) on error, but only
>>>>>> if ondisk ack was requested.  If ondisk ack wasn't requested, it's n=
ot
>>>>>> woken up, success or error.
>>>>>>
>>>>>> By not setting CEPH_OSD_FLAG_ONDISK, the submitter is indicating tha=
t
>>>>>> *any* reply is fine.  Blocking on the safe reply instead of any repl=
y
>>>>>> in the !CEPH_OSD_FLAG_ONDISK case sounds wrong.
>>>>>>
>>>>>> What is the motivation for this patch?
>>>>>
>>>>> I saw fsstress hang at ceph_osdc_sync several times.
>>>>>
>>>>> [52310.533483] sysrq: SysRq : Show Blocked State
>>>>> [52310.534057]   task                        PC stack   pid father
>>>>> [52310.534653] fsstress        D14656  2836   2834 0x00000000
>>>>> [52310.535568]  ffff880036cff200 ffff88003e2dac80 0000000000002fa3 ff=
ff88003e3142c0
>>>>> [52310.536529]  ffff88003fd18318 ffffc900038b7d48 ffffffff819354cc ff=
ffffff00000000
>>>>> [52310.537464]  000000013e314ae0 ffff88003e314890 ffff88003fd18318 ff=
ff88003fd18300
>>>>> [52310.538396] Call Trace:
>>>>> [52310.538762]  [<ffffffff819354cc>] ? __schedule+0x6ac/0x880
>>>>> [52310.539326]  [<ffffffff81935713>] schedule+0x73/0x90
>>>>> [52310.539840]  [<ffffffff81939d21>] schedule_timeout+0x31/0x5d0
>>>>> [52310.540425]  [<ffffffff810ac4a6>] ? mark_held_locks+0x76/0x90
>>>>> [52310.540980]  [<ffffffff8193b447>] ? _raw_spin_unlock_irq+0x27/0x50
>>>>> [52310.541582]  [<ffffffff810ac64d>] ? trace_hardirqs_on_caller+0x18d=
/0x1c0
>>>>> [52310.542217]  [<ffffffff81936a1b>] wait_for_completion+0x8b/0x100
>>>>> [52310.542788]  [<ffffffff8108dc10>] ? wake_up_q+0x70/0x70
>>>>> [52310.543380]  [<ffffffffa00116b8>] ceph_osdc_sync+0xc8/0x150 [libce=
ph]
>>>>> [52310.543990]  [<ffffffff811eaed0>] ? SyS_tee+0x3b0/0x3b0
>>>>> [52310.544569]  [<ffffffffa005c3ea>] ceph_sync_fs+0x3a/0xb0 [ceph]
>>>>> [52310.545158]  [<ffffffff811eaeeb>] sync_fs_one_sb+0x1b/0x20
>>>>> [52310.545699]  [<ffffffff811b931e>] iterate_supers+0x7e/0xe0
>>>>> [52310.546258]  [<ffffffff811eb1e0>] sys_sync+0x50/0x80
>>>>> [52310.546849]  [<ffffffff8193bb6a>] entry_SYSCALL_64_fastpath+0x18/0=
xad
>>>>
>>>> Did you happen to capture /osdc?  It's probably the pool perm check
>>>> thing
>>>
>>> osdc is complete empty.
>>
>> If you haven't already done so while investigating, could you please
>> dump the offending @req fields?  I want to make sure it's the pool perm
>> check request=E2=80=A6
>
> Sorry, I have already rebooted that machine.

Hi Zheng,

I took it a step further and also fixed libceph cancellation code:

https://github.com/ceph/ceph-client/commit/c297eb42690b904fb5b78dd9ad001baf=
e25f49ec

I squashed your patch to reduce rename churn.  Let me know if that's OK
with you.

Thanks,

                Ilya
