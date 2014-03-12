From: John Spray <john.spray@inktank.com>
Subject: Re: Erasure code properties in OSDMap
Date: Wed, 12 Mar 2014 12:39:03 +0000
Message-ID: <CAGd4Wr1-effipjF4zCvT15YtC-XMpNvepeA+2L2EYPL5nBn=Wg@mail.gmail.com>
References: <531C5AD5.9060109@cloudwatt.com>
	<CAGd4Wr0_Bre-VXckOjkomoeyG8kCx9V_Q6CqSgYWDVhTAn2-sg@mail.gmail.com>
	<531F17B0.4080506@cloudwatt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:58158 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751843AbaCLMjE convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Mar 2014 08:39:04 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so1041772pbb.14
        for <ceph-devel@vger.kernel.org>; Wed, 12 Mar 2014 05:39:03 -0700 (PDT)
In-Reply-To: <531F17B0.4080506@cloudwatt.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic.dachary@cloudwatt.com>
Cc: Samuel Just <sam.just@inktank.com>, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

I am sure all of that will work, but it doesn't explain why these
properties must be stored and named separately to crush rulesets.  To
flesh this out one also needs "get" and "list" operations for the sets
of properties, which feels like overkill if there is an existing place
we could be storing these things.  The reason I'm taking such an
interest in what may seem something minor is that once this has been
added, we will be stuck with it for some time once external tools
start depending on the interface.

The ruleset-based approach doesn't have to be more complicated for CLI
users, we would essentially replace any "myproperties" above with a
ruleset name instead.

osd pool create mypool <pgnum> <pgpnum> <ruleset>
osd set ruleset-properties <ruleset> <key>=3D<val> [<key>=3D<val>...]

The simple default cases of "pool create mypool <pgnum> <pgpnum>
erasure" could be handled by making sure there exist default rulesets
called "erasure" and "replicated" rather than having these be magic
words to the commands that cause ruleset creation.  Rulesets currently
just have numbers instead of names, but it would be simpler to add
names to rulesets than to introduce a whole new type of object to the
interface.

John

On Tue, Mar 11, 2014 at 2:03 PM, Loic Dachary
<loic.dachary@cloudwatt.com> wrote:
> On 11/03/2014 13:21, John Spray wrote:
>> From a high level view, what is the logical difference between the
>> crush ruleset and the properties object?  I'm thinking about how thi=
s
>> is exposed to users and tools, and it seems like both would be defin=
ed
>> as "the settings about data placement and encoding".  I certainly
>> understand the separation internally, I am just concerned about maki=
ng
>> the interface we expose upwards more complicated by adding a new typ=
e
>> of object.
>>
>> Is there really a need for a new type of properties object, instead =
of
>> storing these properties under the existing ruleset ID?
> These properties are used to configure the new feature that was intro=
duced in Firefly : erasure coded pools. From a user point of view the s=
implest would be to
>
> ceph osd pool create mypool erasure
>
> and rely on the fact that a default ruleset will be created using the=
 default erasure code plugin with the default parameters.
>
> If the sysadmin wants to tweak the K+M factors (s)he could:
>
> ceph osd set properties myproperties k=3D10 m=3D4
>
> and then
>
> ceph osd pool create mypool erasure myproperties
>
> which would implicitly ask the default erasure code plugin to create =
a ruleset named "mypool-ruleset" after configuring it with myproperties=
=2E
>
> If the sysadmin wants to share rulesets between pools instead of rely=
ing on their implicit creation, (s)he could
>
> ceph osd create-serasure myruleset myproperties
>
> and then ceph osd set crush_ruleset as per usual. And if (s)he really=
 wants fine tuning, manually adding the ruleset is also possible.
>
> I feel confortable explaining this but I'm probably much too familiar=
 with the subject to be a good judge of what makes sense to someone new=
 or not ;-)
>
> Cheers
>
>>
>> John
>>
>>
>> On Sun, Mar 9, 2014 at 12:13 PM, Loic Dachary
>> <loic.dachary@cloudwatt.com> wrote:
>>> Hi Sage & Sam,
>>>
>>> I quickly sketched the replacement of the pg_pool_t::properties map=
 with a OSDMap::properties list of maps at https://github.com/dachary/c=
eph/commit/fe3819a62eb139fc3f0fa4282b4d22aecd8cd398 and explained how I=
 see it at http://tracker.ceph.com/issues/7662#note-2
>>>
>>> It indeed makes things simpler, more consistent and easier to expla=
in. I can provide an implementation this week if this seems reasonable =
to you.
>>>
>>> Cheers
>>>
>>> --
>>> Lo=C4=8Fc Dachary, Senior Developer
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
> --
> Lo=C3=AFc Dachary, Senior Developer
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
