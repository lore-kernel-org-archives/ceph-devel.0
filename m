From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Luminous - replace old target-weight tree from osdmap with mgr
 balancer
Date: Thu, 11 Jan 2018 21:21:44 +0100
Message-ID: <4106bc21-f5e4-5270-1a34-fba328560da6@profihost.ag>
References: <602f839b-6927-2c53-dbb5-baee02569105@profihost.ag>
 <alpine.DEB.2.11.1801102123260.8186@piezo.novalocal>
 <e638d77d-104f-a224-579b-a960fab90732@profihost.ag>
 <alpine.DEB.2.11.1801102151470.8186@piezo.novalocal>
 <c4e77c5b-91bb-9924-db51-0f30a37b1b21@profihost.ag>
 <e9729df5-09d1-3a2a-31c4-f3e4909d3717@profihost.ag>
 <alpine.DEB.2.11.1801111958450.24931@piezo.novalocal>
 <0a407489-849e-98cd-2a7c-ffe7626407cf@profihost.ag>
 <alpine.DEB.2.11.1801112008180.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:13029 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932766AbeAKUVq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 11 Jan 2018 15:21:46 -0500
In-Reply-To: <alpine.DEB.2.11.1801112008180.24931@piezo.novalocal>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Am 11.01.2018 um 21:10 schrieb Sage Weil:
> On Thu, 11 Jan 2018, Stefan Priebe - Profihost AG wrote:
>> Am 11.01.2018 um 20:58 schrieb Sage Weil:
>>> On Thu, 11 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>> Hi Sage,
>>>>
>>>> this did not work like expected. I tested it in another smaller cluster
>>>> and it resulted in about 6% misplaced objects.
>>>
>>> Can you narrow down at what stage the misplaced objects happened?
>>
>> ouch i saw this:
>> # ceph balancer status
>> {
>>     "active": true,
>>     "plans": [
>>         "auto_2018-01-11_19:52:28"
>>     ],
>>     "mode": "crush-compat"
>> }
>>
>> so might it be the balancer beeing executed while i was modifying the tree?
>> Can i stop it and reexecute it manually?
> 
> You can always 'ceph balancer off'.  And I probably wouldn't turn it on 
> until after you've cleaned this up because it will balance with the 
> current weights being the 'target' weights (when in your case they're not 
> (yet)).
> 
> To manually see what the balancer would do you can
> 
>  ceph balancer optimize foo
>  ceph balancer show foo
>  ceph balancer eval foo   # (see numerical analysis)
> 
> and if it looks good
> 
>  ceph balancer execute foo
> 
> to actually apply the changes.

ok thanks but it seems there are still leftovers somewhere:
[expo-office-node1 ~]# ceph balancer optimize stefan
Error EINVAL: Traceback (most recent call last):
  File "/usr/lib/ceph/mgr/balancer/module.py", line 303, in handle_command
    self.optimize(plan)
  File "/usr/lib/ceph/mgr/balancer/module.py", line 596, in optimize
    return self.do_crush_compat(plan)
  File "/usr/lib/ceph/mgr/balancer/module.py", line 658, in do_crush_compat
    orig_ws = self.get_compat_weight_set_weights()
  File "/usr/lib/ceph/mgr/balancer/module.py", line 837, in
get_compat_weight_set_weights
    raise RuntimeError('could not find bucket %s' % b['bucket_id'])
RuntimeError: could not find bucket -6

[expo-office-node1 ~]# ceph osd tree
ID CLASS WEIGHT   TYPE NAME                  STATUS REWEIGHT PRI-AFF
-1       14.55957 root default
-4        3.63989     host expo-office-node1
 8   ssd  0.90997         osd.8                  up  1.00000 1.00000
 9   ssd  0.90997         osd.9                  up  1.00000 1.00000
10   ssd  0.90997         osd.10                 up  1.00000 1.00000
11   ssd  0.90997         osd.11                 up  1.00000 1.00000
-2        3.63989     host expo-office-node2
 0   ssd  0.90997         osd.0                  up  1.00000 1.00000
 1   ssd  0.90997         osd.1                  up  1.00000 1.00000
 2   ssd  0.90997         osd.2                  up  1.00000 1.00000
 3   ssd  0.90997         osd.3                  up  1.00000 1.00000
-3        3.63989     host expo-office-node3
 4   ssd  0.90997         osd.4                  up  1.00000 1.00000
 5   ssd  0.90997         osd.5                  up  1.00000 1.00000
 6   ssd  0.90997         osd.6                  up  1.00000 1.00000
 7   ssd  0.90997         osd.7                  up  1.00000 1.00000
-5        3.63989     host expo-office-node4
12   ssd  0.90997         osd.12                 up  1.00000 1.00000
13   ssd  0.90997         osd.13                 up  1.00000 1.00000
14   ssd  0.90997         osd.14                 up  1.00000 1.00000
15   ssd  0.90997         osd.15                 up  1.00000 1.00000


Stefan

> sage
> 
> 
>>
>>>
>>> sage
>>>
>>>>
>>>> Any ideas?
>>>>
>>>> Stefan
>>>> Am 11.01.2018 um 08:09 schrieb Stefan Priebe - Profihost AG:HI
>>>>> Thanks! Can this be done while still having jewel clients?
>>>>>
>>>>> Stefan
>>>>>
>>>>> Excuse my typo sent from my mobile phone.
>>>>>
>>>>> Am 10.01.2018 um 22:56 schrieb Sage Weil <sage@newdream.net
>>>>> <mailto:sage@newdream.net>>:
>>>>>
>>>>>> On Wed, 10 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>> Am 10.01.2018 um 22:23 schrieb Sage Weil:
>>>>>>>> On Wed, 10 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>>> k,
>>>>>>>>>
>>>>>>>>> in the past we used the python crush optimize tool to reweight the osd
>>>>>>>>> usage - it inserted a 2nd tree with $hostname-target-weight as
>>>>>>>>> hostnames.
>>>>>>>>
>>>>>>>> Can you attach a 'ceph osd crush tree' (or partial output) so I can see
>>>>>>>> what you mean?
>>>>>>>
>>>>>>> Sure - attached.
>>>>>>
>>>>>> Got it
>>>>>>
>>>>>>>>> Now the quesions are:
>>>>>>>>> 1.) can we remove the tree? How?
>>>>>>>>> 2.) Can we do this now or only after all clients are running Luminous?
>>>>>>>>> 3.) is it enought to enable the mgr balancer module?
>>>>>>
>>>>>> First,
>>>>>>
>>>>>> ceph osd crush weight-set create-compat
>>>>>>
>>>>>> then for each osd,
>>>>>> ceph osd crush weight-set reweight-compat <osd> <optimized-weight>
>>>>>> ceph osd crush reweight <osd> <target-weight>
>>>>>>
>>>>>> That won't move any data but will keep your current optimized weights in
>>>>>> the compat weight-set where they belong.
>>>>>>
>>>>>> Then you can remove the *-target-weight buckets.  For each osd,
>>>>>>
>>>>>> ceph osd crush rm <osd> <ancestor>-target-weight
>>>>>>
>>>>>> and then for each remaining bucket
>>>>>>
>>>>>> ceph osd crush rm <foo>-target-weight
>>>>>>
>>>>>> Finally, turn on the balancer (or test it to see what it it wants to do
>>>>>> with the optimize command.)
>>>>>>
>>>>>> HTH!
>>>>>> sage
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
