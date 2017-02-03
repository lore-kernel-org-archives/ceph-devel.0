From: Loic Dachary <loic@dachary.org>
Subject: Re: crush devices class types
Date: Fri, 3 Feb 2017 13:22:14 +0100
Message-ID: <2e591b25-3db2-2dd2-03af-2c1ef40292ac@dachary.org>
References: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org>
 <1971303930.7861.1485178720341@ox.pcextreme.nl>
 <alpine.DEB.2.11.1701231428190.3654@piezo.novalocal>
 <372c7fcb-8697-28ea-0d7c-1efc29fc21cf@dachary.org>
 <alpine.DEB.2.11.1702022047070.3654@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:56048 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbdBCMWs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2017 07:22:48 -0500
In-Reply-To: <alpine.DEB.2.11.1702022047070.3654@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

Reading Wido & John comments I thought of something, not sure if that's a good idea or not. Here it is anyway ;-)

The device class problem we're trying to solve is one instance of a more general need to produce crush tables that implement a given use case. The SSD / HDD use case is so frequent that it would make sense to modify the crush format for this. But maybe we could instead implement that to be a crush table generator.

Let say you want help to create the hierarchies to implement the ssd/hdd separation, you write your crushmap using the proposed syntax. But instead of feeding it directly to crushtool -c, you would do something like:

   crushtool --plugin 'device-class' --transform < mycrushmap.txt | crushtool -c - -o mycrushmap

The 'device-class' transformation documents the naming conventions so the user knows root will generate root_ssd and root_hdd. And the users can also check by themselves the generated crushmap.

Cons:

* the users need to be aware of the transformation step and be able to read and understand the generated result.
* it could look like it's not part of the standard way of doing things, that it's a hack. 

Pros:

* it can inspire people to implement other crushmap transformation / generators (an alternative, simpler, syntax comes to mind ;-)
* it can be implemented using python to lower the barrier of entry

I don't think it makes the implementation of the current proposal any simpler or more complex. Worst case scenario nobody write any plugin but that does not make this one plugin less useful.

Cheers

On 02/02/2017 09:57 PM, Sage Weil wrote:
> Hi everyone,
> 
> I made more updates to http://pad.ceph.com/p/crush-types after the CDM 
> discussion yesterday:
> 
> - consolidated notes into a single proposal
> - use otherwise illegal character (e.g., ~) as separater for generated 
> buckets.  This avoids ambiguity with user-defined buckets.
> - class-id $class $id properties for each bucket.  This allows us to 
> preserve the derivative bucket ids across a decompile->compile cycle so 
> that data does not move (the bucket id is one of many inputs into crush's 
> hash during placement).
> - simpler rule syntax:
> 
>     rule ssd {
>             ruleset 1
>             step take default class ssd
>             step chooseleaf firstn 0 type host
>             step emit
>     }
> 
> My rationale here is that we don't want to make this a separate 'step' 
> call since steps map to underlying crush rule step ops, and this is a 
> directive only to the compiler.  Making it an optional step argument seems 
> like the cleanest way to do that.
> 
> Any other comments before we kick this off?
> 
> Thanks!
> sage
> 
> 
> On Mon, 23 Jan 2017, Loic Dachary wrote:
> 
>> Hi Wido,
>>
>> Updated http://pad.ceph.com/p/crush-types with your proposal for the rule syntax
>>
>> Cheers
>>
>> On 01/23/2017 03:29 PM, Sage Weil wrote:
>>> On Mon, 23 Jan 2017, Wido den Hollander wrote:
>>>>> Op 22 januari 2017 om 17:44 schreef Loic Dachary <loic@dachary.org>:
>>>>>
>>>>>
>>>>> Hi Sage,
>>>>>
>>>>> You proposed an improvement to the crush map to address different device types (SSD, HDD, etc.)[1]. When learning how to create a crush map, I was indeed confused by the tricks required to create SSD only pools. After years of practice it feels more natural :-)
>>>>>
>>>>> The source of my confusion was mostly because I had to use a hierarchical description to describe something that is not organized hierarchically. "The rack contains hosts that contain devices" is intuitive. "The rack contains hosts that contain ssd that contain devices" is counter intuitive. Changing:
>>>>>
>>>>>     # devices
>>>>>     device 0 osd.0
>>>>>     device 1 osd.1
>>>>>     device 2 osd.2
>>>>>     device 3 osd.3
>>>>>
>>>>> into:
>>>>>
>>>>>     # devices
>>>>>     device 0 osd.0 ssd
>>>>>     device 1 osd.1 ssd
>>>>>     device 2 osd.2 hdd
>>>>>     device 3 osd.3 hdd
>>>>>
>>>>> where ssd/hdd is the device class would be much better. However, using the device class like so:
>>>>>
>>>>>     rule ssd {
>>>>>             ruleset 1
>>>>>             type replicated
>>>>>             min_size 1
>>>>>             max_size 10
>>>>>             step take default:ssd
>>>>>             step chooseleaf firstn 0 type host
>>>>>             step emit
>>>>>     }
>>>>>
>>>>> looks arcane. Since the goal is to simplify the description for the first time user, maybe we could have something like:
>>>>>
>>>>>     rule ssd {
>>>>>             ruleset 1
>>>>>             type replicated
>>>>>             min_size 1
>>>>>             max_size 10
>>>>>             device class = ssd
>>>>
>>>> Would that be sane?
>>>>
>>>> Why not:
>>>>
>>>> step set-class ssd
>>>> step take default
>>>> step chooseleaf firstn 0 type host
>>>> step emit
>>>>
>>>> Since it's a 'step' you take, am I right?
>>>
>>> Good idea... a step is a cleaner way to extend the syntax!
>>>
>>> sage
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>> -- 
>> Loïc Dachary, Artisan Logiciel Libre
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

-- 
Loïc Dachary, Artisan Logiciel Libre
