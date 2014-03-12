From: John Spray <john.spray@inktank.com>
Subject: Re: Erasure code properties in OSDMap
Date: Wed, 12 Mar 2014 14:35:40 +0000
Message-ID: <CAGd4Wr36gcFPTpkkkz2DY=DsLiTTxVweNJ3wRWjXe7hccLH9zQ@mail.gmail.com>
References: <531C5AD5.9060109@cloudwatt.com>
	<CAGd4Wr0_Bre-VXckOjkomoeyG8kCx9V_Q6CqSgYWDVhTAn2-sg@mail.gmail.com>
	<531F17B0.4080506@cloudwatt.com>
	<CAGd4Wr1-effipjF4zCvT15YtC-XMpNvepeA+2L2EYPL5nBn=Wg@mail.gmail.com>
	<53205CC1.20401@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:60028 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754630AbaCLOfl convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 10:35:41 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so1188420pbb.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 07:35:40 -0700 (PDT)
In-Reply-To: <53205CC1.20401@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

OK, in chatting about this I've been convinced that it's legitimately
separate, because the CRUSH ruleset is mutable during the lifetime of
a pool but the EC settings are not.  I suppose the way we could
explain the logical separation for users is to say that the CRUSH
ruleset is mainly about location selection, whereas the EC settings
tell you about encoding within those locations.

Can we call this something more descriptive like "EC profile" to avoid
confusion?  "properties" is very generic.

Cheers,
John



On Wed, Mar 12, 2014 at 1:10 PM, Loic Dachary <loic@dachary.org> wrote:
> On 12/03/2014 13:39, John Spray wrote:
>> I am sure all of that will work, but it doesn't explain why these
>> properties must be stored and named separately to crush rulesets.  T=
o
>> flesh this out one also needs "get" and "list" operations for the se=
ts
>> of properties, which feels like overkill if there is an existing pla=
ce
>> we could be storing these things.  The reason I'm taking such an
>> interest in what may seem something minor is that once this has been
>> added, we will be stuck with it for some time once external tools
>> start depending on the interface.
>>
>> The ruleset-based approach doesn't have to be more complicated for C=
LI
>> users, we would essentially replace any "myproperties" above with a
>> ruleset name instead.
>>
>> osd pool create mypool <pgnum> <pgpnum> <ruleset>
>> osd set ruleset-properties <ruleset> <key>=3D<val> [<key>=3D<val>...=
]
>>
>> The simple default cases of "pool create mypool <pgnum> <pgpnum>
>> erasure" could be handled by making sure there exist default ruleset=
s
>> called "erasure" and "replicated" rather than having these be magic
>> words to the commands that cause ruleset creation.  Rulesets current=
ly
>> just have numbers instead of names, but it would be simpler to add
>> names to rulesets than to introduce a whole new type of object to th=
e
>> interface.
> Here are the default parameters
>
> OPTION(osd_pool_default_erasure_code_properties,
>        OPT_STR,
>        "erasure-code-plugin=3Djerasure "
>        "erasure-code-technique=3Dreed_sol_van "
>        "erasure-code-k=3D4 "
>        "erasure-code-m=3D2 "
>        ) // default properties of osd pool create
>
> The k and m parameters have a clear relationship with the pool size. =
And they also define the minimum number of items the crush ruleset must=
 be able to provide. The other parameters relate to the code/decode fun=
ctions and are better understood in the context of the OSD than crush. =
This is the reason why I don't see these properties as being exclusivel=
y linked to the crush ruleset or the OSD. By introducing a new set of p=
roperties associated to the erasure code feature there is no need to ch=
ose.
>
> Does that make sense ?
>>
>> John
>>
>> On Tue, Mar 11, 2014 at 2:03 PM, Loic Dachary
>> <loic.dachary@cloudwatt.com> wrote:
>>> On 11/03/2014 13:21, John Spray wrote:
>>>> From a high level view, what is the logical difference between the
>>>> crush ruleset and the properties object?  I'm thinking about how t=
his
>>>> is exposed to users and tools, and it seems like both would be def=
ined
>>>> as "the settings about data placement and encoding".  I certainly
>>>> understand the separation internally, I am just concerned about ma=
king
>>>> the interface we expose upwards more complicated by adding a new t=
ype
>>>> of object.
>>>>
>>>> Is there really a need for a new type of properties object, instea=
d of
>>>> storing these properties under the existing ruleset ID?
>>> These properties are used to configure the new feature that was int=
roduced in Firefly : erasure coded pools. From a user point of view the=
 simplest would be to
>>>
>>> ceph osd pool create mypool erasure
>>>
>>> and rely on the fact that a default ruleset will be created using t=
he default erasure code plugin with the default parameters.
>>>
>>> If the sysadmin wants to tweak the K+M factors (s)he could:
>>>
>>> ceph osd set properties myproperties k=3D10 m=3D4
>>>
>>> and then
>>>
>>> ceph osd pool create mypool erasure myproperties
>>>
>>> which would implicitly ask the default erasure code plugin to creat=
e a ruleset named "mypool-ruleset" after configuring it with myproperti=
es.
>>>
>>> If the sysadmin wants to share rulesets between pools instead of re=
lying on their implicit creation, (s)he could
>>>
>>> ceph osd create-serasure myruleset myproperties
>>>
>>> and then ceph osd set crush_ruleset as per usual. And if (s)he real=
ly wants fine tuning, manually adding the ruleset is also possible.
>>>
>>> I feel confortable explaining this but I'm probably much too famili=
ar with the subject to be a good judge of what makes sense to someone n=
ew or not ;-)
>>>
>>> Cheers
>>>
>>>> John
>>>>
>>>>
>>>> On Sun, Mar 9, 2014 at 12:13 PM, Loic Dachary
>>>> <loic.dachary@cloudwatt.com> wrote:
>>>>> Hi Sage & Sam,
>>>>>
>>>>> I quickly sketched the replacement of the pg_pool_t::properties m=
ap with a OSDMap::properties list of maps at https://github.com/dachary=
/ceph/commit/fe3819a62eb139fc3f0fa4282b4d22aecd8cd398 and explained how=
 I see it at http://tracker.ceph.com/issues/7662#note-2
>>>>>
>>>>> It indeed makes things simpler, more consistent and easier to exp=
lain. I can provide an implementation this week if this seems reasonabl=
e to you.
>>>>>
>>>>> Cheers
>>>>>
>>>>> --
>>>>> Lo=C4=8Fc Dachary, Senior Developer
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-de=
vel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.htm=
l
>>>
>>> --
>>> Lo=C3=AFc Dachary, Senior Developer
>>>
>
>
> --
> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
