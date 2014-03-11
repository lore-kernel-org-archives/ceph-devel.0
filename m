From: Loic Dachary <loic.dachary@cloudwatt.com>
Subject: Re: Erasure code properties in OSDMap
Date: Tue, 11 Mar 2014 15:03:28 +0100
Message-ID: <531F17B0.4080506@cloudwatt.com>
References: <531C5AD5.9060109@cloudwatt.com> <CAGd4Wr0_Bre-VXckOjkomoeyG8kCx9V_Q6CqSgYWDVhTAn2-sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.corp.cloudwatt.com ([46.231.129.137]:52618 "HELO
	mail.corp.cloudwatt.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752766AbaCKODg convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 11 Mar 2014 10:03:36 -0400
In-Reply-To: <CAGd4Wr0_Bre-VXckOjkomoeyG8kCx9V_Q6CqSgYWDVhTAn2-sg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@inktank.com>
Cc: Samuel Just <sam.just@inktank.com>, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 11/03/2014 13:21, John Spray wrote:
> From a high level view, what is the logical difference between the
> crush ruleset and the properties object?  I'm thinking about how this
> is exposed to users and tools, and it seems like both would be define=
d
> as "the settings about data placement and encoding".  I certainly
> understand the separation internally, I am just concerned about makin=
g
> the interface we expose upwards more complicated by adding a new type
> of object.
>
> Is there really a need for a new type of properties object, instead o=
f
> storing these properties under the existing ruleset ID?
These properties are used to configure the new feature that was introdu=
ced in Firefly : erasure coded pools. From a user point of view the sim=
plest would be to

ceph osd pool create mypool erasure

and rely on the fact that a default ruleset will be created using the d=
efault erasure code plugin with the default parameters.

If the sysadmin wants to tweak the K+M factors (s)he could:

ceph osd set properties myproperties k=3D10 m=3D4

and then

ceph osd pool create mypool erasure myproperties

which would implicitly ask the default erasure code plugin to create a =
ruleset named "mypool-ruleset" after configuring it with myproperties.

If the sysadmin wants to share rulesets between pools instead of relyin=
g on their implicit creation, (s)he could

ceph osd create-serasure myruleset myproperties

and then ceph osd set crush_ruleset as per usual. And if (s)he really w=
ants fine tuning, manually adding the ruleset is also possible.

I feel confortable explaining this but I'm probably much too familiar w=
ith the subject to be a good judge of what makes sense to someone new o=
r not ;-)

Cheers

>
> John
>
>
> On Sun, Mar 9, 2014 at 12:13 PM, Loic Dachary
> <loic.dachary@cloudwatt.com> wrote:
>> Hi Sage & Sam,
>>
>> I quickly sketched the replacement of the pg_pool_t::properties map =
with a OSDMap::properties list of maps at https://github.com/dachary/ce=
ph/commit/fe3819a62eb139fc3f0fa4282b4d22aecd8cd398 and explained how I =
see it at http://tracker.ceph.com/issues/7662#note-2
>>
>> It indeed makes things simpler, more consistent and easier to explai=
n. I can provide an implementation this week if this seems reasonable t=
o you.
>>
>> Cheers
>>
>> --
>> Lo=C4=8Fc Dachary, Senior Developer
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html


--=20
Lo=C3=AFc Dachary, Senior Developer

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
