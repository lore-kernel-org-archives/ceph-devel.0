From: Stefan Priebe - Profihost AG <s.priebe@profihost.ag>
Subject: Re: Luminous - replace old target-weight tree from osdmap with mgr
 balancer
Date: Thu, 11 Jan 2018 14:55:31 +0100
Message-ID: <44510780-9cf7-d062-086c-d7a35eeb2605@profihost.ag>
References: <602f839b-6927-2c53-dbb5-baee02569105@profihost.ag>
 <alpine.DEB.2.11.1801102123260.8186@piezo.novalocal>
 <e638d77d-104f-a224-579b-a960fab90732@profihost.ag>
 <alpine.DEB.2.11.1801102151470.8186@piezo.novalocal>
 <D75F8583-C067-4AD2-AEED-2C6903B08C8D@profihost.ag>
 <alpine.DEB.2.11.1801111245500.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cloud1-vm154.de-nserver.de ([178.250.10.56]:59078 "EHLO
        cloud1-vm154.de-nserver.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932387AbeAKNzd (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 11 Jan 2018 08:55:33 -0500
In-Reply-To: <alpine.DEB.2.11.1801111245500.24931@piezo.novalocal>
Content-Language: de-DE
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Am 11.01.2018 um 13:46 schrieb Sage Weil:
> On Thu, 11 Jan 2018, Stefan Priebe - Profihost AG wrote:
>> Thanks! Can this be done while still having jewel clients?
> 
> Yeah.  If I'm understanding your crush dump properly, the *-target-weight 
> part of the tree isn't doing anything except acting as a place for your 
> custom tool to store the target weights.  Removing this wont' change 
> anything at all.  And the compat weight-set is called 'compat' because it 
> is backwards compatible with old clients.  :)

Thank! It's the tool from Loic - i haven't seen him here for a long time.

See:
http://crush.readthedocs.io/en/latest/

Greets,
Stefan


> sage
> 
>>
>> Stefan
>>
>> Excuse my typo sent from my mobile phone.
>>
>>> Am 10.01.2018 um 22:56 schrieb Sage Weil <sage@newdream.net>:
>>>
>>>> On Wed, 10 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>> Am 10.01.2018 um 22:23 schrieb Sage Weil:
>>>>>> On Wed, 10 Jan 2018, Stefan Priebe - Profihost AG wrote:
>>>>>> k,
>>>>>>
>>>>>> in the past we used the python crush optimize tool to reweight the osd
>>>>>> usage - it inserted a 2nd tree with $hostname-target-weight as hostnames.
>>>>>
>>>>> Can you attach a 'ceph osd crush tree' (or partial output) so I can see 
>>>>> what you mean?
>>>>
>>>> Sure - attached.
>>>
>>> Got it
>>>
>>>>>> Now the quesions are:
>>>>>> 1.) can we remove the tree? How?
>>>>>> 2.) Can we do this now or only after all clients are running Luminous?
>>>>>> 3.) is it enought to enable the mgr balancer module?
>>>
>>> First,
>>>
>>> ceph osd crush weight-set create-compat
>>>
>>> then for each osd,
>>> ceph osd crush weight-set reweight-compat <osd> <optimized-weight>
>>> ceph osd crush reweight <osd> <target-weight>
>>>
>>> That won't move any data but will keep your current optimized weights in 
>>> the compat weight-set where they belong.
>>>
>>> Then you can remove the *-target-weight buckets.  For each osd,
>>>
>>> ceph osd crush rm <osd> <ancestor>-target-weight
>>>
>>> and then for each remaining bucket
>>>
>>> ceph osd crush rm <foo>-target-weight
>>>
>>> Finally, turn on the balancer (or test it to see what it it wants to do 
>>> with the optimize command.)
>>>
>>> HTH!
>>> sage
>>
