From: Dan Mick <dan.mick@inktank.com>
Subject: Re: Ho to identify location of Primary Copy Of Obj ?
Date: Wed, 26 Sep 2012 14:53:27 -0700
Message-ID: <50637957.2070800@inktank.com>
References: <CAGfy=6mvjOUh8jV8EaSZXK=o-6+a5fdFTvNF6WrXcqmF4mwRog@mail.gmail.com> <50621552.2050900@inktank.com> <CAGfy=6=6r0htUQUcCHj-74-Xi+bDvPNyXjLaFcHt3QNNq-zfgg@mail.gmail.com> <alpine.DEB.2.00.1209260820440.17083@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:54714 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750895Ab2IZVxa (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 26 Sep 2012 17:53:30 -0400
Received: by padhz1 with SMTP id hz1so780332pad.19
        for <ceph-devel@vger.kernel.org>; Wed, 26 Sep 2012 14:53:30 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1209260820440.17083@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: hemant surale <hemant.surale@gmail.com>
Cc: ceph-devel@vger.kernel.org

Ah, yeah, that assumption would be a problem.

So, Hemant, does
	ceph osd dump <poolname> <objectname>

show you information that makes sense?

On 09/26/2012 08:21 AM, Sage Weil wrote:
> On Wed, 26 Sep 2012, hemant surale wrote:
>> Hi Dan ,
>>       I have set replication factor to 3 of pool 'newbyh' . Then when i
>> tried to execute cmds told by you I got that it reported like
>>
>> ----------------------------------------------------
>> root@third-virtual-machine:~# osdmaptool --test-map-object Obj1 osdmap
>> osdmaptool: osdmap file 'osdmap'
>>   object 'Obj1' -> 0.c3c4 -> [0,1]
>> -----------------------------------------------------
>>
>> I even checked manually the dirs at every node . it shows proper data
>> available within osd0,osd1 & osd2 . ( i hve 3 node cluster using VM
>> Ceph v0.36 )
>>
>> So my questions is why in above execution it shows that Obj1 is at
>> [0,1] .. it should report all nodes like [0,1,2] .
>
> The --test-map-object is currently somewhat useless because it assumes
> pool 0 ('data'), and your object is probably in a different pool.
>
> sage
>
>>
>>
>>
>> -
>> Hemant Surale.
>>
>> On Wed, Sep 26, 2012 at 2:04 AM, Dan Mick <dan.mick@inktank.com> wrote:
>>> Hemant:
>>>
>>> Yes, you can.  Use ceph osd getmap -o <file> to get the OSD map, and then
>>> use osdmaptool --find-object-map <objectname> <file> to output the
>>> PG the object hashes to and the list of OSDs that PG maps to (primary
>>> first):
>>>
>>> $ ceph osd getmap -o osdmap
>>> got osdmap epoch 59
>>> $ osdmaptool --test-map-object dmick.rbd osdmap
>>> osdmaptool: osdmap file 'osdmap'
>>>   object 'dmick.rbd' -> 0.69c8 -> [3,1]
>>>
>>> shows dmick.rbd mapping to pg 0.69c8, which in turn maps to OSDs 3 and 1, 3
>>> being the primary.
>>>
>>>
>>> On 09/25/2012 02:30 AM, hemant surale wrote:
>>>>
>>>> Hi Community,
>>>>             Is it possible to identify where exactly primary copy of obj
>>>> is stored ? I am using crushmaps to use specific osds for data
>>>> placement but i want to knw the primary capoy location. Or I need to
>>>> replace pseudo random function by some deterministic function to guide
>>>> ceph to utilize specific osd?
>>>>
>>>>
>>>> Regards,
>>>> Hemant Surale.
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>>
