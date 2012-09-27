From: hemant surale <hemant.surale@gmail.com>
Subject: How to direct data inject to specific OSDs
Date: Thu, 27 Sep 2012 16:22:44 +0530
Message-ID: <CAGfy=6ktXBkVQkZ=Z9ODAmWm9cCVu=7nsGOeDE2CvNEdAGK75w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:49122 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755846Ab2I0Kwo (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 06:52:44 -0400
Received: by qchd3 with SMTP id d3so896666qch.19
        for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 03:52:44 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Mick <dan.mick@inktank.com>
Cc: Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

Sir,
I have upgraded my cluster to Ceph v0.48. and cluster is fine (except
gceph not working) .

How can I direct my data inject to specific osds ?
i tried to edit crushmap & tired to specify ruleset accordingly , But
its not working ( I did same for Ceph v0.36 it worked )

-----------------------------------------------------------------------//crushmap-----------------------------------
# begin crush map

# devices
device 0 osd.0
device 1 osd.1

# types
type 0 osd
type 1 host
type 2 rack
type 3 row
type 4 room
type 5 datacenter
type 6 pool
type 7 ghost

# buckets
host atish-virtual-machine {
        id -2           # do not change unnecessarily
        # weight 1.000
        alg straw
        hash 0  # rjenkins1
        item osd.0 weight 1.000
}
ghost bob-virtual-machine {
        id -4           # do not change unnecessarily
        # weight 1.000
        alg straw
        hash 0  # rjenkins1
        item osd.1 weight 1.000
}
rack unknownrack {
        id -3           # do not change unnecessarily
        # weight 2.000
        alg straw
        hash 0  # rjenkins1
        item atish-virtual-machine weight 1.000
        item bob-virtual-machine weight 1.000
}
pool default {
        id -1           # do not change unnecessarily
        # weight 2.000
        alg straw
        hash 0  # rjenkins1
        item unknownrack weight 2.000
}

# rules
rule data {
        ruleset 0
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}
rule metadata {
        ruleset 1
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}
rule rbd {
        ruleset 2
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type host
        step emit
}
rule newbyh {
        ruleset 3
        type replicated
        min_size 1
        max_size 10
        step take default
        step chooseleaf firstn 0 type ghost
        step emit
}


# end crush map
---------------------------------------------//EOF-------------------------------------------------------------------------
I've created new pool "new" set its replication factor to 1 & also set
crush_ruleset property to 3 .I was expecting ceph to select osd.1 i.e.
bob-virtual-machine but some(Obj1,Obj2) Objects are placed into osd.0
(atish-V-M) and some(Obj3) was placed in osd.1. Does my crushmap have
errors ? Or I am missing the direction ?


-
Hemant Surale





On Thu, Sep 27, 2012 at 10:56 AM, hemant surale <hemant.surale@gmail.com> wrote:
> Sure Sir !  :)
>
>
> On Thu, Sep 27, 2012 at 10:50 AM, Dan Mick <dan.mick@inktank.com> wrote:
>> OK.  Let us know if osd map ends up working out for you.
>>
>>
>> On 09/26/2012 10:18 PM, hemant surale wrote:
>>>
>>> Sir,
>>>     I am now upgrading to latest version of ceph. I was using 0.36
>>> because it was running fine on 3 node cluster & i was really afraid of
>>> problem could pop up , But learning is something that consists of
>>> problem solving . So np.
>>>
>>> -
>>> Hemant Surale.
>>>
>>> On Thu, Sep 27, 2012 at 10:38 AM, Dan Mick <dan.mick@inktank.com> wrote:
>>>>
>>>> 0.36??  That is *very* old.  Is there a good reason not to upgrade?
>>>>
>>>>
>>>> On 09/26/2012 07:31 PM, hemant surale wrote:
>>>>>
>>>>>
>>>>> Sir,
>>>>>      I am using Ceph v0.36 . May be thats the reason after executing cmd
>>>>> told by you execution goes like this
>>>>>
>>>>>
>>>>> ---------------------------------------------
>>>>> root@third-virtual-machine:~# ceph osd map newbyh Obj1
>>>>> 2012-09-26 12:17:49.900514 mon <- [osd,map,newbyh,Obj1]
>>>>> 2012-09-26 12:17:49.900977 mon0 -> 'unknown command map' (-22)
>>>>> ----------------------------------------------
>>>>>
>>>>>
>>>>>
>>>>> -
>>>>> Hemant Surale.
>>>>>
>>>>>
>>>>> On Thu, Sep 27, 2012 at 3:23 AM, Dan Mick <dan.mick@inktank.com> wrote:
>>>>>>
>>>>>>
>>>>>> Ah, yeah, that assumption would be a problem.
>>>>>>
>>>>>> So, Hemant, does
>>>>>>           ceph osd dump <poolname> <objectname>
>>>>>>
>>>>>> show you information that makes sense?
>>>>>>
>>>>>>
>>>>>> On 09/26/2012 08:21 AM, Sage Weil wrote:
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> On Wed, 26 Sep 2012, hemant surale wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> Hi Dan ,
>>>>>>>>         I have set replication factor to 3 of pool 'newbyh' . Then
>>>>>>>> when
>>>>>>>> i
>>>>>>>> tried to execute cmds told by you I got that it reported like
>>>>>>>>
>>>>>>>> ----------------------------------------------------
>>>>>>>> root@third-virtual-machine:~# osdmaptool --test-map-object Obj1
>>>>>>>> osdmap
>>>>>>>> osdmaptool: osdmap file 'osdmap'
>>>>>>>>     object 'Obj1' -> 0.c3c4 -> [0,1]
>>>>>>>> -----------------------------------------------------
>>>>>>>>
>>>>>>>> I even checked manually the dirs at every node . it shows proper data
>>>>>>>> available within osd0,osd1 & osd2 . ( i hve 3 node cluster using VM
>>>>>>>> Ceph v0.36 )
>>>>>>>>
>>>>>>>> So my questions is why in above execution it shows that Obj1 is at
>>>>>>>> [0,1] .. it should report all nodes like [0,1,2] .
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>>
>>>>>>> The --test-map-object is currently somewhat useless because it assumes
>>>>>>> pool 0 ('data'), and your object is probably in a different pool.
>>>>>>>
>>>>>>> sage
>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> -
>>>>>>>> Hemant Surale.
>>>>>>>>
>>>>>>>> On Wed, Sep 26, 2012 at 2:04 AM, Dan Mick <dan.mick@inktank.com>
>>>>>>>> wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> Hemant:
>>>>>>>>>
>>>>>>>>> Yes, you can.  Use ceph osd getmap -o <file> to get the OSD map, and
>>>>>>>>> then
>>>>>>>>> use osdmaptool --find-object-map <objectname> <file> to output the
>>>>>>>>> PG the object hashes to and the list of OSDs that PG maps to
>>>>>>>>> (primary
>>>>>>>>> first):
>>>>>>>>>
>>>>>>>>> $ ceph osd getmap -o osdmap
>>>>>>>>> got osdmap epoch 59
>>>>>>>>> $ osdmaptool --test-map-object dmick.rbd osdmap
>>>>>>>>> osdmaptool: osdmap file 'osdmap'
>>>>>>>>>     object 'dmick.rbd' -> 0.69c8 -> [3,1]
>>>>>>>>>
>>>>>>>>> shows dmick.rbd mapping to pg 0.69c8, which in turn maps to OSDs 3
>>>>>>>>> and
>>>>>>>>> 1, 3
>>>>>>>>> being the primary.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 09/25/2012 02:30 AM, hemant surale wrote:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hi Community,
>>>>>>>>>>               Is it possible to identify where exactly primary copy
>>>>>>>>>> of
>>>>>>>>>> obj
>>>>>>>>>> is stored ? I am using crushmaps to use specific osds for data
>>>>>>>>>> placement but i want to knw the primary capoy location. Or I need
>>>>>>>>>> to
>>>>>>>>>> replace pseudo random function by some deterministic function to
>>>>>>>>>> guide
>>>>>>>>>> ceph to utilize specific osd?
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Regards,
>>>>>>>>>> Hemant Surale.
>>>>>>>>>> --
>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe
>>>>>>>>>> ceph-devel"
>>>>>>>>>> in
>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>
>>>>>>>>>
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
>>>>>>>> in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>>
>>>>>>
>>>>
>>
