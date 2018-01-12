From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Luminous - replace old target-weight tree from osdmap with mgr
 balancer
Date: Fri, 12 Jan 2018 22:23:18 +0100
Message-ID: <7f08afda-2e18-b563-56f4-deeac81f92ec@profihost.ag>
References: <602f839b-6927-2c53-dbb5-baee02569105@profihost.ag>
 <alpine.DEB.2.11.1801102123260.8186@piezo.novalocal>
 <e638d77d-104f-a224-579b-a960fab90732@profihost.ag>
 <alpine.DEB.2.11.1801102151470.8186@piezo.novalocal>
 <c4e77c5b-91bb-9924-db51-0f30a37b1b21@profihost.ag>
 <e9729df5-09d1-3a2a-31c4-f3e4909d3717@profihost.ag>
 <alpine.DEB.2.11.1801111958450.24931@piezo.novalocal>
 <0a407489-849e-98cd-2a7c-ffe7626407cf@profihost.ag>
 <alpine.DEB.2.11.1801112008180.24931@piezo.novalocal>
 <4106bc21-f5e4-5270-1a34-fba328560da6@profihost.ag>
 <975b88ed-7f7b-7762-2e9f-a94aa7d13aee@profihost.ag>
 <alpine.DEB.2.11.1801112037090.24931@piezo.novalocal>
 <604fbd54-31e0-c857-401c-d4b4c53059d2@profihost.ag>
 <alpine.DEB.2.11.1801122015220.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------5217A603577D63A7B07F5CE2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:43606 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965067AbeALVXV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 12 Jan 2018 16:23:21 -0500
In-Reply-To: <alpine.DEB.2.11.1801122015220.24931@piezo.novalocal>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is a multi-part message in MIME format.
--------------5217A603577D63A7B07F5CE2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Am 12.01.2018 um 21:21 schrieb Sage Weil:
> On Fri, 12 Jan 2018, Stefan Priebe - Profihost AG wrote:
>> Am 11.01.2018 um 21:37 schrieb Sage Weil:
>>> On Thu, 11 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>> OK it wasn't the balancer.
>>>>
>>>> It happens after executing all the reweight und crush compat commands:
>>>>
>>>> An even on a much bigger cluster it's 6% again. Some rounding issue? I
>>>> migrated with a script so it's not a typo.
>>>
>>> Maybe.. can you narrow down which command it is?  I'm guessing that one of 
>>> the 'ceph osd crush weight-set reweight-compat ...' commands does it, but 
>>> it would be nice to confirm whether it is a rounding issue or if something 
>>> is broken!
>>
>> Hi Sage,
>>
>> it happens while executing:
>> ceph osd crush weight-set reweight-compat <osd> <optimized-weight>
>> ceph osd crush reweight <osd> <target-weight>
>> right after the first command (reweight-compat optimized-weight) for the
> 
> It does this with the optimized-weight is *exactly* the same as the 
> current (normal) weight?  If it matches it should be a no-op.  Can you do 
> a 'ceph osd crush tree' before and after the command so we can compare?  
> (In fact, I think that first step is pointless because when you create the 
> compat weight-set it's populated with the regular CRUSH weights, which in 
> your situation *are* the optimized weights.)
> 
> Actually, looking at this more closely, it looks like the normal 
> 'reweight' command sets the value in the compat weight-set too, so in 
> reality we want to reorder those commands (and do them quickly in 
> succession).  e.g.,
> 
> ceph osd crush reweight osd.1 <target-weight>
> ceph osd crush weight-set reweight-compat osd.1 <optimized-weight>
> 
> but, again, the before and after PG layout should match.  A 'ceph osd 
> crush tree' dump before, after, and between will help sort out what is 
> going on.


Here we go (attached) - but those dumps are in json instead of plain
text but i had them already dumped by my script. I hope this helps.

Thanks,
Stefan

>  Thanks!
> sage
> 
>> 1st OSD it gets:
>> 0.4%
>> after the second (reweight target-weight):
>> 0.7%
>>
>> for each OSD it gets more worse...
>>
>> Stefan
>>
>>> sage
>>>
>>>  > 
>>>> Stefan
>>>>
>>>> Am 11.01.2018 um 21:21 schrieb Stefan Priebe - Profihost AG:
>>>>> Hi,
>>>>>
>>>>> Am 11.01.2018 um 21:10 schrieb Sage Weil:
>>>>>> On Thu, 11 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>> Am 11.01.2018 um 20:58 schrieb Sage Weil:
>>>>>>>> On Thu, 11 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>>> Hi Sage,
>>>>>>>>>
>>>>>>>>> this did not work like expected. I tested it in another smaller cluster
>>>>>>>>> and it resulted in about 6% misplaced objects.
>>>>>>>>
>>>>>>>> Can you narrow down at what stage the misplaced objects happened?
>>>>>>>
>>>>>>> ouch i saw this:
>>>>>>> # ceph balancer status
>>>>>>> {
>>>>>>>     "active": true,
>>>>>>>     "plans": [
>>>>>>>         "auto_2018-01-11_19:52:28"
>>>>>>>     ],
>>>>>>>     "mode": "crush-compat"
>>>>>>> }
>>>>>>>
>>>>>>> so might it be the balancer beeing executed while i was modifying the tree?
>>>>>>> Can i stop it and reexecute it manually?
>>>>>>
>>>>>> You can always 'ceph balancer off'.  And I probably wouldn't turn it on 
>>>>>> until after you've cleaned this up because it will balance with the 
>>>>>> current weights being the 'target' weights (when in your case they're not 
>>>>>> (yet)).
>>>>>>
>>>>>> To manually see what the balancer would do you can
>>>>>>
>>>>>>  ceph balancer optimize foo
>>>>>>  ceph balancer show foo
>>>>>>  ceph balancer eval foo   # (see numerical analysis)
>>>>>>
>>>>>> and if it looks good
>>>>>>
>>>>>>  ceph balancer execute foo
>>>>>>
>>>>>> to actually apply the changes.
>>>>>
>>>>> ok thanks but it seems there are still leftovers somewhere:
>>>>> [expo-office-node1 ~]# ceph balancer optimize stefan
>>>>> Error EINVAL: Traceback (most recent call last):
>>>>>   File "/usr/lib/ceph/mgr/balancer/module.py", line 303, in handle_command
>>>>>     self.optimize(plan)
>>>>>   File "/usr/lib/ceph/mgr/balancer/module.py", line 596, in optimize
>>>>>     return self.do_crush_compat(plan)
>>>>>   File "/usr/lib/ceph/mgr/balancer/module.py", line 658, in do_crush_compat
>>>>>     orig_ws = self.get_compat_weight_set_weights()
>>>>>   File "/usr/lib/ceph/mgr/balancer/module.py", line 837, in
>>>>> get_compat_weight_set_weights
>>>>>     raise RuntimeError('could not find bucket %s' % b['bucket_id'])
>>>>> RuntimeError: could not find bucket -6
>>>>>
>>>>> [expo-office-node1 ~]# ceph osd tree
>>>>> ID CLASS WEIGHT   TYPE NAME                  STATUS REWEIGHT PRI-AFF
>>>>> -1       14.55957 root default
>>>>> -4        3.63989     host expo-office-node1
>>>>>  8   ssd  0.90997         osd.8                  up  1.00000 1.00000
>>>>>  9   ssd  0.90997         osd.9                  up  1.00000 1.00000
>>>>> 10   ssd  0.90997         osd.10                 up  1.00000 1.00000
>>>>> 11   ssd  0.90997         osd.11                 up  1.00000 1.00000
>>>>> -2        3.63989     host expo-office-node2
>>>>>  0   ssd  0.90997         osd.0                  up  1.00000 1.00000
>>>>>  1   ssd  0.90997         osd.1                  up  1.00000 1.00000
>>>>>  2   ssd  0.90997         osd.2                  up  1.00000 1.00000
>>>>>  3   ssd  0.90997         osd.3                  up  1.00000 1.00000
>>>>> -3        3.63989     host expo-office-node3
>>>>>  4   ssd  0.90997         osd.4                  up  1.00000 1.00000
>>>>>  5   ssd  0.90997         osd.5                  up  1.00000 1.00000
>>>>>  6   ssd  0.90997         osd.6                  up  1.00000 1.00000
>>>>>  7   ssd  0.90997         osd.7                  up  1.00000 1.00000
>>>>> -5        3.63989     host expo-office-node4
>>>>> 12   ssd  0.90997         osd.12                 up  1.00000 1.00000
>>>>> 13   ssd  0.90997         osd.13                 up  1.00000 1.00000
>>>>> 14   ssd  0.90997         osd.14                 up  1.00000 1.00000
>>>>> 15   ssd  0.90997         osd.15                 up  1.00000 1.00000
>>>>>
>>>>>
>>>>> Stefan
>>>>>
>>>>>> sage
>>>>>>
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>> sage
>>>>>>>>
>>>>>>>>>
>>>>>>>>> Any ideas?
>>>>>>>>>
>>>>>>>>> Stefan
>>>>>>>>> Am 11.01.2018 um 08:09 schrieb Stefan Priebe - Profihost AG:HI
>>>>>>>>>> Thanks! Can this be done while still having jewel clients?
>>>>>>>>>>
>>>>>>>>>> Stefan
>>>>>>>>>>
>>>>>>>>>> Excuse my typo sent from my mobile phone.
>>>>>>>>>>
>>>>>>>>>> Am 10.01.2018 um 22:56 schrieb Sage Weil <sage@newdream.net
>>>>>>>>>> <mailto:sage@newdream.net>>:
>>>>>>>>>>
>>>>>>>>>>> On Wed, 10 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>>>>>> Am 10.01.2018 um 22:23 schrieb Sage Weil:
>>>>>>>>>>>>> On Wed, 10 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>>>>>>>>>> k,
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> in the past we used the python crush optimize tool to reweight the osd
>>>>>>>>>>>>>> usage - it inserted a 2nd tree with $hostname-target-weight as
>>>>>>>>>>>>>> hostnames.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Can you attach a 'ceph osd crush tree' (or partial output) so I can see
>>>>>>>>>>>>> what you mean?
>>>>>>>>>>>>
>>>>>>>>>>>> Sure - attached.
>>>>>>>>>>>
>>>>>>>>>>> Got it
>>>>>>>>>>>
>>>>>>>>>>>>>> Now the quesions are:
>>>>>>>>>>>>>> 1.) can we remove the tree? How?
>>>>>>>>>>>>>> 2.) Can we do this now or only after all clients are running Luminous?
>>>>>>>>>>>>>> 3.) is it enought to enable the mgr balancer module?
>>>>>>>>>>>
>>>>>>>>>>> First,
>>>>>>>>>>>
>>>>>>>>>>> ceph osd crush weight-set create-compat
>>>>>>>>>>>
>>>>>>>>>>> then for each osd,
>>>>>>>>>>> ceph osd crush weight-set reweight-compat <osd> <optimized-weight>
>>>>>>>>>>> ceph osd crush reweight <osd> <target-weight>
>>>>>>>>>>>
>>>>>>>>>>> That won't move any data but will keep your current optimized weights in
>>>>>>>>>>> the compat weight-set where they belong.
>>>>>>>>>>>
>>>>>>>>>>> Then you can remove the *-target-weight buckets.  For each osd,
>>>>>>>>>>>
>>>>>>>>>>> ceph osd crush rm <osd> <ancestor>-target-weight
>>>>>>>>>>>
>>>>>>>>>>> and then for each remaining bucket
>>>>>>>>>>>
>>>>>>>>>>> ceph osd crush rm <foo>-target-weight
>>>>>>>>>>>
>>>>>>>>>>> Finally, turn on the balancer (or test it to see what it it wants to do
>>>>>>>>>>> with the optimize command.)
>>>>>>>>>>>
>>>>>>>>>>> HTH!
>>>>>>>>>>> sage
>>>>>>>>>
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

--------------5217A603577D63A7B07F5CE2
Content-Type: application/gzip;
 name="maps.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="maps.tar.gz"

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
QU9MaQCAAgA=
--------------5217A603577D63A7B07F5CE2--
