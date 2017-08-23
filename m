From: Linux Chips <linux.chips@gmail.com>
Subject: Re: High memory usage kills OSD while peering
Date: Wed, 23 Aug 2017 18:27:28 +0300
Message-ID: <e79cb096-bb5c-5e1c-5e03-5ca8b324b9e2@gmail.com>
References: <07113ad5-a799-5232-c617-81f323ce4038@gmail.com>
 <CAJ4mKGa6Nt1Eic9gk=SMbRufUCPnEcGijgJj-K8vHQP7A=HQKw@mail.gmail.com>
 <15fa2de0-27ad-cc51-6a6c-f306b9f330d2@gmail.com>
 <CAFehDbCzt=Ezffz+D7QQNM4PaPaDTJqU+dm1AhjmNHjw1W1FcA@mail.gmail.com>
 <alpine.DEB.2.11.1708222230080.17029@piezo.novalocal>
 <cf976b97-5173-cf89-010f-a3d492944304@gmail.com>
 <alpine.DEB.2.11.1708231343470.20435@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34168 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754140AbdHWP1c (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 23 Aug 2017 11:27:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id r187so493958wma.1
        for <ceph-devel@vger.kernel.org>; Wed, 23 Aug 2017 08:27:31 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1708231343470.20435@piezo.novalocal>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Mustafa Muhammad <mustafa1024m@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>

On 08/23/2017 04:46 PM, Sage Weil wrote:
> On Wed, 23 Aug 2017, Linux Chips wrote:
>> On 08/23/2017 01:33 AM, Sage Weil wrote:
>>> One other trick that has been used here: if you look inside the PG
>>> directories on the OSDs and find that they are mostly empty then it's
>>> possible some of the memory and peering overhead is related to
>>> empty and useless PG instances on the wrong OSDs.  You can write a script
>>> to find empty directories (or ones that only contain the single pgmeta
>>> object with a mostly-empty name) and remove them (using
>>> ceph-objectstore-tool).  (For safety I'd recommend doing
>>> ceph-objectstore-tool export first, just in case there is some useful
>>> metadata there.)
>>>
>>> That will only help if most of the pg dirs look empty, though.  If so,
>>> it's worth a shot!
>>>
>>> The other thing we once did was use a kludge patch to trim the
>>> past_intervals metadata, which was respnosible for most of the memory
>>> usage.  I can't tell from the profile in this thread if that is the case
>>> or not.  There is a patch floating around in git somewhere that can be
>>> reused if it looks like that is the thing consuming the memory.
>>>
>>> sage
>>>
>>>
>>
>> we ll try the empty pg search. not sure how much is there, but i randomly
>> checked and found a few.
>>
>> as for the "kludge" patch, where can I find it. I searched the git repo, but
>> could not identify it. did not know what to look for specifically.
>> also, what would we need to better know if the patch would be useful?
>> e.g. if we need another/more mem profiling.
> 
> I found and rebased the branch, but until we have some confidence this is
> the problem I wouldn't use it.
>   
>> we installed a test cluster of 4 nodes and replicated the issue there, and we
>> are testing various scenarios there. if any one cares to replicate it i can
>> elaborate on the steps.
> 
> How were you able to reproduce the situation?

we deployed the cluster normally.
create some profiles:

ceph osd erasure-code-profile set k3m1 k=3 m=1
ceph osd erasure-code-profile set k9m3 k=9 m=3
ceph osd erasure-code-profile set k6m2 k=6 m=2
ceph osd erasure-code-profile set k12m4 k=12 m=4

then edit the rule set manually for them so the (step chooseleaf indep 0 
type osd) instead of host. this is necessary because it is a 4 osd node 
cluster.

add some pools:

ceph osd pool create testk9m3 1024 1024 erasure k9m3
ceph osd pool create testk12m4 1024 1024 erasure k12m4
ceph osd pool create testk6m2 1024 1024 erasure k6m2
ceph osd pool create testk3m1 1024 1024 erasure k3m1

fill it with some data using rados bench, we let it running for about 
2-3 hours, until we had about 2000+ kobject, more is better.

rados bench -p testk3m1 72000 write -t 256 -b 4K --no-cleanup
rados bench -p testk6m2 72000 write -t 256 -b 4K --no-cleanup
rados bench -p rbd 72000 write -t 256 -b 4K --no-cleanup
rados bench -p testk12m4 7200 write -t 256 -b 1M --no-cleanup


then we start messing with the placement of the hosts change there racks 
a couple of times, set OSDs down randomly, and randomly restarting them 
(the idea is to simulate a long unhealthy cluster, with a lot of osdmaps)

while true ; do i=$(( ( RANDOM % 48 ) )) ; ./restartOSD \
$(ceph osd tree | grep up | tail -n $i | head -1 | awk '{print $1}' ) \
; done

restartOSD is a script:
#!/bin/bash
osd=$1
IP=$(./findOSD $osd)
echo "sshing to $IP";
ssh $IP "systemctl restart ceph-osd@$osd";

findOSD is:
#!/bin/bash
if [[ $1 =~ ^[1-9]* ]]; then
ceph osd find $1 | grep ip | sed -e 's/.*\": \"\(.*\):.*/\1/'
#ceph osd tree | grep -e "host\|osd.$1 " | grep osd.$1 -B1
else
echo "Usage $0 OSDNUM"
fi

we also set a memory limit in systemd unit file, so the oom kills them 
and make things go faster. we put this
[Service]
MemoryLimit=2G

inside "/etc/systemd/system/ceph-osd@.service.d/memory.conf"
we start with some thing like 2GB and increase it when ever we feel the 
limit is too harsh. by the time we reach 10GB limit, things are pretty 
ugly though (which, oddly, is good).

after a while the mon store will grow bigger and bigger. and the amount 
of ram consumed will grow too.
the target is for the status of the OSDs
ceph daemon osd.xx status
will give a difference between the oldest and newest map of about 
20000-40000 epoch.

at this point, we stop the "restart script" and the "rados bench". if we 
restart all the OSDs, they will consume all the RAM in the node. and 
either the oom will be fast enough to kill them, or the whole node will 
die. so we usually put the memory limit in the unit file at about 20-30 
GB at this point so we do not loose the node.

> 
>> if all failed, do you think moving pgs out of the current dir is safe? we are
>> trying to test it, but we ll never be sure 100%
> 
> It is safe if you use ceph-objectstore-tool export and then remove.  Do
> not just move the directory around as that will leave behind all kinds of
> random state in leveldb!
> 
> sage
> 

