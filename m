From: handong He <hedongho@gmail.com>
Subject: Re: osd full still writing data while cluster recovering
Date: Thu, 29 Jun 2017 09:43:31 +0800
Message-ID: <CALCdKoddfjPS-=WZ8m1RHHFO5CPUemBXzmb5Fxe_ojxTS1FJeg@mail.gmail.com>
References: <CALCdKocMeqpY=3dx8BqE96-9Gvt7bYo4DJHEP4bbU9vmUsRSkQ@mail.gmail.com>
 <alpine.DEB.2.11.1706281636190.3424@piezo.novalocal> <5ceab84b-6fb7-d12d-2fa5-e28c02b9336c@redhat.com>
 <b8e67e37-bd48-9047-47d4-07259b21980e@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36534 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751647AbdF2Bnd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Jun 2017 21:43:33 -0400
Received: by mail-qt0-f169.google.com with SMTP id i2so63813171qta.3
        for <ceph-devel@vger.kernel.org>; Wed, 28 Jun 2017 18:43:32 -0700 (PDT)
In-Reply-To: <b8e67e37-bd48-9047-47d4-07259b21980e@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>, David Zafman <dzafman@redhat.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Thanks for reply. It helps a lot.

Later I will try Luminous and keep tracking this issue in jewel.


Thanks,
Handong

2017-06-29 1:21 GMT+08:00 Nathan Cutler <ncutler@suse.cz>:
>
>
> On 06/28/2017 07:04 PM, David Zafman wrote:
>>
>>
>> Luminous has the more complex fix which prevents recovery/backfill from
>> filling up a disk.
>>
>> In your 3 node test cluster with 1 osd out you have 66% of your storage
>> available with up to 80% in use, so you are out of space. In Luminous no=
t
>> only would new writes be blocked but PGs would be marked "backfill_toofu=
ll"
>> or "recovery_toofull."
>>
>>
>> A portion of the Luminous changes are in a pending Jewel backport.
>
>
> That's https://github.com/ceph/ceph/pull/15050 in case anyone was wonderi=
ng.
>
>
>> It includes code that warns about uneven OSD usage and increases
>> mon_osd_min_in_ratio to .75 (75%).
>>
>> In a more realistic Jewel cluster you can increase the value of
>> mon_osd_min_in_ratio to what is best for your situation.  This will prev=
ent
>> too many OSDs from being marked out.
>>
>> David
>>
>>
>> On 6/28/17 9:37 AM, Sage Weil wrote:
>>>
>>> On Wed, 28 Jun 2017, handong He wrote:
>>>>
>>>> Hello,
>>>>
>>>> I'm using ceph-jewel 10.2.7 for some test.
>>>> Discovered that when an osd is full(like full_ratio=3D0.95), client
>>>> write failed, which is normal. But a full osd cannot stop a recovering
>>>> cluster writing data, make osd used ratio from 95% to100%. When that
>>>> happen, osd will be down for no space left and cannot startup anymore.
>>>>
>>>> So the question is : can the cluster auto stop recovering while osd is
>>>> reaching full without setting the norecover flag manually?  Or is it
>>>> already fix in the latest version?
>>>>
>>>> Consider this situation: a half-full cluster with many osds. For some
>>>> bad luck(netlink down| server down | or others) in midnight, some osds
>>>> down|out and trigger cluster recovery, makes some  other health osds'
>>>> used% to 100% (experienceless in operation and maintenance, please fix
>>>> me if i'm wrong). Unluckly, this just like a plague and make much more
>>>> osds down. It maybe easy to fix one down osd like that, but a disaster
>>>> to fix 10+ osds with 100% space used.
>>>
>>> There are additional thresholds for stopping backfill and (later) a
>>> failsafe to prevent any writes, but you're not hte first one to see the=
se
>>> not work properly in jewel.  David recently made a ton of
>>> improvements here in master for luminous, but I'm not sure what the
>>> status is for backporting some of the critical pieces to jewel...
>>>
>>> sage
>>>
>>>> here is my test environment and steps:
>>>>
>>>> three nodes, each node has one monitor and one osd(10G hdd for
>>>> convenient), running in vm.
>>>> ceph conf is basic.
>>>> pool size set to 2.
>>>> using 'rados bench' writing data to osds.
>>>>
>>>> 1. exec command  to set osd full ratio:
>>>> # ceph pg set_full_ratio 0.8
>>>> # ceph pg set nearfull_ratio 0.7
>>>>
>>>> 2. writing data, when an osd is reaching full, stop writing and mark
>>>> out one osd with command:
>>>> # ceph osd out 0
>>>>
>>>> 3. waiting for cluster recovering finished , and exec command:
>>>> # ceph osd df
>>>> # ceph osd tree
>>>>
>>>> we can find that other osds is down.
>>>>
>>>> Thanks and Best Regards=EF=BC=81
>>>>
>>>> He Handong
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> Nathan Cutler
> Software Engineer Distributed Storage
> SUSE LINUX, s.r.o.
> Tel.: +420 284 084 037
