From: Dan van der Ster <dan@vanderster.com>
Subject: Re: crush devices class types
Date: Wed, 8 Mar 2017 10:42:59 +0100
Message-ID: <CABZ+qqkNb8rAr27oKL3txJfY-OFjpF5vKXFCyRywEVvkzNXbgg@mail.gmail.com>
References: <e5fad669-da68-1287-7025-9c5e48d67601@dachary.org>
 <1971303930.7861.1485178720341@ox.pcextreme.nl> <alpine.DEB.2.11.1701231428190.3654@piezo.novalocal>
 <372c7fcb-8697-28ea-0d7c-1efc29fc21cf@dachary.org> <alpine.DEB.2.11.1702022047070.3654@piezo.novalocal>
 <2e591b25-3db2-2dd2-03af-2c1ef40292ac@dachary.org> <CALe9h7ds0PpqX-QJ0Usb-OLggPMCE2KF0tLurGfKFmms89nDiA@mail.gmail.com>
 <83ad191e-933f-83a4-c6d4-c831c1ac893f@dachary.org> <CALe9h7e-uOvQdO1GqNo6xpJ=QgoLyJ_ycgyP9c_Z_sXptHUJjg@mail.gmail.com>
 <8bf1e90e-20ca-e4e9-d3dd-3535b6a7d781@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:37872 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750713AbdCHKP7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Mar 2017 05:15:59 -0500
Received: by mail-wm0-f53.google.com with SMTP id n11so26619552wma.0
        for <ceph-devel@vger.kernel.org>; Wed, 08 Mar 2017 02:15:02 -0800 (PST)
Received: from mail-wm0-f46.google.com (mail-wm0-f46.google.com. [74.125.82.46])
        by smtp.gmail.com with ESMTPSA id q5sm3430645wrd.32.2017.03.08.01.43.40
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Mar 2017 01:43:40 -0800 (PST)
Received: by mail-wm0-f46.google.com with SMTP id t189so25903241wmt.1
        for <ceph-devel@vger.kernel.org>; Wed, 08 Mar 2017 01:43:40 -0800 (PST)
In-Reply-To: <8bf1e90e-20ca-e4e9-d3dd-3535b6a7d781@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Hi Loic,

Did you already have a plan for how an operator would declare the
device class of each OSD?
Would this be a new --device-class option to ceph-disk prepare, which
would perhaps create a device-class file in the root of the OSD's xfs
dir?
Then osd crush create-or-move in ceph-osd-prestart.sh would be a
combination of ceph.conf's "crush location" and this per-OSD file.

Cheers, Dan



On Wed, Feb 15, 2017 at 1:14 PM, Loic Dachary <loic@dachary.org> wrote:
> Hi John,
>
> Thanks for the discussion :-) I'll start implementing the proposal as des=
cribed originally.
>
> Cheers
>
> On 02/15/2017 12:57 PM, John Spray wrote:
>> On Fri, Feb 3, 2017 at 1:21 PM, Loic Dachary <loic@dachary.org> wrote:
>>>
>>>
>>> On 02/03/2017 01:46 PM, John Spray wrote:
>>>> On Fri, Feb 3, 2017 at 12:22 PM, Loic Dachary <loic@dachary.org> wrote=
:
>>>>> Hi,
>>>>>
>>>>> Reading Wido & John comments I thought of something, not sure if that=
's a good idea or not. Here it is anyway ;-)
>>>>>
>>>>> The device class problem we're trying to solve is one instance of a m=
ore general need to produce crush tables that implement a given use case. T=
he SSD / HDD use case is so frequent that it would make sense to modify the=
 crush format for this. But maybe we could instead implement that to be a c=
rush table generator.
>>>>>
>>>>> Let say you want help to create the hierarchies to implement the ssd/=
hdd separation, you write your crushmap using the proposed syntax. But inst=
ead of feeding it directly to crushtool -c, you would do something like:
>>>>>
>>>>>    crushtool --plugin 'device-class' --transform < mycrushmap.txt | c=
rushtool -c - -o mycrushmap
>>>>>
>>>>> The 'device-class' transformation documents the naming conventions so=
 the user knows root will generate root_ssd and root_hdd. And the users can=
 also check by themselves the generated crushmap.
>>>>>
>>>>> Cons:
>>>>>
>>>>> * the users need to be aware of the transformation step and be able t=
o read and understand the generated result.
>>>>> * it could look like it's not part of the standard way of doing thing=
s, that it's a hack.
>>>>>
>>>>> Pros:
>>>>>
>>>>> * it can inspire people to implement other crushmap transformation / =
generators (an alternative, simpler, syntax comes to mind ;-)
>>>>> * it can be implemented using python to lower the barrier of entry
>>>>>
>>>>> I don't think it makes the implementation of the current proposal any=
 simpler or more complex. Worst case scenario nobody write any plugin but t=
hat does not make this one plugin less useful.
>>>>
>>>> I think this is basically the alternative approach that Sam was
>>>> suggesting during CDM: the idea of layering a new (perhaps very
>>>> similar) syntax on top of the existing one, instead of extending the
>>>> existing one directly.
>>>
>>> Ha nice, not such a stupid idea then :-) I'll try to defend it a little=
 more below then. Please bear in mind that I'm not sure this is the way to =
go even though I'm writing as if I am.
>>>
>>>> The main argument against doing that was the complexity, not just of
>>>> implementation but for users, who would now potentially have two
>>>> separate sets of commands, one operating on the "high level" map
>>>> (which would have a "myhost" object in it), and one operating on the
>>>> native crush map (which would only have myhost~ssd, myhost~hdd
>>>> entries, and would have no concept that a thing called myhost
>>>> existed).
>>>
>>> As a user I'm not sure what is more complicated / confusing. If I'm an =
experienced Ceph user I'll think of this new syntax as a generator because =
I already know how crush works. I'll welcome the help and be relieved that =
I don't have to manually do that anymore. But having that as a native synta=
x may be a little unconfortable for me because I will want to verify the ne=
w syntax matches what I expect, which comes naturally if the transformation=
 step is separate. I may even tweak it a little with an intermediate script=
 to match one thing or two. If I'm a new Ceph user this is one more concept=
 I need to learn: the device class. And to understand what it means, the do=
cumentation will have to explain that it creates an independant crush hiera=
rchy for each device class, with weights that only take into account the de=
vices of that given class. I will not be exonerated from understanding the =
transformation step and the syntactic sugar may even make that more complic=
ated to get.
>>>
>>> If I understand correctly, the three would co-exist: host, host~ssd, ho=
st~hdd so that you can write a rule that takes from all devices.
>>
>> (Sorry this response is so late)
>>
>> I think the extra work is not so much in the formats, as it is
>> exposing that syntax via all the commands that we have, and/or new
>> commands.  We would either need two lots of commands, or we would need
>> to pick one layer (the 'generator' or the native one) for the
>> commands, and treat the other layer as a hidden thing.
>>
>> It's also not just the extra work of implementing the commands/syntax,
>> it's the extra complexity that ends up being exposed to users.
>>
>>>
>>>> As for implemetning other generators, the trouble with that is that
>>>> the resulting conventions would be unknown to other tools, and to any
>>>> commands built in to Ceph.
>>>
>>> Yes. But do we really want to insert the concept of "device class" in C=
eph ? There are recurring complaints about manually creating the crushmap r=
equired to separate ssd from hdd. But is it inconvenient in any way that Ce=
ph is otherwise unaware of this distinction ?
>>
>> Currently, if someone has done the manual stuff to set up SSD/HDD
>> crush trees, any external tool has no way of knowing that two hosts
>> (one ssd, one hdd) are actually the same host.  That's the key thing
>> here for me -- the time saving during setup is a nice side effect, but
>> the primary value of having a Ceph-defined way to do this is that
>> every tool building on Ceph can rely on it.
>>
>>
>>
>>>> We *really* need a variant of "set noout"
>>>> that operates on a crush subtree (typically a host), as it's the sane
>>>> way to get people to temporarily mark some OSDs while they
>>>> reboot/upgrade a host, but to implement that command we have to have
>>>> an unambiguous way of identifying which buckets in the crush map
>>>> belong to a host.  Whatever the convention is (myhost~ssd, myhost_ssd,
>>>> whatever), it needs to be defined and built into Ceph in order to be
>>>> interoperable.
>>>
>>> That goes back (above) to my understanding of Sage proposal (which I ma=
y have wrong ?) in which the host bucket still exists and still contains al=
l devices regardless of their class.
>>
>> In Sage's proposal as I understand it, there's an underlying native
>> crush map that uses today's format (i.e. clients need no upgrade),
>> which is generated in response to either commands that edit the map,
>> or the user inputting a modified map in the text format.  That
>> conversion would follow pretty simple rules (assuming a host 'myhost'
>> with ssd and hdd devices):
>>  * On the way in, bucket 'myhost' generates 'myhost~ssd', 'myhost~hdd' b=
uckets
>>  * On the way out, buckets 'myhost~ssd', 'myhost~hdd' get merged into 'm=
yhost'
>>  * When running a CLI command, something targeting 'myhost' will
>> target both 'myhost~hdd' and 'myhost~ssd'
>>
>> It's that last part that probably isn't captured properly by something
>> external that does a syntax conversion during import/export.
>>
>> John
>>
>>> Cheers
>>>
>>>>
>>>> John
>>>>
>>>>
>>>>
>>>>> Cheers
>>>>>
>>>>> On 02/02/2017 09:57 PM, Sage Weil wrote:
>>>>>> Hi everyone,
>>>>>>
>>>>>> I made more updates to http://pad.ceph.com/p/crush-types after the C=
DM
>>>>>> discussion yesterday:
>>>>>>
>>>>>> - consolidated notes into a single proposal
>>>>>> - use otherwise illegal character (e.g., ~) as separater for generat=
ed
>>>>>> buckets.  This avoids ambiguity with user-defined buckets.
>>>>>> - class-id $class $id properties for each bucket.  This allows us to
>>>>>> preserve the derivative bucket ids across a decompile->compile cycle=
 so
>>>>>> that data does not move (the bucket id is one of many inputs into cr=
ush's
>>>>>> hash during placement).
>>>>>> - simpler rule syntax:
>>>>>>
>>>>>>     rule ssd {
>>>>>>             ruleset 1
>>>>>>             step take default class ssd
>>>>>>             step chooseleaf firstn 0 type host
>>>>>>             step emit
>>>>>>     }
>>>>>>
>>>>>> My rationale here is that we don't want to make this a separate 'ste=
p'
>>>>>> call since steps map to underlying crush rule step ops, and this is =
a
>>>>>> directive only to the compiler.  Making it an optional step argument=
 seems
>>>>>> like the cleanest way to do that.
>>>>>>
>>>>>> Any other comments before we kick this off?
>>>>>>
>>>>>> Thanks!
>>>>>> sage
>>>>>>
>>>>>>
>>>>>> On Mon, 23 Jan 2017, Loic Dachary wrote:
>>>>>>
>>>>>>> Hi Wido,
>>>>>>>
>>>>>>> Updated http://pad.ceph.com/p/crush-types with your proposal for th=
e rule syntax
>>>>>>>
>>>>>>> Cheers
>>>>>>>
>>>>>>> On 01/23/2017 03:29 PM, Sage Weil wrote:
>>>>>>>> On Mon, 23 Jan 2017, Wido den Hollander wrote:
>>>>>>>>>> Op 22 januari 2017 om 17:44 schreef Loic Dachary <loic@dachary.o=
rg>:
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Hi Sage,
>>>>>>>>>>
>>>>>>>>>> You proposed an improvement to the crush map to address differen=
t device types (SSD, HDD, etc.)[1]. When learning how to create a crush map=
, I was indeed confused by the tricks required to create SSD only pools. Af=
ter years of practice it feels more natural :-)
>>>>>>>>>>
>>>>>>>>>> The source of my confusion was mostly because I had to use a hie=
rarchical description to describe something that is not organized hierarchi=
cally. "The rack contains hosts that contain devices" is intuitive. "The ra=
ck contains hosts that contain ssd that contain devices" is counter intuiti=
ve. Changing:
>>>>>>>>>>
>>>>>>>>>>     # devices
>>>>>>>>>>     device 0 osd.0
>>>>>>>>>>     device 1 osd.1
>>>>>>>>>>     device 2 osd.2
>>>>>>>>>>     device 3 osd.3
>>>>>>>>>>
>>>>>>>>>> into:
>>>>>>>>>>
>>>>>>>>>>     # devices
>>>>>>>>>>     device 0 osd.0 ssd
>>>>>>>>>>     device 1 osd.1 ssd
>>>>>>>>>>     device 2 osd.2 hdd
>>>>>>>>>>     device 3 osd.3 hdd
>>>>>>>>>>
>>>>>>>>>> where ssd/hdd is the device class would be much better. However,=
 using the device class like so:
>>>>>>>>>>
>>>>>>>>>>     rule ssd {
>>>>>>>>>>             ruleset 1
>>>>>>>>>>             type replicated
>>>>>>>>>>             min_size 1
>>>>>>>>>>             max_size 10
>>>>>>>>>>             step take default:ssd
>>>>>>>>>>             step chooseleaf firstn 0 type host
>>>>>>>>>>             step emit
>>>>>>>>>>     }
>>>>>>>>>>
>>>>>>>>>> looks arcane. Since the goal is to simplify the description for =
the first time user, maybe we could have something like:
>>>>>>>>>>
>>>>>>>>>>     rule ssd {
>>>>>>>>>>             ruleset 1
>>>>>>>>>>             type replicated
>>>>>>>>>>             min_size 1
>>>>>>>>>>             max_size 10
>>>>>>>>>>             device class =3D ssd
>>>>>>>>>
>>>>>>>>> Would that be sane?
>>>>>>>>>
>>>>>>>>> Why not:
>>>>>>>>>
>>>>>>>>> step set-class ssd
>>>>>>>>> step take default
>>>>>>>>> step chooseleaf firstn 0 type host
>>>>>>>>> step emit
>>>>>>>>>
>>>>>>>>> Since it's a 'step' you take, am I right?
>>>>>>>>
>>>>>>>> Good idea... a step is a cleaner way to extend the syntax!
>>>>>>>>
>>>>>>>> sage
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>
>>>>>>> --
>>>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>>>> --
>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>
>>>>>
>>>>> --
>>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> --
>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
